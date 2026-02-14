import 'package:injectable/injectable.dart';
import '../../data/datasources/history_local_datasource.dart';
import '../../domain/entities/watch_progress.dart';
import '../../domain/repositories/history_repository.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource _localDataSource;
  bool _hasCleanedUp = false;

  HistoryRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveProgress(WatchProgress progress) async {
    // If finished, delete from progress instead of saving as finished
    // Based on user request: "Remove cache, show status as watched"
    // Since this is "Recently Watched" (Resume list), we remove if finished.
    // If we wanted a full history log, we'd save it with isFinished=true.
    // Given the prompt "dang xem do den dau thi no se luu vao trong do" (save where left off)
    // and "xem het phim thi tu dong remove cache" (remove if finished),
    // we will delete it if progress > 95% or explicitly marked finished.

    if (progress.isFinished) {
      await _localDataSource.deleteProgress(
        progress.mediaId,
        episodeId: progress.episodeId,
      );
    } else {
      await _localDataSource.saveProgress(progress);
    }

    // Optimization: Only perform cleanup once per session to reduce DB overhead.
    // Cleanup involves iterating through all entries which is expensive (O(N)).
    // Doing this on every progress save (every 5s) causes unnecessary CPU/IO usage.
    if (!_hasCleanedUp) {
      _hasCleanedUp = true;
      await _localDataSource.cleanupOldEntries();
    }
  }

  @override
  Future<List<WatchProgress>> getHistory() => _localDataSource.getHistory();

  @override
  Future<void> deleteProgress(String mediaId, {String? episodeId}) =>
      _localDataSource.deleteProgress(mediaId, episodeId: episodeId);

  @override
  Future<void> clearHistory() => _localDataSource.clearHistory();
}
