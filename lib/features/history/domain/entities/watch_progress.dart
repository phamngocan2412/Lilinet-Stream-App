import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_progress.freezed.dart';

@freezed
abstract class WatchProgress with _$WatchProgress {
  const factory WatchProgress({
    required String mediaId,
    required String title,
    String? posterUrl,
    String? episodeId,
    String? episodeTitle,
    required int positionSeconds,
    required int durationSeconds,
    required DateTime lastUpdated,
    required bool isFinished,
  }) = _WatchProgress;

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
}
