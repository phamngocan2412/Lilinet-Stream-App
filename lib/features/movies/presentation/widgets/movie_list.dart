import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieTap;
  final String? heroTagPrefix;

  const MovieList({
    super.key,
    required this.movies,
    required this.onMovieTap,
    this.heroTagPrefix,
  });

  @override
  Widget build(BuildContext context) {
    // Optimization: Calculate optimal memory cache size for images.
    // The grid is 2 columns with 16px padding on sides and 12px spacing.
    // Width = (ScreenWidth - 32 - 12) / 2
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 32 - 12) / 2;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Cap cache width to avoid excessive memory on very large screens (though tablet is fine),
    // and ensure minimum quality.
    // Default logic in AppCachedImage uses 700 if width is infinite.
    // For a phone (360px wide), item is ~158px. 158 * 3 (high density) = 474px.
    // 474px < 700px, so we save memory.
    final memCacheWidth = (itemWidth * pixelRatio).toInt();

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            heroTag:
                heroTagPrefix != null ? '${heroTagPrefix}_${movie.id}' : null,
            onTap: () => onMovieTap(movie),
            memCacheWidth: memCacheWidth,
          );
        },
        childCount: movies.length,
        addAutomaticKeepAlives: false, // Reduce memory overhead
        addRepaintBoundaries: true, // Optimize repaints
      ),
    );
  }
}
