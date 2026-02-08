import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/streaming_config.dart';
import '../../../../settings/domain/entities/app_settings.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/streaming_link.dart';
import '../../../domain/entities/streaming_response.dart';
import '../../../domain/usecases/get_streaming_links.dart';
import '../../../domain/usecases/get_available_servers.dart';
import 'streaming_state.dart';

@injectable
class StreamingCubit extends Cubit<StreamingState> {
  final GetStreamingLinks _getStreamingLinks;
  final GetAvailableServers _getAvailableServers;

  String? _currentEpisodeId;
  String? _currentMediaId;

  // Cache available servers for current episode
  List<String>? _cachedAvailableServers;

  // Cancel token for active requests
  bool _isCancelled = false;
  int _activeRequestCount = 0;

  StreamingCubit(this._getStreamingLinks, this._getAvailableServers)
      : super(StreamingInitial());

  String? get currentEpisodeId => _currentEpisodeId;
  String? get currentMediaId => _currentMediaId;

  /// Cancel all pending requests
  void cancelPendingRequests() {
    _isCancelled = true;
    if (kDebugMode) {
      debugPrint(
        '🛑 StreamingCubit: Cancelling $_activeRequestCount pending requests',
      );
    }
  }

  /// Check if request was cancelled
  bool get isCancelled => _isCancelled;

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

  Future<void> playLocalFile({
    required String path,
    required String episodeId,
  }) async {
    if (isClosed) return;

    emit(
      StreamingLoaded(
        episodeId: episodeId,
        links: [StreamingLink(url: path, quality: 'Downloaded', isM3U8: false)],
        selectedServer: 'Local',
        availableServers: const ['Local'],
      ),
    );
  }

