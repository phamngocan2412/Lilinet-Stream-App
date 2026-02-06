import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/watch_progress.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = HistoryInitial;

  const factory HistoryState.loading() = HistoryLoading;

  const factory HistoryState.loaded({
    required List<WatchProgress> history,
    @Default(0) int totalVideos,
    @Default(0) int totalTimeSeconds,
  }) = HistoryLoaded;

  const factory HistoryState.empty() = HistoryEmpty;

  const factory HistoryState.error({required String message}) = HistoryError;
}
