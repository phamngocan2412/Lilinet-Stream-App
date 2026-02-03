import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/streaming_config.dart';
import '../../../../settings/domain/entities/app_settings.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/streaming_link.dart';
import '../../../domain/entities/streaming_response.dart';
import '../../../domain/usecases/get_streaming_links.dart';
import '../../../domain/usecases/get_available_servers.dart';
import 'streaming_state.dart';

@injectable
class StreamingCubit extends Cubit<StreamingState> {
  final GetStreamingLinks _getStreamingLinks;
  final GetAvailableServers _getAvailableServers;

  // Cache available servers for current episode
  List<String>? _cachedAvailableServers;

  StreamingCubit(this._getStreamingLinks, this._getAvailableServers)
      : super(StreamingInitial());

  /// Get servers list with preferred server first
  List<String> _getServersWithPreferred(PreferredServer? preferred) {
    final defaultServers = StreamingConfig.defaultServers;

    if (preferred == null || preferred == PreferredServer.auto) {
      return defaultServers;
    }

    final preferredName = preferred.name;
    // Put preferred server first, then others
    return [
      preferredName,
      ...defaultServers.where((s) => s != preferredName),
    ];
  }

  Future<void> playLocalFile({
    required String path,
    required String episodeId,
  }) async {
    if (isClosed) return;

    emit(
      StreamingLoaded(
        episodeId: episodeId,
        links: [
          StreamingLink(
            url: path,
            quality: 'Downloaded',
            isM3U8: false,
          ),
        ],
        selectedServer: 'Local',
        availableServers: ['Local'],
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
    // Since this is now a factory instance per video session, we don't check for existing state match.
    // Each loadLinks call implies a new request or a retry.

    if (isClosed) return;
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
    if (success) return;

    // 2. If specific server was requested, don't try fallbacks
    if (server != null) {
      if (!isClosed && state is! StreamingLoaded) {
        emit(
          const StreamingError(
            'Selected server is not available after retries. Please try a different server.',
          ),
        );
      }
      return;
    }

    // 3. Race fallback providers in parallel for faster response
    if (kDebugMode) {
      debugPrint('⚠️ Primary provider $effectiveProvider failed. Racing fallback providers...');
    }

    final isAnime = StreamingConfig.isAnimeProvider(effectiveProvider);
    final fallbackProviders = StreamingConfig.getFallbackProviders(effectiveProvider, isAnime);

    if (fallbackProviders.isNotEmpty) {
      success = await _raceProviders(fallbackProviders, episodeId, mediaId, servers);
      if (success) return;
    }

    // 4. If all fail
    if (!isClosed && state is! StreamingLoaded) {
      emit(
        const StreamingError(
          'No streaming links available. Please check your connection or try a different provider in Settings.',
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
      if (isClosed) return Left(ServerFailure('Cubit closed'));

      try {
        final result = await _getStreamingLinks(
          episodeId: episodeId,
          mediaId: mediaId,
          server: server,
          provider: provider,
        );

        if (result.isRight()) return result;

        attempts++;
        if (attempts > maxRetries) return result;

        final delay = Duration(seconds: pow(2, attempts - 1).toInt()); // 1s, 2s
        if (kDebugMode) {
          debugPrint('⚠️ Load failed for $server ($provider). Retrying in ${delay.inSeconds}s (Attempt $attempts)...');
        }
        await Future.delayed(delay);
      } catch (e) {
        attempts++;
        if (attempts > maxRetries) return Left(ServerFailure(e.toString()));
        await Future.delayed(Duration(seconds: pow(2, attempts - 1).toInt()));
      }
    }
  }

  Future<bool> _raceProviders(
    List<String> providers,
    String episodeId,
    String mediaId,
    List<String> servers,
  ) async {
    // Create a completer to handle the first successful result
    final completer = Completer<bool>();
    var completed = false;

    // Launch all providers in parallel with a race
    final futures = providers.map((provider) async {
      if (completed || isClosed) return;

      try {
        final result = await _tryProviderWithServers(
          provider,
          episodeId,
          mediaId,
          servers,
        );

        if (result && !completed && !isClosed) {
          completed = true;
          completer.complete(true);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('❌ Provider $provider failed: $e');
        }
      }
    }).toList();

    // Wait for either first success or all to complete
    final raceFuture = completer.future;
    final allCompleteFuture = Future.wait(futures);

    try {
      await Future.any([raceFuture, allCompleteFuture.then((_) => false)]);
      return completed;
    } catch (e) {
      return false;
    }
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
    List<String> servers,
  ) async {
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
          _emitLoaded(response, provider, specificServer, episodeId);
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
            _emitLoaded(response, provider, s, episodeId);
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
          _cachedAvailableServers = servers.isNotEmpty ? servers : defaultServers;
          if (kDebugMode) {
            debugPrint('📡 Available servers: $_cachedAvailableServers');
          }
        },
      );
    } catch (e) {
      _cachedAvailableServers = defaultServers;
    }
  }

  void _emitLoaded(StreamingResponse response, String provider, String server, String episodeId) {
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
          availableServers: _cachedAvailableServers ?? StreamingConfig.defaultServers,
        ),
      );
    }
  }
}
