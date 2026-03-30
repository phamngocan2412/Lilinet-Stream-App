import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieTap;

  const MovieList({super.key, required this.movies, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2;
    const double crossAxisSpacing = 12.0;

    // Calculate optimal cache width for grid items
    // (Screen Width - Padding) / Columns * Pixel Density
    final screenWidth = MediaQuery.sizeOf(context).width;
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    // Assuming 32px horizontal padding (16*2) and 12px spacing.
    // Being slightly generous to be safe.
    final cacheWidth = ((screenWidth - 32) / crossAxisCount * devicePixelRatio)
        .ceil();

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
            key: ValueKey(movie.id),
            movie: movie,
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
