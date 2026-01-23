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
    // Calculate optimal cache width for grid items
    // (Screen Width - Padding) / Columns * Pixel Density
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Assuming 32px horizontal padding (16*2) and 12px spacing.
    // Being slightly generous to be safe.
    final cacheWidth = ((screenWidth - 32) / 2 * devicePixelRatio).ceil();

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.7,
        crossAxisSpacing: crossAxisSpacing,
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
            memCacheWidth: cacheWidth,
          );
        },
        childCount: movies.length,
        addAutomaticKeepAlives: false, // Reduce memory overhead
        addRepaintBoundaries: true, // Optimize repaints
      ),
    );
  }
}
