import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';
import 'episode_item.dart';

class EpisodeList extends StatelessWidget {
  final List<Episode> episodes;
  final String mediaId;
  final Function(Episode) onEpisodeTap;
  final List<WatchProgress> watchProgress;

  final String? posterUrl;
  final String? currentEpisodeId;

  const EpisodeList({
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
    return ListView.builder(
      cacheExtent: 300,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: episodes.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        final isSelected = episode.id == currentEpisodeId;
        final progress = watchProgress.firstWhere(
          (p) => p.episodeId == episode.id && p.mediaId == mediaId,
          orElse: () => WatchProgress.empty(),
        );

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
    );
  }
}
