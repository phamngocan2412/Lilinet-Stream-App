// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final bool showTitle;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.showTitle = true,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine badge text
    String badgeText = '';
    final typeLower = movie.type.toLowerCase();
    final bool isSeries =
        typeLower.contains('tv') || typeLower.contains('series');

    if (isSeries) {
      if (movie.totalEpisodes != null) {
        badgeText = '${movie.totalEpisodes} Eps';
      } else {
        badgeText = 'TV Series';
      }
    } else {
      badgeText = 'Full HD';
    }

    return Semantics(
      label: '${movie.title}, ${movie.rating ?? 'N/A'} stars',
      button: true,
      hint: 'Double tap to view movie details',
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            // 1. Poster Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppCachedImage(
                  imageUrl: movie.poster ?? '',
                  fit: BoxFit.cover,
                  width: width ?? double.infinity,
                  height: height ?? double.infinity,
                  memCacheWidth: memCacheWidth,
                  memCacheHeight: memCacheHeight,
                ),
                // 2. Gradient Overlay (Bottom)
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1.0],
                      colors: [
                        Colors.transparent,
                        Color(0xCC000000), // Black with ~0.8 opacity
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Badge (Top Left)
          Positioned(
            top: 8,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      blurRadius: 2,
                      color: Color(0x4D000000),
                    ), // Black 0.3
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Color(0xCC000000), // Black 0.8
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    ),
  );
  }
}
