import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state_widget.dart';
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
      create: (context) => getIt<ExploreBloc>()
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
                          LoadMoviesByGenre(
                              genreId: genreId, genreName: genreName),
                        );
                  },
                ),
              );
            }

            if (state is MoviesLoaded) {
              if (state.movies.isEmpty) {
                return const EmptyStateWidget(
                  message: 'No movies found for this genre',
                  icon: Icons.movie_outlined,
                );
              }

              return ListenableBuilder(
                listenable: getIt<MiniplayerHeightNotifier>(),
                builder: (context, _) {
                  final miniplayerHeight =
                      getIt<MiniplayerHeightNotifier>().height;
                  final cacheWidth =
                      (MediaQuery.of(context).size.width / 2 - 24).round() * 2;

                  return GridView.builder(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16 + miniplayerHeight,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        memCacheWidth: cacheWidth,
                        onTap: () {
                          context.push(
                            '/movie/${movie.id}?type=${movie.type}',
                            extra: movie,
                          );
                        },
                      );
                    },
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
