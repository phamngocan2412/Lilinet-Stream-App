import '../../domain/entities/watch_progress.dart';
import '../../domain/repositories/history_repository.dart';

class SaveWatchProgress {
  final HistoryRepository _repository;

  SaveWatchProgress(this._repository);

  Future<void> call(WatchProgress progress) {
    return _repository.saveProgress(progress);
  }
}
