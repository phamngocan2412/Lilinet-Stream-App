import 'package:injectable/injectable.dart';
import '../../domain/entities/watch_progress.dart';
import '../../domain/repositories/history_repository.dart';

@injectable
class GetWatchHistory {
  final HistoryRepository _repository;

  GetWatchHistory(this._repository);

  Future<List<WatchProgress>> call() {
    return _repository.getHistory();
  }
}
