import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/movies/domain/entities/episode.dart';
import 'package:lilinet_app/features/history/domain/entities/watch_progress.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/episode_sliver_list.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/episode_item.dart';

void main() {
  group('EpisodeList Optimization', () {
    testWidgets('EpisodeSliverList correctly maps WatchProgress to Episode', (
      tester,
    ) async {
      final episodes = List.generate(
        10,
        (index) => Episode(
          id: 'ep_$index',
          title: 'Episode $index',
          number: index + 1,
        ),
      );

      final watchProgress = [
        WatchProgress(
          mediaId: 'movie_1',
          title: 'Movie 1',
          episodeId: 'ep_3',
          positionSeconds: 150,
          durationSeconds: 200,
          lastUpdated: DateTime.now(),
          isFinished: false,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                EpisodeSliverList(
                  episodes: episodes,
                  mediaId: 'movie_1',
                  onEpisodeTap: (_) {},
                  watchProgress: watchProgress,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify ep_3 has progress
      final item3Finder = find.byWidgetPredicate((widget) {
        if (widget is EpisodeItem && widget.episode.id == 'ep_3') {
          return widget.progress.positionSeconds == 150;
        }
        return false;
      });
      expect(item3Finder, findsOneWidget);
    });
  });
}
