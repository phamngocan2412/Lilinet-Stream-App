import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/watch_progress.dart';
import '../../domain/usecases/get_watch_history.dart';
import '../../domain/usecases/save_watch_progress.dart';
import '../../domain/usecases/delete_watch_progress.dart';

export 'history_state.dart';
import 'history_state.dart';

/// Type alias for backward compatibility.
/// New code should use HistoryCubit directly.
typedef HistoryBloc = HistoryCubit;

@lazySingleton
class HistoryCubit extends Cubit<HistoryState> {
  final GetWatchHistory _getWatchHistory;
  final SaveWatchProgress _saveWatchProgress;
  final DeleteWatchProgress _deleteWatchProgress;

  HistoryCubit({
    required GetWatchHistory getWatchHistory,
    required SaveWatchProgress saveWatchProgress,
    required DeleteWatchProgress deleteWatchProgress,
  })  : _getWatchHistory = getWatchHistory,
        _saveWatchProgress = saveWatchProgress,
        _deleteWatchProgress = deleteWatchProgress,
        super(const HistoryInitial());

  Future<void> loadHistory() async {
    emit(const HistoryLoading());
    try {
      final history = await _getWatchHistory();
      if (history.isEmpty) {
        emit(const HistoryEmpty());
      } else {
        emit(HistoryLoaded(history: history));
      }
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  Future<void> saveProgress(WatchProgress progress) async {
    try {
      await _saveWatchProgress(progress);
      await loadHistory(); // Refresh list
    } catch (e) {
      // Silently fail or log error
    }
  }

  Future<void> deleteProgress(String mediaId, {String? episodeId}) async {
    try {
      await _deleteWatchProgress(mediaId, episodeId: episodeId);
      await loadHistory();
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
