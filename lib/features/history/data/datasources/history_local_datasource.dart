import '../../domain/entities/watch_progress.dart';
// import '../models/watch_progress_model.dart';

abstract class HistoryLocalDataSource {
  Future<void> saveProgress(WatchProgress progress);
  Future<List<WatchProgress>> getHistory();
  Future<void> deleteProgress(String mediaId);
  Future<void> clearHistory();
  Future<void> cleanupOldEntries();
}
