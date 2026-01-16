import '../entities/watch_progress.dart';

abstract class HistoryRepository {
  Future<void> saveProgress(WatchProgress progress);
  Future<List<WatchProgress>> getHistory();
  Future<void> deleteProgress(String mediaId);
  Future<void> clearHistory();
}
