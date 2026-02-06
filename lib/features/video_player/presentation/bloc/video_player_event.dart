import 'package:equatable/equatable.dart';
import '../../../../features/movies/domain/entities/movie.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayVideo extends VideoPlayerEvent {
  final String episodeId;
  final String mediaId;
  final String title;
  final String? posterUrl;
  final String? episodeTitle;
  final Duration? startPosition;
  final String? mediaType;
  final Movie? movie;

  const PlayVideo({
    required this.episodeId,
    required this.mediaId,
    required this.title,
    this.posterUrl,
    this.episodeTitle,
    this.startPosition,
    this.mediaType,
    this.movie,
  });

  @override
  List<Object?> get props => [
        episodeId,
        mediaId,
        title,
        posterUrl,
        episodeTitle,
        startPosition,
        mediaType,
        movie,
      ];
}

class MinimizeVideo extends VideoPlayerEvent {}

class MaximizeVideo extends VideoPlayerEvent {}

class CloseVideo extends VideoPlayerEvent {}
