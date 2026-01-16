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
          );
        },
        childCount: movies.length,
        addAutomaticKeepAlives: false, // Reduce memory overhead
        addRepaintBoundaries: true, // Optimize repaints
      ),
    );
  }
}
