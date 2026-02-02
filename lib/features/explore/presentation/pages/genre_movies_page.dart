import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';

class GenreMoviesPage extends StatelessWidget {
  final String genreId;
  final String genreName;

  const GenreMoviesPage({
    super.key,
    required this.genreId,
    required this.genreName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExploreBloc>()
            ..add(LoadMoviesByGenre(genreId: genreId, genreName: genreName)),
      child: Scaffold(
        appBar: AppBar(title: Text(genreName)),
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state is ExploreLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is ExploreError) {
              return Center(
                child: AppErrorWidget(
                  message: state.message,
                  onRetry: () {
                    context.read<ExploreBloc>().add(
                      LoadMoviesByGenre(genreId: genreId, genreName: genreName),
                    );
                  },
                ),
              );
            }

            if (state is MoviesLoaded) {
              if (state.movies.isEmpty) {
                return const Center(
                  child: Text('No movies found for this genre'),
                );
              }

              // Calculate optimal cache width to improve performance
              final screenWidth = MediaQuery.of(context).size.width;
              final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
              // Padding (32) + CrossAxisSpacing (12) = 44
              final cacheWidth =
                  ((screenWidth - 44) / 2 * devicePixelRatio).ceil();

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () {
                      context.push(
                        '/movie/${movie.id}?type=${movie.type}',
                        extra: movie,
                      );
                    },
                    memCacheWidth: cacheWidth,
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
