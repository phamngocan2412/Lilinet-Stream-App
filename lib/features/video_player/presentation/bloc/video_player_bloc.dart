import 'dart:async';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/streaming_config.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../../core/services/cast_service.dart';
import '../../../../core/services/download_service.dart';
import '../../../movies/domain/entities/streaming_response.dart';
import '../../../movies/domain/usecases/get_streaming_links.dart';
import '../../../movies/domain/usecases/get_available_servers.dart';
import '../../../../features/settings/domain/repositories/settings_repository.dart';
import '../../../../features/settings/domain/entities/app_settings.dart';
import 'video_player_event.dart';
import 'video_player_state.dart';
import 'streaming_state.dart';

@lazySingleton
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoPlayerService _videoPlayerService;
  final CastService _castService;
  final DownloadService _downloadService;
  final GetStreamingLinks _getStreamingLinks;
  final GetAvailableServers _getAvailableServers;
  final SettingsRepository _settingsRepository;

  // Cancel token for active requests
  bool _isCancelled = false;
  int _activeRequestCount = 0;
  int _currentRequestId = 0;

  // Cache available servers for current episode
  List<String>? _cachedAvailableServers;

  // Cache preloaded links for next episode
  final Map<String, StreamingResponse> _preloadedLinks = {};
  final Map<String, String> _preloadedServers = {};

  VideoPlayerBloc(
    this._videoPlayerService,
    this._castService,
    this._downloadService,
    this._getStreamingLinks,
    this._getAvailableServers,
    this._settingsRepository,
  ) : super(const VideoPlayerState()) {
    on<PlayVideo>(_onPlayVideo);
    on<LoadVideo>(_onLoadVideo);
    on<TogglePlayPause>(_onTogglePlayPause);
    on<PauseVideoPlayback>(_onPauseVideoPlayback);
    on<ResumeVideoPlayback>(_onResumeVideoPlayback);
    on<SeekVideo>(_onSeekVideo);
    on<SetPlaybackSpeed>(_onSetPlaybackSpeed);
    on<MinimizeVideo>(_onMinimizeVideo);
    on<MaximizeVideo>(_onMaximizeVideo);
    on<EnterPiP>(_onEnterPiP);
    on<CloseVideo>(_onCloseVideo);
    on<StartCast>(_onStartCast);
    on<DownloadCurrentVideo>(_onDownloadCurrentVideo);
    on<SwitchServer>(_onSwitchServer);
    on<RetryStreaming>(_onRetryStreaming);
    on<UpdateMovieDetails>(_onUpdateMovieDetails);
    on<SwitchQuality>(_onSwitchQuality);
    on<PreloadNextEpisode>(_onPreloadNextEpisode);
  }

  static VideoPlayerState get initialState => const VideoPlayerState();

  VideoPlayerService get videoService => _videoPlayerService;

  Future<void> _onPlayVideo(
    PlayVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint(
      '🎬 VideoPlayerBloc: PlayVideo event received for ${event.title}',
    );

    emit(
      state.copyWith(
        status: VideoPlayerStatus.expanded,
        episodeId: event.episodeId,
        mediaId: event.mediaId,
        title: event.title,
        posterUrl: event.posterUrl,
        episodeTitle: event.episodeTitle,
        startPosition: event.startPosition,
        mediaType: event.mediaType,
        movie: event.movie,
        streamingState: const StreamingState.loading(),
      ),
    );

    // Fetch settings to get preferred server
    PreferredServer preferredServer = PreferredServer.auto;
    final settingsResult = await _settingsRepository.getSettings();
    settingsResult.fold(
      (l) {}, // Use default
      (settings) {
        preferredServer = settings.preferredServer;
      },
    );

    await _loadStreamingLinks(
      emit,
      episodeId: event.episodeId,
      mediaId: event.mediaId,
      provider: event.movie?.provider ?? 'flixhq',
      startPosition: event.startPosition,
      preferredServer: preferredServer,
    );
  }

  Future<void> _onPreloadNextEpisode(
    PreloadNextEpisode event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint(
      '📦 VideoPlayerBloc: Preloading next episode ${event.episodeId}',
    );

    // Use default provider if not specified
    final provider = event.provider ?? StreamingConfig.defaultProvider;

    // Fetch settings if preferred server not provided
    PreferredServer preferredServer =
        event.preferredServer ?? PreferredServer.auto;

    if (event.preferredServer == null) {
      final settingsResult = await _settingsRepository.getSettings();
      settingsResult.fold(
        (l) {}, // Use default
        (settings) {
          preferredServer = settings.preferredServer;
        },
      );
    }

    // Get ordered servers list based on preference
    final servers = _getServersWithPreferred(preferredServer);

    await _tryProvider(
      emit,
      provider,
      event.episodeId,
      event.mediaId,
      null,
      servers,
      requestId: _currentRequestId,
      emitState: false,
      onPreloaded: (response, server) {
        debugPrint(
          '📦 VideoPlayerBloc: Preload successful for ${event.episodeId} on $server',
        );
        _preloadedLinks[event.episodeId] = response;
        _preloadedServers[event.episodeId] = server;
      },
    );
  }

  /// Cancel all pending requests
  void cancelPendingRequests() {
    _isCancelled = true;
    _currentRequestId++;
    if (kDebugMode) {
      debugPrint(
        '🛑 VideoPlayerBloc: Cancelling $_activeRequestCount pending requests',
      );
    }
  }

  /// Check if request was cancelled
  bool get isCancelled => _isCancelled;

  bool _isRequestStale(int requestId) {
    return isClosed || _isCancelled || requestId != _currentRequestId;
  }

  /// Get servers list with preferred server first
  List<String> _getServersWithPreferred(PreferredServer? preferred) {
    final defaultServers = StreamingConfig.defaultServers;

    if (preferred == null || preferred == PreferredServer.auto) {
      return defaultServers;
    }

    final preferredName = preferred.name;
    // Put preferred server first, then others
    return [preferredName, ...defaultServers.where((s) => s != preferredName)];
  }

  Future<void> _loadStreamingLinks(
    Emitter<VideoPlayerState> emit, {
    required String episodeId,
    required String mediaId,
    required String provider,
    String? server,
    Duration? startPosition,
    PreferredServer? preferredServer,
  }) async {
    // Reset cancellation flag for new load and rotate request token
    _isCancelled = false;
    final requestId = ++_currentRequestId;
    _activeRequestCount++;

    if (_isRequestStale(requestId)) {
      _activeRequestCount--;
      return;
    }

    // Check if we have preloaded links for this episode
    if (_preloadedLinks.containsKey(episodeId)) {
      debugPrint('📦 VideoPlayerBloc: Using preloaded links for $episodeId');
      final response = _preloadedLinks[episodeId]!;
      _preloadedLinks.remove(episodeId); // Consume cache

      await _emitLoadedAndPlay(
        emit,
        response,
        provider,
        _preloadedServers[episodeId] ?? (server ?? 'Auto'),
        episodeId,
        requestId: requestId,
        startPosition: startPosition,
      );
      _preloadedServers.remove(episodeId);
      _activeRequestCount--;
      return;
    }

    emit(state.copyWith(streamingState: const StreamingState.loading()));

    // Fetch available servers in background (don't wait)
    _fetchAvailableServers(episodeId, mediaId, provider, requestId: requestId);

    // Get ordered servers list based on preference
    final servers = _getServersWithPreferred(preferredServer);

    if (kDebugMode) {
      debugPrint('🔄 Loading streaming links...');
      debugPrint('  Provider: $provider');
      debugPrint('  Preferred Server: ${preferredServer?.name ?? "auto"}');
      debugPrint('  Server order: $servers');
    }

    // 1. Try the requested provider first (with specific server if requested)
    bool success = await _tryProvider(
      emit,
      provider,
      episodeId,
      mediaId,
      server,
      servers,
      requestId: requestId,
      startPosition: startPosition,
    );
    if (success || _isRequestStale(requestId)) {
      _activeRequestCount--;
      return;
    }

    // 2. If specific server was requested, don't try fallbacks
    if (server != null) {
      if (!_isRequestStale(requestId) &&
          state.streamingState is! StreamingLoaded) {
        emit(
          state.copyWith(
            streamingState: const StreamingState.error(
              'Selected server is not available after retries. Please try a different server.',
            ),
          ),
        );
      }
      _activeRequestCount--;
      return;
    }

    // 3. Try fallback providers sequentially (to avoid 429s)
    if (kDebugMode) {
      debugPrint(
        '⚠️ Primary provider $provider failed. Trying fallback providers...',
      );
    }

    final isAnime = StreamingConfig.isAnimeProvider(provider);
    final fallbackProviders = StreamingConfig.getFallbackProviders(
      provider,
      isAnime,
    );

    if (fallbackProviders.isNotEmpty && !_isRequestStale(requestId)) {
      success = await _tryFallbackProviders(
        emit,
        fallbackProviders,
        episodeId,
        mediaId,
        servers,
        requestId: requestId,
        startPosition: startPosition,
      );
      if (success || _isRequestStale(requestId)) {
        _activeRequestCount--;
        return;
      }
    }

    // 4. If all fail
    if (!_isRequestStale(requestId) &&
        state.streamingState is! StreamingLoaded) {
      emit(
        state.copyWith(
          streamingState: const StreamingState.error(
            'No streaming links available. Please try a different provider in Settings or try again later.',
          ),
        ),
      );
    }
    _activeRequestCount--;
  }

  Future<Either<Failure, StreamingResponse>> _getLinksWithRetry({
    required String episodeId,
    required String mediaId,
    required String server,
    required String provider,
    required int requestId,
    int maxRetries = 2,
  }) async {
    int attempts = 0;
    while (true) {
      if (_isRequestStale(requestId)) {
        return const Left(ServerFailure('Request cancelled'));
      }

      try {
        final result = await _getStreamingLinks(
          episodeId: episodeId,
          mediaId: mediaId,
          server: server,
          provider: provider,
        );

        if (result.isRight()) return result;

        attempts++;
        if (attempts > maxRetries || _isRequestStale(requestId)) return result;

        // Exponential backoff with jitter to prevent thundering herd
        final baseDelay = pow(2, attempts - 1).toInt();
        final jitter = Random().nextInt(500); // 0-500ms jitter
        final delay = Duration(milliseconds: (baseDelay * 1000) + jitter);

        if (kDebugMode) {
          debugPrint(
            '⚠️ Load failed for $server ($provider). Retrying in ${delay.inSeconds}s (Attempt $attempts)...',
          );
        }

        // Check cancellation during delay
        await Future.delayed(delay);
        if (_isRequestStale(requestId)) {
          return const Left(ServerFailure('Request cancelled'));
        }
      } catch (e) {
        attempts++;
        if (attempts > maxRetries || _isRequestStale(requestId)) {
          return Left(ServerFailure(e.toString()));
        }
        await Future.delayed(Duration(seconds: pow(2, attempts - 1).toInt()));
      }
    }
  }

  Future<bool> _tryFallbackProviders(
    Emitter<VideoPlayerState> emit,
    List<String> providers,
    String episodeId,
    String mediaId,
    List<String> servers, {
    required int requestId,
    Duration? startPosition,
    void Function(StreamingResponse, String)? onPreloaded,
  }) async {
    // Try providers sequentially to avoid 429 Rate Limits
    for (final provider in providers) {
      if (_isRequestStale(requestId)) return false;

      if (kDebugMode) {
        debugPrint('🔄 Trying fallback provider: $provider');
      }

      try {
        final success = await _tryProvider(
          emit,
          provider,
          episodeId,
          mediaId,
          null, // No specific server for fallbacks
          servers,
          requestId: requestId,
          startPosition: startPosition,
          onPreloaded: onPreloaded,
        );

        if (success) return true;

        // Small delay between providers to be nice to the API
        if (!_isRequestStale(requestId)) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('❌ Provider $provider failed: $e');
        }
      }
    }

    return false;
  }

  Future<bool> _tryProvider(
    Emitter<VideoPlayerState> emit,
    String provider,
    String episodeId,
    String mediaId,
    String? specificServer,
    List<String> servers, {
    required int requestId,
    Duration? startPosition,
    bool emitState = true, // Control state emission (for preload)
    void Function(StreamingResponse, String)? onPreloaded,
  }) async {
    // If specific server requested
    if (specificServer != null) {
      final result = await _getLinksWithRetry(
        episodeId: episodeId,
        mediaId: mediaId,
        server: specificServer,
        provider: provider,
        requestId: requestId,
      );

      bool found = false;
      if (_isRequestStale(requestId)) return false;

      await result.fold(
        (failure) async {
          // Don't emit error here, just return false to try next server/provider
        },
        (response) async {
          if (!_isRequestStale(requestId)) {
            if (emitState) {
              await _emitLoadedAndPlay(
                emit,
                response,
                provider,
                specificServer,
                episodeId,
                requestId: requestId,
                startPosition: startPosition,
              );
            }
            if (onPreloaded != null) {
              onPreloaded(response, specificServer);
            }
          }
          found = true;
        },
      );
      return found;
    }

    // Loop through servers in preferred order
    for (final s in servers) {
      if (_isRequestStale(requestId)) return false;

      final result = await _getLinksWithRetry(
        episodeId: episodeId,
        mediaId: mediaId,
        server: s,
        provider: provider,
        requestId: requestId,
      );

      if (_isRequestStale(requestId)) return false;

      bool found = false;
      await result.fold(
        (_) async {}, // Ignore individual server errors during auto-scan
        (response) async {
          if (response.links.isNotEmpty) {
            if (!_isRequestStale(requestId)) {
              if (emitState) {
                await _emitLoadedAndPlay(
                  emit,
                  response,
                  provider,
                  s,
                  episodeId,
                  requestId: requestId,
                  startPosition: startPosition,
                );
              }
              if (onPreloaded != null) {
                onPreloaded(response, s);
              }
            }
            found = true;
          }
        },
      );

      if (found) return true;
    }

    return false;
  }

  /// Fetch available servers from API (async, updates cache)
  Future<void> _fetchAvailableServers(
    String episodeId,
    String mediaId,
    String provider, {
    required int requestId,
  }) async {
    final defaultServers = StreamingConfig.defaultServers;

    try {
      final result = await _getAvailableServers(
        episodeId: episodeId,
        mediaId: mediaId,
        provider: provider,
      );
      if (_isRequestStale(requestId)) return;

      result.fold(
        (_) {
          if (_isRequestStale(requestId)) return;
          // On error, use default servers
          _cachedAvailableServers = defaultServers;
        },
        (servers) {
          if (_isRequestStale(requestId)) return;
          _cachedAvailableServers = servers.isNotEmpty
              ? servers
              : defaultServers;
          if (kDebugMode) {
            debugPrint('📡 Available servers: $_cachedAvailableServers');
          }
        },
      );
    } catch (e) {
      _cachedAvailableServers = defaultServers;
    }
  }

  Future<void> _emitLoadedAndPlay(
    Emitter<VideoPlayerState> emit,
    StreamingResponse response,
    String provider,
    String server,
    String episodeId, {
    required int requestId,
    Duration? startPosition,
  }) async {
    if (!_isRequestStale(requestId)) {
      if (kDebugMode) {
        debugPrint('✅ Streaming links loaded successfully:');
        debugPrint('  Provider: $provider');
        debugPrint('  Server: $server');
        debugPrint('  Sources: ${response.links.length}');
        debugPrint('  Available servers: $_cachedAvailableServers');
      }

      final selectedLink = response.links.firstOrNull;
      if (selectedLink != null) {
        try {
          await _videoPlayerService.playVideo(
            url: selectedLink.url,
            startPosition: startPosition,
            subtitleUrl: response.subtitles.isNotEmpty
                ? response.subtitles.first.url
                : null,
            subtitleLang: response.subtitles.isNotEmpty
                ? response.subtitles.first.lang
                : null,
            headers: selectedLink.headers,
          );

          emit(
            state.copyWith(
              streamingState: StreamingState.loaded(
                links: response.links,
                selectedServer: server,
                selectedQuality: selectedLink.quality,
                subtitles: response.subtitles,
              ),
              currentServer: server,
              currentQuality: selectedLink.quality,
              availableServers:
                  _cachedAvailableServers ?? StreamingConfig.defaultServers,
            ),
          );
        } catch (e) {
          debugPrint('❌ Error playing video: $e');
          emit(
            state.copyWith(
              streamingState: StreamingState.error('Error playing video: $e'),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            streamingState: const StreamingState.error(
              'No streaming links available',
            ),
          ),
        );
      }
    }
  }

  Future<void> _onSwitchServer(
    SwitchServer event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint('🔄 VideoPlayerBloc: Switching to server ${event.server}');

    if (state.episodeId == null || state.mediaId == null) {
      debugPrint('⚠️ Cannot switch server: no episode loaded');
      return;
    }

    final currentPosition = _videoPlayerService.player.state.position;
    final provider = state.movie?.provider ?? 'flixhq';

    // Fetch settings to get preferred server
    PreferredServer preferredServer = PreferredServer.auto;
    final settingsResult = await _settingsRepository.getSettings();
    settingsResult.fold(
      (l) {}, // Use default
      (settings) {
        preferredServer = settings.preferredServer;
      },
    );

    emit(state.copyWith(streamingState: const StreamingState.loading()));

    await _loadStreamingLinks(
      emit,
      episodeId: state.episodeId!,
      mediaId: state.mediaId!,
      provider: provider,
      server: event.server,
      startPosition: currentPosition,
      preferredServer: preferredServer,
    );
  }

  Future<void> _onRetryStreaming(
    RetryStreaming event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint('🔄 VideoPlayerBloc: Retrying streaming');

    if (state.episodeId == null || state.mediaId == null) {
      debugPrint('⚠️ Cannot retry: no episode loaded');
      return;
    }

    final provider = state.movie?.provider ?? 'flixhq';

    // Fetch settings to get preferred server
    PreferredServer preferredServer = PreferredServer.auto;
    final settingsResult = await _settingsRepository.getSettings();
    settingsResult.fold(
      (l) {}, // Use default
      (settings) {
        preferredServer = settings.preferredServer;
      },
    );

    emit(state.copyWith(streamingState: const StreamingState.loading()));

    await _loadStreamingLinks(
      emit,
      episodeId: state.episodeId!,
      mediaId: state.mediaId!,
      provider: provider,
      preferredServer: preferredServer,
    );
  }

  Future<void> _onUpdateMovieDetails(
    UpdateMovieDetails event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint(
      '📥 VideoPlayerBloc: Updating movie details for ${event.movie.title}',
    );
    // Only update movie data without triggering playback reset
    emit(state.copyWith(movie: event.movie));
  }

  Future<void> _onSwitchQuality(
    SwitchQuality event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint('🔄 VideoPlayerBloc: Switching to quality ${event.quality}');

    if (state.streamingState is! StreamingLoaded) {
      debugPrint('⚠️ Cannot switch quality: no links loaded');
      return;
    }

    final loadedState = state.streamingState as StreamingLoaded;
    final targetLink = loadedState.links.firstWhere(
      (link) => link.quality == event.quality,
      orElse: () => loadedState.links.first,
    );

    final currentPosition = _videoPlayerService.player.state.position;

    try {
      await _videoPlayerService.playVideo(
        url: targetLink.url,
        startPosition: currentPosition,
        headers: targetLink.headers,
        isQualitySwitch: true,
      );

      emit(
        state.copyWith(
          currentQuality: event.quality,
          streamingState: loadedState.copyWith(selectedQuality: event.quality),
        ),
      );
    } catch (e) {
      debugPrint('❌ Error switching quality: $e');
    }
  }

  Future<void> _onLoadVideo(
    LoadVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint('▶️ VideoPlayerBloc: Loading video ${event.url}');
    try {
      await _videoPlayerService.playVideo(
        url: event.url,
        startPosition: state.startPosition,
        subtitleUrl: event.subtitleUrl,
        subtitleLang: event.subtitleLang,
        headers: event.headers,
        isQualitySwitch: event.isQualitySwitch,
      );
    } catch (e) {
      debugPrint('❌ VideoPlayerBloc: Error loading video: $e');
    }
  }

  Future<void> _onTogglePlayPause(
    TogglePlayPause event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.playOrPause();
  }

  Future<void> _onPauseVideoPlayback(
    PauseVideoPlayback event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.pause();
  }

  Future<void> _onResumeVideoPlayback(
    ResumeVideoPlayback event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.play();
  }

  Future<void> _onSeekVideo(
    SeekVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.player.seek(event.position);
  }

  Future<void> _onSetPlaybackSpeed(
    SetPlaybackSpeed event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.setRate(event.speed);
  }

  void _onMinimizeVideo(MinimizeVideo event, Emitter<VideoPlayerState> emit) {
    // Debounce rapid minimize/maximize transitions
    if (state.status != VideoPlayerStatus.minimized) {
      emit(state.copyWith(status: VideoPlayerStatus.minimized));
    }
  }

  void _onMaximizeVideo(MaximizeVideo event, Emitter<VideoPlayerState> emit) {
    // Debounce rapid minimize/maximize transitions
    if (state.status != VideoPlayerStatus.expanded) {
      emit(state.copyWith(status: VideoPlayerStatus.expanded));
    }
  }

  Future<void> _onEnterPiP(
    EnterPiP event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _videoPlayerService.enablePiP();
  }

  Future<void> _onCloseVideo(
    CloseVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    debugPrint('🛑 VideoPlayerBloc: Closing video');
    await _videoPlayerService.stop();
    emit(const VideoPlayerState(status: VideoPlayerStatus.closed));
  }

  Future<void> _onStartCast(
    StartCast event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _castService.startCasting(
      videoUrl: event.videoUrl,
      title: state.title ?? 'Video',
    );
  }

  Future<void> _onDownloadCurrentVideo(
    DownloadCurrentVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    await _downloadService.downloadVideo(
      url: event.url,
      fileName: event.fileName,
      movieId: event.movieId,
      movieTitle: event.movieTitle,
      episodeTitle: event.episodeTitle,
      posterUrl: event.posterUrl,
    );
  }
}
