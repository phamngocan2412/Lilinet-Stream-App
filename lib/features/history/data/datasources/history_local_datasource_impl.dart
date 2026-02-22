import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/watch_progress.dart';
import '../models/watch_progress_model.dart';
import 'history_local_datasource.dart';

@LazySingleton(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final Box<WatchProgressModel> _box;

  HistoryLocalDataSourceImpl(this._box);

  @override
  Future<void> saveProgress(WatchProgress progress) async {
    final model = WatchProgressModel(
      mediaId: progress.mediaId,
      title: progress.title,
      posterUrl: progress.posterUrl,
      episodeId: progress.episodeId,
      episodeTitle: progress.episodeTitle,
      positionSeconds: progress.positionSeconds,
      durationSeconds: progress.durationSeconds,
      lastUpdated: progress.lastUpdated,
      isFinished: progress.isFinished,
    );
    // Use composite key to support multiple episodes per media
    // and prevent overwriting different episodes
    final key = '${progress.mediaId}_${progress.episodeId}';
    await _box.put(key, model);
  }

  @override
  Future<List<WatchProgress>> getHistory() async {
    final history = _box.values
        .where((e) => !e.isFinished) // Only return unfinished items
        .map(
          (e) => WatchProgress(
            mediaId: e.mediaId,
            title: e.title,
            posterUrl: e.posterUrl,
            episodeId: e.episodeId,
            episodeTitle: e.episodeTitle,
            positionSeconds: e.positionSeconds,
            durationSeconds: e.durationSeconds,
            lastUpdated: e.lastUpdated,
            isFinished: e.isFinished,
          ),
        )
        .toList()
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

    // Deduplicate: Keep only the newest entry for each episode
    final seen = <String>{};
    final uniqueHistory = <WatchProgress>[];

    for (final item in history) {
      final key = '${item.mediaId}_${item.episodeId}';
      if (!seen.contains(key)) {
        seen.add(key);
        uniqueHistory.add(item);
      }
    }

    return uniqueHistory.take(100).toList();
  }

  @override
  Future<void> deleteProgress(String mediaId, {String? episodeId}) async {
    if (episodeId != null) {
      final key = '${mediaId}_$episodeId';
      await _box.delete(key);
    } else {
      final keys = _box.keys
          .where((k) => k.toString().startsWith('${mediaId}_'))
          .cast<String>()
          .toList();
      if (keys.isNotEmpty) {
        await _box.deleteAll(keys);
      }
    }
  }

  @override
  Future<void> clearHistory() async {
    await _box.clear();
  }

  @override
  Future<void> cleanupOldEntries() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final keysToDelete = <String>[];

    for (var i = 0; i < _box.length; i++) {
      final entry = _box.getAt(i);
      if (entry != null && entry.lastUpdated.isBefore(sevenDaysAgo)) {
        final key = _box.keyAt(i);
        if (key != null) {
          keysToDelete.add(key);
        }
      }
    }

    if (keysToDelete.isNotEmpty) {
      await _box.deleteAll(keysToDelete);
    }
  }

  @override
  Future<void> migrateLegacyData() async {
    final keys = _box.keys.toList();

    for (final key in keys) {
      final keyStr = key.toString();
      final entry = _box.get(key);

      if (entry == null) continue;

      // If key doesn't contain '_' and entry has episodeId, migrate it
      if (!keyStr.contains('_') && entry.episodeId != null) {
        final newKey = '${entry.mediaId}_${entry.episodeId}';

        // Only migrate if new key doesn't already exist
        if (!_box.containsKey(newKey)) {
          await _box.put(newKey, entry);
        }

        // Delete old entry
        await _box.delete(key);
      }
    }
  }
}
