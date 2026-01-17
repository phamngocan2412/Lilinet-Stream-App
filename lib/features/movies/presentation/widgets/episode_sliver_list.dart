// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';

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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final episode = episodes[index];
          final isSelected = episode.id == currentEpisodeId;
          final progress = watchProgress.firstWhere(
            (p) => p.episodeId == episode.id && p.mediaId == mediaId,
            orElse: () => WatchProgress.empty(),
          );
          final hasProgress =
              progress.positionSeconds > 0 && progress.durationSeconds > 0;
          final progressPercent = hasProgress
              ? (progress.positionSeconds / progress.durationSeconds).clamp(
                  0.0,
                  1.0,
                )
              : 0.0;

          // Determine image URL
          String? imageUrl = episode.image;
          if (imageUrl == null || imageUrl.isEmpty) {
            imageUrl = posterUrl;
          }

          return Container(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                : null,
            child: ListTile(
              selected: isSelected,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onTap: () => onEpisodeTap(episode),
              leading: SizedBox(
                width: 100,
                height: 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      imageUrl != null && imageUrl.isNotEmpty
                          ? AppCachedImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: Icon(
                                Icons.movie,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                      Container(
                        color: Colors.black26,
                      ), // Slight overlay for play icon visibility
                      if (isSelected)
                        const Center(
                          child: Icon(
                            Icons.play_circle_filled,
                            color: Colors.white,
                            size: 32,
                          ),
                        )
                      else
                        const Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                      if (hasProgress)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            value: progressPercent,
                            backgroundColor: Colors.white24,
                            color: Theme.of(
                              context,
                            ).colorScheme.error, // Usually Red
                            minHeight: 3,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              title: Text(
                episodes.length == 1
                    ? 'Full'
                    : (episode.title.isNotEmpty
                          ? episode.title
                          : 'Episode ${episode.number}'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : (hasProgress
                            ? Theme.of(context).colorScheme.error
                            : null), // Use theme error color
                ),
              ),
              subtitle: episodes.length == 1
                  ? null
                  : (episode.title.isNotEmpty &&
                            episode.title != 'Episode ${episode.number}'
                        ? Text('Episode ${episode.number}')
                        : null),
            ),
          );
        },
        childCount: episodes.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
      ),
    );
  }
}
