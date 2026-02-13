import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../features/movies/domain/entities/movie.dart';
import 'streaming_state.dart';

part 'video_player_state.freezed.dart';

enum VideoPlayerStatus { closed, minimized, expanded }

@freezed
abstract class VideoPlayerState with _$VideoPlayerState {
  const factory VideoPlayerState({
    @Default(VideoPlayerStatus.closed) VideoPlayerStatus status,
    String? episodeId,
    String? mediaId,
    String? title,
    String? posterUrl,
    String? episodeTitle,
    Duration? startPosition,
    String? mediaType,
    Movie? movie,
    @Default(StreamingState.initial()) StreamingState streamingState,
    List<String>? availableServers,
    String? currentServer,
    String? currentQuality,
  }) = _VideoPlayerState;
}

extension VideoPlayerStateX on VideoPlayerState {
  bool get isStreamingLoading => streamingState is StreamingLoading;
  bool get isStreamingLoaded => streamingState is StreamingLoaded;
  bool get hasStreamingError => streamingState is StreamingError;

  String? get streamingErrorMessage =>
      streamingState.maybeWhen(error: (message) => message, orElse: () => null);
}
