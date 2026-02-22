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
  }) : _getWatchHistory = getWatchHistory,
       _saveWatchProgress = saveWatchProgress,
       _deleteWatchProgress = deleteWatchProgress,
       super(const HistoryInitial());

  @override
  Future<void> close() {
    // Ensure all resources are disposed
    return super.close();
  }

  Future<void> loadHistory() async {
    emit(const HistoryLoading());
    try {
      final history = await _getWatchHistory();
      if (history.isEmpty) {
        emit(const HistoryEmpty());
      } else {
        int totalTime = 0;
        for (var item in history) {
          totalTime += item.positionSeconds;
        }
        emit(
          HistoryLoaded(
            history: history,
            totalVideos: history.length,
            totalTimeSeconds: totalTime,
          ),
        );
      }
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  Future<void> saveProgress(WatchProgress progress) async {
    try {
      await _saveWatchProgress(progress);

      // Optimistic update to avoid full reload
      if (state is HistoryLoaded) {
        final currentState = state as HistoryLoaded;
        var currentList = List<WatchProgress>.from(currentState.history);

        // Find existing index
        final index = currentList.indexWhere(
          (item) =>
              item.mediaId == progress.mediaId &&
              item.episodeId == progress.episodeId,
        );

        if (index != -1) {
          // Update existing
          currentList[index] = progress;
        } else {
          // Add new to top
          currentList.insert(0, progress);
        }

        // Re-sort by lastUpdated desc
        currentList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

        // Enforce limit of 100 items in memory to match data source
        if (currentList.length > 100) {
          currentList = currentList.sublist(0, 100);
        }

        // Recalculate stats
        int totalTime = 0;
        for (var item in currentList) {
          totalTime += item.positionSeconds;
        }

        if (isClosed) return;
        emit(
          currentState.copyWith(
            history: currentList,
            totalVideos: currentList.length,
            totalTimeSeconds: totalTime,
          ),
        );
      } else {
        // If not loaded, then we might need to load
        await loadHistory();
      }
    } catch (e) {
      // Silently fail or log error
    }
  }

  Future<void> deleteProgress(String mediaId, {String? episodeId}) async {
    try {
      await _deleteWatchProgress(mediaId, episodeId: episodeId);

      // Optimistic update
      if (state is HistoryLoaded) {
        final currentState = state as HistoryLoaded;
        final currentList = List<WatchProgress>.from(currentState.history);

        currentList.removeWhere((item) {
          if (episodeId != null) {
            return item.mediaId == mediaId && item.episodeId == episodeId;
          }
          return item.mediaId == mediaId;
        });

        // Recalculate stats
        int totalTime = 0;
        for (var item in currentList) {
          totalTime += item.positionSeconds;
        }

        if (isClosed) return;
        emit(
          currentState.copyWith(
            history: currentList,
            totalVideos: currentList.length,
            totalTimeSeconds: totalTime,
          ),
        );
      } else {
        await loadHistory();
      }
    } catch (e) {
      if (isClosed) return;
      emit(HistoryError(message: e.toString()));
    }
  }
}
