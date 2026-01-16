import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_streaming_links.dart';
import 'streaming_state.dart';

@injectable
class StreamingCubit extends Cubit<StreamingState> {
  final GetStreamingLinks _getStreamingLinks;

  StreamingCubit(this._getStreamingLinks) : super(StreamingInitial());

  static const _servers = ['vidcloud', 'upcloud', 'mixdrop'];

  Future<void> loadLinks({
    required String episodeId,
    required String mediaId,
    String? server,
  }) async {
    if (isClosed) return;
    emit(StreamingLoading());

    // If a specific server is requested, try only that one
    if (server != null) {
      final result = await _getStreamingLinks(
        episodeId: episodeId,
        mediaId: mediaId,
        server: server,
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
