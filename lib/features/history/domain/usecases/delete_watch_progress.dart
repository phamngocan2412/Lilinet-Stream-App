import '../../domain/repositories/history_repository.dart';

class DeleteWatchProgress {
  final HistoryRepository _repository;

  DeleteWatchProgress(this._repository);

  Future<void> call(String mediaId) {
    return _repository.deleteProgress(mediaId);
  }
}
