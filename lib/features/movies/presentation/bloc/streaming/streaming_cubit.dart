import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_streaming_links.dart';
import 'streaming_state.dart';

@injectable
class StreamingCubit extends Cubit<StreamingState> {
  final GetStreamingLinks _getStreamingLinks;

  StreamingCubit(this._getStreamingLinks) : super(StreamingInitial());

  // Valid servers for animekai: vidcloud, upcloud, megaup
  static const _servers = ['vidcloud', 'upcloud', 'megaup'];

  Future<void> loadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai', // Changed from sflix
  }) async {
    if (isClosed) return;
    emit(StreamingLoading());

    // If a specific server is requested, try only that one
    if (server != null) {
      final result = await _getStreamingLinks(
        episodeId: episodeId,
        mediaId: mediaId,
        server: server,
        provider: provider,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          if (!isClosed) emit(StreamingError(failure.message));
        },
        (response) {
          if (!isClosed) {
            emit(
              StreamingLoaded(
                links: response.links,
                selectedServer: server,
                subtitles: response.subtitles,
              ),
            );
          }
        },
      );
      return;
    }

    String? lastErrorMessage;

    // Auto-fallback logic: Try each server in order until one works
    for (final s in _servers) {
      if (isClosed) return;
      final result = await _getStreamingLinks(
        episodeId: episodeId,
        mediaId: mediaId,
        server: s,
        provider: provider,
      );

      if (isClosed) return;

      bool found = false;
      result.fold(
        (failure) {
          lastErrorMessage = failure.message;
        },
        (response) {
          if (response.links.isNotEmpty) {
            if (!isClosed) {
              print('✅ Streaming links loaded successfully:');
              print('  Provider: $provider');
              print('  Server: $s');
              print('  Sources: ${response.links.length}');
              print('  Subtitles: ${response.subtitles.length}');

              emit(
                StreamingLoaded(
                  links: response.links,
                  selectedServer: s,
                  subtitles: response.subtitles,
                ),
              );
            }
            found = true;
          }
        },
      );

      if (found) return;
    }

    // If all servers fail
    if (!isClosed) {
      emit(
        StreamingError(
          lastErrorMessage ??
              'No streaming links available. Please try again later.',
        ),
      );
    }
  }
}
