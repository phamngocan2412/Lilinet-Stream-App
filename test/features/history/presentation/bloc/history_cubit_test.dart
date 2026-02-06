import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lilinet_app/features/history/domain/entities/watch_progress.dart';
import 'package:lilinet_app/features/history/domain/usecases/delete_watch_progress.dart';
import 'package:lilinet_app/features/history/domain/usecases/get_watch_history.dart';
import 'package:lilinet_app/features/history/domain/usecases/save_watch_progress.dart';
import 'package:lilinet_app/features/history/presentation/bloc/history_bloc.dart';

class MockGetWatchHistory extends Mock implements GetWatchHistory {}

class MockSaveWatchProgress extends Mock implements SaveWatchProgress {}

class MockDeleteWatchProgress extends Mock implements DeleteWatchProgress {}

void main() {
  late HistoryCubit cubit;
  late MockGetWatchHistory mockGetWatchHistory;
  late MockSaveWatchProgress mockSaveWatchProgress;
  late MockDeleteWatchProgress mockDeleteWatchProgress;

  setUp(() {
    mockGetWatchHistory = MockGetWatchHistory();
    mockSaveWatchProgress = MockSaveWatchProgress();
    mockDeleteWatchProgress = MockDeleteWatchProgress();
    cubit = HistoryCubit(
      getWatchHistory: mockGetWatchHistory,
      saveWatchProgress: mockSaveWatchProgress,
      deleteWatchProgress: mockDeleteWatchProgress,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('HistoryCubit', () {
    final tHistory = [
      WatchProgress(
        mediaId: 'movie_1',
        title: 'Test Movie 1',
        posterUrl: 'https://example.com/poster1.jpg',
        episodeId: 'episode_1',
        episodeTitle: 'Episode 1',
        positionSeconds: 120,
        durationSeconds: 3600,
        lastUpdated: DateTime(2024, 1, 1),
        isFinished: false,
      ),
      WatchProgress(
        mediaId: 'movie_2',
        title: 'Test Movie 2',
        posterUrl: 'https://example.com/poster2.jpg',
        episodeId: 'episode_2',
        episodeTitle: 'Episode 2',
        positionSeconds: 600,
        durationSeconds: 2400,
        lastUpdated: DateTime(2024, 1, 2),
        isFinished: true,
      ),
    ];

    group('loadHistory', () {
      blocTest<HistoryCubit, HistoryState>(
        'emits [loading, loaded] when history is loaded successfully',
        build: () {
          when(() => mockGetWatchHistory()).thenAnswer((_) async => tHistory);
          return cubit;
        },
        act: (cubit) => cubit.loadHistory(),
        expect: () => [
          const HistoryState.loading(),
          HistoryState.loaded(
            history: tHistory,
            totalVideos: 2,
            totalTimeSeconds: 720,
          ),
        ],
        verify: (_) {
          verify(() => mockGetWatchHistory()).called(1);
        },
      );

      blocTest<HistoryCubit, HistoryState>(
        'emits [loading, empty] when history is empty',
        build: () {
          when(() => mockGetWatchHistory()).thenAnswer((_) async => []);
          return cubit;
        },
        act: (cubit) => cubit.loadHistory(),
        expect: () => [
          const HistoryState.loading(),
          const HistoryState.empty(),
        ],
        verify: (_) {
          verify(() => mockGetWatchHistory()).called(1);
        },
      );

      blocTest<HistoryCubit, HistoryState>(
        'emits [loading, error] when loading fails',
        build: () {
          when(
            () => mockGetWatchHistory(),
          ).thenThrow(Exception('Failed to load'));
          return cubit;
        },
        act: (cubit) => cubit.loadHistory(),
        expect: () => [
          const HistoryState.loading(),
          const HistoryState.error(message: 'Exception: Failed to load'),
        ],
        verify: (_) {
          verify(() => mockGetWatchHistory()).called(1);
        },
      );
    });

    group('saveProgress', () {
      final tProgress = WatchProgress(
        mediaId: 'movie_1',
        title: 'Test Movie',
        posterUrl: 'https://example.com/poster.jpg',
        episodeId: 'episode_1',
        episodeTitle: 'Episode 1',
        positionSeconds: 120,
        durationSeconds: 3600,
        lastUpdated: DateTime.now(),
        isFinished: false,
      );

      blocTest<HistoryCubit, HistoryState>(
        'saves progress and reloads history',
        build: () {
          when(
            () => mockSaveWatchProgress(tProgress),
          ).thenAnswer((_) async => const Right(null));
          when(() => mockGetWatchHistory()).thenAnswer((_) async => tHistory);
          return cubit;
        },
        act: (cubit) => cubit.saveProgress(tProgress),
        verify: (_) {
          verify(() => mockSaveWatchProgress(tProgress)).called(1);
          verify(() => mockGetWatchHistory()).called(1);
        },
      );

      blocTest<HistoryCubit, HistoryState>(
        'handles save failure silently',
        build: () {
          when(
            () => mockSaveWatchProgress(tProgress),
          ).thenThrow(Exception('Save failed'));
          return cubit;
        },
        act: (cubit) => cubit.saveProgress(tProgress),
        expect: () => [],
        verify: (_) {
          verify(() => mockSaveWatchProgress(tProgress)).called(1);
          verifyNever(() => mockGetWatchHistory());
        },
      );
    });

    group('deleteProgress', () {
      blocTest<HistoryCubit, HistoryState>(
        'deletes progress and reloads history successfully',
        build: () {
          when(
            () => mockDeleteWatchProgress('movie_1', episodeId: 'episode_1'),
          ).thenAnswer((_) async => const Right(null));
          when(() => mockGetWatchHistory()).thenAnswer((_) async => tHistory);
          return cubit;
        },
        act: (cubit) => cubit.deleteProgress('movie_1', episodeId: 'episode_1'),
        expect: () => [
          const HistoryState.loading(),
          HistoryState.loaded(
            history: tHistory,
            totalVideos: 2,
            totalTimeSeconds: 720,
          ),
        ],
        verify: (_) {
          verify(
            () => mockDeleteWatchProgress('movie_1', episodeId: 'episode_1'),
          ).called(1);
          verify(() => mockGetWatchHistory()).called(1);
        },
      );

      blocTest<HistoryCubit, HistoryState>(
        'emits error when delete fails',
        build: () {
          when(
            () => mockDeleteWatchProgress('movie_1', episodeId: 'episode_1'),
          ).thenThrow(Exception('Delete failed'));
          return cubit;
        },
        act: (cubit) => cubit.deleteProgress('movie_1', episodeId: 'episode_1'),
        expect: () => [
          const HistoryState.error(message: 'Exception: Delete failed'),
        ],
        verify: (_) {
          verify(
            () => mockDeleteWatchProgress('movie_1', episodeId: 'episode_1'),
          ).called(1);
        },
      );

      blocTest<HistoryCubit, HistoryState>(
        'deletes all episodes when episodeId is null',
        build: () {
          when(
            () => mockDeleteWatchProgress('movie_1', episodeId: null),
          ).thenAnswer((_) async => const Right(null));
          when(() => mockGetWatchHistory()).thenAnswer((_) async => tHistory);
          return cubit;
        },
        act: (cubit) => cubit.deleteProgress('movie_1'),
        expect: () => [
          const HistoryState.loading(),
          HistoryState.loaded(
            history: tHistory,
            totalVideos: 2,
            totalTimeSeconds: 720,
          ),
        ],
        verify: (_) {
          verify(
            () => mockDeleteWatchProgress('movie_1', episodeId: null),
          ).called(1);
          verify(() => mockGetWatchHistory()).called(1);
        },
      );
    });
  });
}
