import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../settings/domain/entities/app_settings.dart';
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

  // Valid servers - order matters for fallback
  static const _defaultServers = ['vidcloud', 'upcloud', 'megaup'];

  // Backup providers
  static const _animeProviders = ['zoro', 'gogoanime', 'animepahe', 'animekai'];
  static const _movieProviders = ['flixhq', 'viewasian'];

  /// Get servers list with preferred server first
  List<String> _getServersWithPreferred(PreferredServer? preferred) {
    if (preferred == null || preferred == PreferredServer.auto) {
      return _defaultServers;
    }

    final preferredName = preferred.name;
    // Put preferred server first, then others
    return [
      preferredName,
      ..._defaultServers.where((s) => s != preferredName),
    ];
  }

  Future<void> loadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai',
    PreferredServer? preferredServer,
  }) async {
    if (isClosed) return;
    emit(StreamingLoading());

    // Fetch available servers in background (don't wait)
    _fetchAvailableServers(episodeId, mediaId, provider);

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
      provider,
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
            'Selected server is not available. Please try a different server.',
          ),
        );
      }
      return;
    }

    // 3. Race fallback providers in parallel for faster response
    if (kDebugMode) {
      debugPrint('⚠️ Primary provider $provider failed. Racing fallback providers...');
    }

    final isAnime = _animeProviders.contains(provider);
    final fallbackProviders = _getFallbackProviders(provider, isAnime);

    if (fallbackProviders.isNotEmpty) {
      success = await _raceProviders(fallbackProviders, episodeId, mediaId, servers);
      if (success) return;
    }

    // 4. If all fail
    if (!isClosed && state is! StreamingLoaded) {
      emit(
        const StreamingError(
          'No streaming links available. Please try a different server or provider in Settings.',
        ),
      );
    }
  }

  List<String> _getFallbackProviders(String primaryProvider, bool isAnime) {
    final allProviders = isAnime
        ? [..._animeProviders, ..._movieProviders]
        : [..._movieProviders, ..._animeProviders];

    return allProviders.where((p) => p != primaryProvider).toList();
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
      final result = await _getStreamingLinks(
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
          _emitLoaded(response, provider, specificServer);
          found = true;
        },
      );
      return found;
    }

    // Loop through servers in preferred order
    for (final s in servers) {
      if (isClosed) return false;

      final result = await _getStreamingLinks(
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
            _emitLoaded(response, provider, s);
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
    try {
      final result = await _getAvailableServers(
        episodeId: episodeId,
        mediaId: mediaId,
        provider: provider,
      );

      result.fold(
        (_) {
          // On error, use default servers
          _cachedAvailableServers = _defaultServers;
        },
        (servers) {
          _cachedAvailableServers = servers.isNotEmpty ? servers : _defaultServers;
          if (kDebugMode) {
            debugPrint('📡 Available servers: $_cachedAvailableServers');
          }
        },
      );
    } catch (e) {
      _cachedAvailableServers = _defaultServers;
    }
  }

  void _emitLoaded(StreamingResponse response, String provider, String server) {
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
          links: response.links,
          selectedServer: server,
          subtitles: response.subtitles,
          availableServers: _cachedAvailableServers ?? _defaultServers,
        ),
      );
    }
  }
}
