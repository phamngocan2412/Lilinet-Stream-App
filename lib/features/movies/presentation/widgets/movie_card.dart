// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final String? heroTag;
  final bool showTitle;
  final int? memCacheWidth;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.heroTag,
    this.showTitle = true,
    this.memCacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Determine badge text
    String badgeText = '';
    bool isSeries =
        movie.type.toLowerCase().contains('tv') ||
        movie.type.toLowerCase().contains('series');

    if (isSeries) {
      if (movie.totalEpisodes != null) {
        // User wants Current/Total, but we only have Total safely.
        // We format it as "Total Episodes" to be safe.
        badgeText = '${movie.totalEpisodes} Eps';
      } else {
        badgeText = 'TV Series';
      }
    } else {
      badgeText = 'Full HD';
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // 1. Poster Image
          Hero(
            tag: heroTag ?? 'poster_${movie.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(
                    imageUrl: movie.poster ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    memCacheWidth: memCacheWidth,
                  ),
                  // 2. Gradient Overlay (Bottom)
                  // Use theme-aware gradient or keep black for text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.6, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(
                            0.8,
                          ), // Always black for white text readability
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Badge (Top Left)
          Positioned(
            top: 8,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 2, color: Colors.black.withOpacity(0.3)),
                  ],
                ),
              ),
            ),
          ),

          // 4. Favorite Button (Top Right)
          Positioned(
            top: 4,
            right: 4,
            child: FavoriteButton(
              movieId: movie.id,
              movieTitle: movie.title,
              moviePoster: movie.poster,
              movieType: movie.type,
              size: 20,
            ),
          ),

          // 5. Title (Bottom)
          if (showTitle)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white, // Always white on dark gradient
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
