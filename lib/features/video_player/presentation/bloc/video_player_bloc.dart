import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'video_player_event.dart';
import 'video_player_state.dart';

@injectable
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(const VideoPlayerState()) {
    on<PlayVideo>(_onPlayVideo);
    on<MinimizeVideo>(_onMinimizeVideo);
    on<MaximizeVideo>(_onMaximizeVideo);
    on<CloseVideo>(_onCloseVideo);
  }

  void _onPlayVideo(PlayVideo event, Emitter<VideoPlayerState> emit) {
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
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  void _onMinimizeVideo(MinimizeVideo event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.minimized));
  }

  void _onMaximizeVideo(MaximizeVideo event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.expanded));
  }

  void _onCloseVideo(CloseVideo event, Emitter<VideoPlayerState> emit) {
    emit(const VideoPlayerState(status: VideoPlayerStatus.closed));
  }
}
