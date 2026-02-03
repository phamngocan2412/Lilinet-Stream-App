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

class LoadVideo extends VideoPlayerEvent {
  final String url;
  final String? subtitleUrl;
  final String? subtitleLang;
  final Map<String, String>? headers;
  final bool isQualitySwitch;

  const LoadVideo({
    required this.url,
    this.subtitleUrl,
    this.subtitleLang,
    this.headers,
    this.isQualitySwitch = false,
  });

  @override
  List<Object?> get props => [url, subtitleUrl, subtitleLang, headers, isQualitySwitch];
}

class TogglePlayPause extends VideoPlayerEvent {}

class PauseVideoPlayback extends VideoPlayerEvent {}

class ResumeVideoPlayback extends VideoPlayerEvent {}

class SeekVideo extends VideoPlayerEvent {
  final Duration position;
  const SeekVideo(this.position);

  @override
  List<Object?> get props => [position];
}

class SetPlaybackSpeed extends VideoPlayerEvent {
  final double speed;
  const SetPlaybackSpeed(this.speed);

  @override
  List<Object?> get props => [speed];
}

class MinimizeVideo extends VideoPlayerEvent {}

class MaximizeVideo extends VideoPlayerEvent {}

class EnterPiP extends VideoPlayerEvent {}

class CloseVideo extends VideoPlayerEvent {}

class StartCast extends VideoPlayerEvent {
  final String videoUrl;
  const StartCast(this.videoUrl);

  @override
  List<Object?> get props => [videoUrl];
}

class DownloadCurrentVideo extends VideoPlayerEvent {
  final String url;
  final String fileName;
  final String? movieId;
  final String? movieTitle;

  const DownloadCurrentVideo({
    required this.url,
    required this.fileName,
    this.movieId,
    this.movieTitle,
  });

  @override
  List<Object?> get props => [url, fileName, movieId, movieTitle];
}
