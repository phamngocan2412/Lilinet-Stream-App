import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/streaming_config.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../../core/services/cast_service.dart';
import '../../../../core/services/download_service.dart';
import '../../../movies/domain/usecases/get_streaming_links.dart';
import '../../../movies/domain/usecases/get_available_servers.dart';
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

  VideoPlayerBloc(
    this._videoPlayerService,
    this._castService,
    this._downloadService,
    this._getStreamingLinks,
    this._getAvailableServers,
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
    on<SwitchQuality>(_onSwitchQuality);
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

    emit(state.copyWith(
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
    ));

    await _loadStreamingLinks(
      emit,
      episodeId: event.episodeId,
      mediaId: event.mediaId,
      provider: event.movie?.provider ?? 'flixhq',
      startPosition: event.startPosition,
    );
  }

  Future<void> _loadStreamingLinks(
    Emitter<VideoPlayerState> emit, {
    required String episodeId,
    required String mediaId,
    required String provider,
    String? server,
    Duration? startPosition,
  }) async {
    debugPrint('📡 VideoPlayerBloc: Loading streaming links');
    debugPrint('   Episode: $episodeId');
    debugPrint('   Provider: $provider');

    final servers = _getServerOrder(server);

    for (final tryServer in servers) {
      if (isClosed) return;

      debugPrint('🔄 Trying server: $tryServer');

      final result = await _getStreamingLinks(
        episodeId: episodeId,
        mediaId: mediaId,
        provider: provider,
        server: tryServer,
      );

      result.fold(
        (failure) async {
          debugPrint('❌ Server $tryServer failed: ${failure.message}');
          if (tryServer == servers.last) {
            emit(state.copyWith(
              streamingState: const StreamingState.error(
                'Unable to load video from any server. Please try again.',
              ),
            ));
          }
        },
        (response) async {
          debugPrint('✅ Server $tryServer succeeded');

          if (isClosed) return;

          _loadAvailableServers(emit, episodeId, mediaId, provider);

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

              emit(state.copyWith(
                streamingState: StreamingState.loaded(
                  links: response.links,
                  selectedServer: tryServer,
                  selectedQuality: selectedLink.quality,
                ),
                currentServer: tryServer,
                currentQuality: selectedLink.quality,
              ));
            } catch (e) {
              debugPrint('❌ Error playing video: $e');
              emit(state.copyWith(
                streamingState: StreamingState.error('Error playing video: $e'),
              ));
            }
          } else {
            emit(state.copyWith(
              streamingState: const StreamingState.error(
                'No streaming links available',
              ),
            ));
          }
        },
      );

      if (state.isStreamingLoaded) break;
    }
  }

  List<String> _getServerOrder(String? preferredServer) {
    final defaultServers = StreamingConfig.defaultServers;
    if (preferredServer == null || preferredServer == 'auto') {
      return defaultServers;
    }
    return [
      preferredServer,
      ...defaultServers.where((s) => s != preferredServer)
    ];
  }

  Future<void> _loadAvailableServers(
    Emitter<VideoPlayerState> emit,
    String episodeId,
    String mediaId,
    String provider,
  ) async {
    try {
      final result = await _getAvailableServers(
        episodeId: episodeId,
        mediaId: mediaId,
        provider: provider,
      );

      result.fold(
        (failure) =>
            debugPrint('⚠️ Failed to load servers: ${failure.message}'),
        (servers) {
          emit(state.copyWith(availableServers: servers));
          debugPrint('📡 Available servers: $servers');
        },
      );
    } catch (e) {
      debugPrint('⚠️ Error loading servers: $e');
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

    emit(state.copyWith(
      streamingState: const StreamingState.loading(),
    ));

    await _loadStreamingLinks(
      emit,
      episodeId: state.episodeId!,
      mediaId: state.mediaId!,
      provider: provider,
      server: event.server,
      startPosition: currentPosition,
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

    emit(state.copyWith(
      streamingState: const StreamingState.loading(),
    ));

    await _loadStreamingLinks(
      emit,
      episodeId: state.episodeId!,
      mediaId: state.mediaId!,
      provider: provider,
    );
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

      emit(state.copyWith(
        currentQuality: event.quality,
        streamingState: loadedState.copyWith(selectedQuality: event.quality),
      ));
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
    emit(state.copyWith(status: VideoPlayerStatus.minimized));
  }

  void _onMaximizeVideo(MaximizeVideo event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.expanded));
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
