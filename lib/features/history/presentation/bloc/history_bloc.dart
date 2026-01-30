import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/watch_progress.dart';
import '../../domain/usecases/get_watch_history.dart';
import '../../domain/usecases/save_watch_progress.dart';
import '../../domain/usecases/delete_watch_progress.dart';

part 'history_state.dart';

@lazySingleton
class HistoryBloc extends Cubit<HistoryState> {
  final GetWatchHistory _getWatchHistory;
  final SaveWatchProgress _saveWatchProgress;
  final DeleteWatchProgress _deleteWatchProgress;

  HistoryBloc({
    required GetWatchHistory getWatchHistory,
    required SaveWatchProgress saveWatchProgress,
    required DeleteWatchProgress deleteWatchProgress,
  }) : _getWatchHistory = getWatchHistory,
       _saveWatchProgress = saveWatchProgress,
       _deleteWatchProgress = deleteWatchProgress,
       super(HistoryInitial());

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final history = await _getWatchHistory();
      if (history.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryLoaded(history));
      }
    } catch (e) {
      emit(HistoryError(e.toString()));
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

  Future<void> deleteProgress(String mediaId) async {
    try {
      await _deleteWatchProgress(mediaId);
      await loadHistory();
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
