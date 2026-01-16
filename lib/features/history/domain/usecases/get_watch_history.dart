import '../../domain/entities/watch_progress.dart';
import '../../domain/repositories/history_repository.dart';

class GetWatchHistory {
  final HistoryRepository _repository;

  GetWatchHistory(this._repository);

  Future<List<WatchProgress>> call() {
    return _repository.getHistory();
  }
}
