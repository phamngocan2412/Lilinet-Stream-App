import 'package:hive_ce/hive_ce.dart';

part 'watch_progress_model.g.dart';

@HiveType(typeId: 2)
class WatchProgressModel extends HiveObject {
  @HiveField(0)
  final String mediaId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterUrl;

  @HiveField(3)
  final String? episodeId;

  @HiveField(4)
  final String? episodeTitle;

  @HiveField(5)
  final int positionSeconds;

  @HiveField(6)
  final int durationSeconds;

  @HiveField(7)
  final DateTime lastUpdated;

  @HiveField(8)
  final bool isFinished;

  WatchProgressModel({
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
}
