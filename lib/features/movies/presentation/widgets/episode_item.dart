import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';

class EpisodeItem extends StatelessWidget {
  final Episode episode;
  final bool isSelected;
  final WatchProgress progress;
  final String? posterUrl;
  final VoidCallback onTap;
  final int totalEpisodesCount;

  const EpisodeItem({
    super.key,
    required this.episode,
    required this.isSelected,
    required this.progress,
    this.posterUrl,
    required this.onTap,
    required this.totalEpisodesCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hasProgress =
        progress.positionSeconds > 0 && progress.durationSeconds > 0;
    final progressPercent = hasProgress
        ? (progress.positionSeconds / progress.durationSeconds).clamp(0.0, 1.0)
        : 0.0;

    // Determine image URL
    String? imageUrl = episode.image;
    if (imageUrl == null || imageUrl.isEmpty) {
      imageUrl = posterUrl;
    }

    // Determine Title and Subtitle
    final isMovie = totalEpisodesCount == 1;
    final String titleText = isMovie
        ? 'Full Movie'
        : (episode.title.isNotEmpty
            ? episode.title
            : 'Episode ${episode.number}');

    final Widget? subtitleWidget = isMovie
        ? null
        : (episode.title.isNotEmpty &&
                episode.title != 'Episode ${episode.number}'
            ? Text('Episode ${episode.number}')
            : null);

    return Container(
      color: isSelected ? colorScheme.primary.withOpacity(0.15) : null,
      child: ListTile(
        selected: isSelected,
        minVerticalPadding: 12,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        onTap: onTap,
        leading: SizedBox(
          width: 100,
          height: 56,
          child: Semantics(
            label: 'Thumbnail for $titleText',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl != null && imageUrl.isNotEmpty
                      ? AppCachedImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 56,
                        )
                      : Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.movie,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                  Container(
                    color: Colors.black26,
                  ), // Slight overlay for play icon visibility
                  Center(
                    child: Icon(
                      isSelected
                          ? Icons.play_circle_filled
                          : Icons.play_circle_outline,
                      color: Colors.white,
                      size: isSelected ? 32 : 24,
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
                        color: colorScheme.primary,
                        minHeight: 3,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? colorScheme.primary
                : (hasProgress ? colorScheme.primary : null),
          ),
        ),
        subtitle: subtitleWidget,
      ),
    );
  }
}
