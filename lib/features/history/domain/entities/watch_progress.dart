import 'package:equatable/equatable.dart';

class WatchProgress extends Equatable {
  final String mediaId;
  final String title;
  final String? posterUrl;
  final String? episodeId;
  final String? episodeTitle;
  final int positionSeconds;
  final int durationSeconds;
  final DateTime lastUpdated;
  final bool isFinished;

  const WatchProgress({
    required this.mediaId,
    required this.title,
    this.posterUrl,
    this.episodeId,
    this.episodeTitle,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.lastUpdated,
    required this.isFinished,
  });

  factory WatchProgress.empty() {
    return WatchProgress(
      mediaId: '',
      title: '',
      positionSeconds: 0,
      durationSeconds: 0,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(0),
      isFinished: false,
    );
  }

  @override
  List<Object?> get props => [
        mediaId,
        title,
        posterUrl,
        episodeId,
        episodeTitle,
        positionSeconds,
        durationSeconds,
        lastUpdated,
        isFinished,
      ];
}