  Future<void> loadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String? provider,
    PreferredServer? preferredServer,
  }) async {
    // Skip if already loaded for this episode
    if (_currentEpisodeId == episodeId &&
        _currentMediaId == mediaId &&
        state is StreamingLoaded &&
        !_isCancelled &&
        server == null) {
      if (kDebugMode) {
        debugPrint(
            '✅ StreamingCubit: Reusing cached links for episode $episodeId');
      }
      return;
    }

    _currentEpisodeId = episodeId;
    _currentMediaId = mediaId;

    // Reset cancellation flag for new load
    _isCancelled = false;
    _activeRequestCount++;

    // Singleton instance - we cache episode state to avoid duplicate requests.
    // Only load if episode/media/provider changed or specific server requested.

    if (isClosed || _isCancelled) {
      _activeRequestCount--;
      return;
    }
    emit(StreamingLoading());

    // Use default provider if not specified
    final effectiveProvider = provider ?? StreamingConfig.defaultProvider;

    // Fetch available servers in background (don't wait)
    _fetchAvailableServers(episodeId, mediaId, effectiveProvider);

    // Get ordered servers list based on preference
    final servers = _getServersWithPreferred(preferredServer);

    if (kDebugMode) {
      debugPrint('🔄 Loading streaming links...');
      debugPrint('  Provider: $effectiveProvider');
      debugPrint('  Preferred Server: ${preferredServer?.name ?? "auto"}');
      debugPrint('  Server order: $servers');
    }

    // 1. Try the requested provider first (with specific server if requested)
    bool success = await _tryProvider(
      effectiveProvider,
      episodeId,
      mediaId,
      server,
      servers,
    );
    if (success || _isCancelled) {
      _activeRequestCount--;
      return;
    }

    // 2. If specific server was requested, don't try fallbacks
    if (server != null) {
      if (!isClosed && state is! StreamingLoaded && !_isCancelled) {
        emit(
          const StreamingError(
            'Selected server is not available after retries. Please try a different server.',
          ),
        );
      }
      _activeRequestCount--;
      return;
    }

    // 3. Try fallback providers sequentially (to avoid 429s)
    if (kDebugMode) {
      debugPrint(
        '⚠️ Primary provider $effectiveProvider failed. Trying fallback providers...',
      );
    }

    final isAnime = StreamingConfig.isAnimeProvider(effectiveProvider);
    final fallbackProviders = StreamingConfig.getFallbackProviders(
      effectiveProvider,
      isAnime,
    );

    if (fallbackProviders.isNotEmpty && !_isCancelled) {
      success = await _tryFallbackProviders(
        fallbackProviders,
        episodeId,
        mediaId,
        servers,
      );
      if (success) {
        _activeRequestCount--;
        return;
      }
    }

    // 4. If all fail
    if (!isClosed && state is! StreamingLoaded && !_isCancelled) {
      emit(
        const StreamingError(
          'No streaming links available. Please try a different provider in Settings or try again later.',
        ),
      );
    }
    _activeRequestCount--;
  }

  /// Change server for current episode
  void selectServer({
    required String episodeId,
    required String mediaId,
    required String server,
    String? provider,
    PreferredServer? preferredServer,
  }) {
    loadLinks(
      episodeId: episodeId,
      mediaId: mediaId,
      server: server,
      provider: provider,
      preferredServer: preferredServer,
    );
  }

  /// Change quality for current episode (just updating state for UI)
  void changeQuality(StreamingLink link) {
    final currentState = state;
    if (currentState is StreamingLoaded) {
      emit(
        StreamingLoaded(
          episodeId: currentState.episodeId,
          links: currentState.links,
          selectedServer: currentState.selectedServer,
          subtitles: currentState.subtitles,
          availableServers: currentState.availableServers,
        ),
      );
    }
  }

  Future<Either<Failure, StreamingResponse>> _getLinksWithRetry({
    required String episodeId,
    required String mediaId,
    required String server,
    required String provider,
    int maxRetries = 2,
  }) async {
    int attempts = 0;
    while (true) {
      if (isClosed || _isCancelled) {
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
        if (attempts > maxRetries || _isCancelled) return result;

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
        if (_isCancelled) return const Left(ServerFailure('Request cancelled'));
      } catch (e) {
        attempts++;
        if (attempts > maxRetries || _isCancelled) {
          return Left(ServerFailure(e.toString()));
        }
        await Future.delayed(Duration(seconds: pow(2, attempts - 1).toInt()));
      }
    }
  }

  Future<bool> _tryFallbackProviders(
    List<String> providers,
    String episodeId,
    String mediaId,
    List<String> servers,
  ) async {
    // Try providers sequentially to avoid 429 Rate Limits
    for (final provider in providers) {
      if (isClosed) return false;

      if (kDebugMode) {
        debugPrint('🔄 Trying fallback provider: $provider');
      }

      try {
        final success = await _tryProviderWithServers(
          provider,
          episodeId,
          mediaId,
          servers,
        );

        if (success) return true;

        // Small delay between providers to be nice to the API
        if (!isClosed) {
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

  Future<bool> _tryProviderWithServers(
    String provider,
    String episodeId,
    String mediaId,
    List<String> servers,
  ) async {
    return await _tryProvider(provider, episodeId, mediaId, null, servers);
  }

  Future<bool> _tryProvider(
    String provider,
    String episodeId,
    String mediaId,
    String? specificServer,
    List<String> servers, {
    bool emitState = true, // New parameter to control state emission
  }) async {
    // If specific server requested
    if (specificServer != null) {
      final result = await _getLinksWithRetry(
        episodeId: episodeId,
        mediaId: mediaId,
        server: specificServer,
        provider: provider,
      );

      bool found = false;
      if (isClosed) return false;

      result.fold(
        (failure) {
          // Don't emit error here, just return false to try next server/provider
        },
        (response) {
          if (emitState) {
            _emitLoaded(response, provider, specificServer, episodeId);
          }
          found = true;
        },
      );
      return found;
    }

    // Loop through servers in preferred order
    for (final s in servers) {
      if (isClosed) return false;

      final result = await _getLinksWithRetry(
        episodeId: episodeId,
        mediaId: mediaId,
        server: s,
        provider: provider,
      );

      if (isClosed) return false;

      bool found = false;
      result.fold(
        (_) {}, // Ignore individual server errors during auto-scan
        (response) {
          if (response.links.isNotEmpty) {
            if (emitState) {
              _emitLoaded(response, provider, s, episodeId);
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
    String provider,
  ) async {
    final defaultServers = StreamingConfig.defaultServers;

    try {
      final result = await _getAvailableServers(
        episodeId: episodeId,
        mediaId: mediaId,
        provider: provider,
      );

      result.fold(
        (_) {
          // On error, use default servers
          _cachedAvailableServers = defaultServers;
        },
        (servers) {
          _cachedAvailableServers =
              servers.isNotEmpty ? servers : defaultServers;
          if (kDebugMode) {
            debugPrint('📡 Available servers: $_cachedAvailableServers');
          }
        },
      );
    } catch (e) {
      _cachedAvailableServers = defaultServers;
    }
  }

  void _emitLoaded(
    StreamingResponse response,
    String provider,
    String server,
    String episodeId,
  ) {
    if (!isClosed) {
      if (kDebugMode) {
        debugPrint('✅ Streaming links loaded successfully:');
        debugPrint('  Provider: $provider');
        debugPrint('  Server: $server');
        debugPrint('  Sources: ${response.links.length}');
        debugPrint('  Available servers: $_cachedAvailableServers');
      }

      emit(
        StreamingLoaded(
          episodeId: episodeId,
          links: response.links,
          selectedServer: server,
          subtitles: response.subtitles,
          availableServers:
              _cachedAvailableServers ?? StreamingConfig.defaultServers,
        ),
      );
    }
  }

  /// Preload streaming links for next episode without emitting state
  Future<void> preloadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String? provider,
    PreferredServer? preferredServer,
  }) async {
    // Use default provider if not specified
    final effectiveProvider = provider ?? StreamingConfig.defaultProvider;

    if (kDebugMode) {
      debugPrint('📦 Preloading streaming links for episode: $episodeId');
      debugPrint('  Provider: $effectiveProvider');
    }

    try {
      // Get ordered servers list based on preference
      final servers = _getServersWithPreferred(preferredServer);

      // Try to load links for the episode (similar to loadLinks but without state emission)
      await _tryProvider(
        effectiveProvider,
        episodeId,
        mediaId,
        server,
        servers,
        emitState: false, // Don't emit state during preload
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ Preloading failed for episode $episodeId: $e');
      }
    }
  }
}
