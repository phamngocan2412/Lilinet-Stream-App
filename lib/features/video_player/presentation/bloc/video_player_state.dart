import 'package:equatable/equatable.dart';
import '../../../../features/movies/domain/entities/movie.dart';

enum VideoPlayerStatus { closed, minimized, expanded }

class VideoPlayerState extends Equatable {
  final VideoPlayerStatus status;
  final String? episodeId;
  final String? mediaId;
  final String? title;
  final String? posterUrl;
  final String? episodeTitle;
  final Duration? startPosition;
  final String? mediaType;
  final Movie? movie; // Added to hold full movie context
  final int? timestamp; // Added to force state updates

  const VideoPlayerState({
    this.status = VideoPlayerStatus.closed,
    this.episodeId,
    this.mediaId,
    this.title,
    this.posterUrl,
    this.episodeTitle,
    this.startPosition,
    this.mediaType,
    this.movie,
    this.timestamp,
  });

  VideoPlayerState copyWith({
    VideoPlayerStatus? status,
    String? episodeId,
    String? mediaId,
    String? title,
    String? posterUrl,
    String? episodeTitle,
    Duration? startPosition,
    String? mediaType,
    Movie? movie,
    int? timestamp,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      episodeId: episodeId ?? this.episodeId,
      mediaId: mediaId ?? this.mediaId,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      episodeTitle: episodeTitle ?? this.episodeTitle,
      startPosition: startPosition ?? this.startPosition,
      mediaType: mediaType ?? this.mediaType,
      movie: movie ?? this.movie,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
    status,
    episodeId,
    mediaId,
    title,
    posterUrl,
    episodeTitle,
    startPosition,
    mediaType,
    movie,
    timestamp,
  ];
}
