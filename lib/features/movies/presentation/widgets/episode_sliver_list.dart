import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';
import 'episode_item.dart';

class EpisodeSliverList extends StatelessWidget {
  final List<Episode> episodes;
  final String mediaId;
  final Function(Episode) onEpisodeTap;
  final List<WatchProgress> watchProgress;
  final String? posterUrl;
  final String? currentEpisodeId;

  const EpisodeSliverList({
    super.key,
    required this.episodes,
    required this.mediaId,
    required this.onEpisodeTap,
    this.watchProgress = const [],
    this.posterUrl,
    this.currentEpisodeId,
  });

  @override
  Widget build(BuildContext context) {
    // Optimization: Create a map for O(1) lookup
    // This avoids O(N*M) complexity where N is episodes count and M is history size
    final progressMap = {
      for (final p in watchProgress)
        if (p.mediaId == mediaId && p.episodeId != null) p.episodeId!: p
    };

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final episode = episodes[index];
          final isSelected = episode.id == currentEpisodeId;
          final progress = progressMap[episode.id] ?? WatchProgress.empty();

          return EpisodeItem(
            key: ValueKey(episode.id),
            episode: episode,
            isSelected: isSelected,
            progress: progress,
            posterUrl: posterUrl,
            onTap: () => onEpisodeTap(episode),
            totalEpisodesCount: episodes.length,
          );
        },
        childCount: episodes.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
      ),
    );
  }
}
