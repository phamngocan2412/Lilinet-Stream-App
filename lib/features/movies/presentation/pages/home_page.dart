import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../bloc/trending_movies/trending_movies_bloc.dart';
import '../bloc/trending_movies/trending_movies_event.dart';
import '../bloc/trending_movies/trending_movies_state.dart';
import '../widgets/trending_carousel.dart';
import '../widgets/movie_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TrendingMoviesBloc>()..add(const LoadTrendingMovies()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lilinet')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TrendingMoviesBloc>().add(const RefreshTrendingMovies());
        },
        child: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
          builder: (context, state) {
            if (state is TrendingMoviesLoading) {
              return const Center(child: LoadingIndicator());
            }

            if (state is TrendingMoviesError) {
              return Center(
                child: AppErrorWidget(
                  message: state.message,
                  onRetry: () {
                    context.read<TrendingMoviesBloc>().add(
                      const LoadTrendingMovies(),
                    );
                  },
                ),
              );
            }

            if (state is TrendingMoviesLoaded) {
              final movies = state.movies.toSet().toList(); // Deduplicate

              if (movies.isEmpty) {
                return const Center(child: Text('No movies found'));
              }

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RECOMMENDED',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w300, // Thin font
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.tertiary, // Themed Gold/Accent
                                  letterSpacing: 1.2,
                                ),
                          ),
                          const SizedBox(height: 16),
                          TrendingCarousel(
                            movies: movies.take(5).toList(),
                            onMovieTap: (movie) => context.push(
                              '/movie/${movie.id}?type=${movie.type}',
                              extra: movie,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'NEWLY UPDATED',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).colorScheme.tertiary,
                                  letterSpacing: 1.2,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Divider(
                            color: Theme.of(context).colorScheme.tertiary,
                            thickness: 1,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: MovieList(
                      movies: movies,
                      heroTagPrefix: 'trending_list',
                      onMovieTap: (movie) => context.push(
                        '/movie/${movie.id}?type=${movie.type}',
                        extra: movie,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
