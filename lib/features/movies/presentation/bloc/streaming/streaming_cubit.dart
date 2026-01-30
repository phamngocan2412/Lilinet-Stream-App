import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_streaming_links.dart';
import 'streaming_state.dart';

@injectable
class StreamingCubit extends Cubit<StreamingState> {
  final GetStreamingLinks _getStreamingLinks;

  StreamingCubit(this._getStreamingLinks) : super(StreamingInitial());

  // Valid servers
  static const _servers = ['vidcloud', 'upcloud', 'megaup'];

  // Backup providers
  static const _animeProviders = ['zoro', 'gogoanime', 'animepahe', 'animekai'];
  static const _movieProviders = ['flixhq', 'viewasian'];

  Future<void> loadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai',
  }) async {
    if (isClosed) return;
    emit(StreamingLoading());

    // 1. Try the requested provider first
    bool success = await _tryProvider(provider, episodeId, mediaId, server);
    if (success) return;

    // 2. If specific server was requested, don't try fallbacks (user explicit choice)
    if (server != null) {
      // Error is already emitted by _tryProvider if it failed
      return;
    }

    // 3. Auto-fallback to other providers in the SAME category
    print('⚠️ Primary provider $provider failed. Attempting fallbacks...');

    final isAnime = _animeProviders.contains(provider);
    final primaryBackups = isAnime ? _animeProviders : _movieProviders;
    final secondaryBackups = isAnime ? _movieProviders : _animeProviders;

    // Try same-category backups
    for (final backup in primaryBackups) {
      if (backup == provider) continue; // Skip already tried

      print('🔄 Trying fallback provider (Same Category): $backup');
      success = await _tryProvider(backup, episodeId, mediaId, null);
      if (success) return;
    }

    // 4. Try cross-category backups (Last Resort)
    // This handles cases where a Movie is wrongly classified as Anime or vice versa
    print(
      '⚠️ All ${isAnime ? "Anime" : "Movie"} providers failed. Trying cross-category...',
    );

    for (final backup in secondaryBackups) {
      print('🔄 Trying fallback provider (Cross Category): $backup');
      success = await _tryProvider(backup, episodeId, mediaId, null);
      if (success) return;
    }

    // 5. If all fail
    if (!isClosed && state is! StreamingLoaded) {
      emit(
        const StreamingError(
          'No streaming links available. Please try a different server or provider in Settings.',
        ),
      );
    }
  }

  Future<bool> _tryProvider(
    String provider,
    String episodeId,
    String mediaId,
    String? specificServer,
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
          // if (state is! StreamingLoaded) emit(StreamingError(failure.message));
        },
        (response) {
          _emitLoaded(response, provider, specificServer);
          found = true;
        },
      );
      return found;
    }

    // Loop through servers
    for (final s in _servers) {
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

  void _emitLoaded(dynamic response, String provider, String server) {
    if (!isClosed) {
      print('✅ Streaming links loaded successfully:');
      print('  Provider: $provider');
      print('  Server: $server');
      print('  Sources: ${response.links.length}');

      emit(
        StreamingLoaded(
          links: response.links,
          selectedServer: server,
          subtitles: response.subtitles,
        ),
      );
    }
  }
}
