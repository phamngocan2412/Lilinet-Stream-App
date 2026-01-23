import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../explore/presentation/widgets/category_chip.dart';
import '../bloc/trending_movies/trending_movies_bloc.dart';
import '../bloc/trending_movies/trending_movies_event.dart';
import '../bloc/trending_movies/trending_movies_state.dart';
import '../widgets/trending_carousel.dart';
import '../widgets/movie_list.dart';
import '../widgets/movie_card.dart'; // Add this import

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LILINET',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          GestureDetector(
            onTap: () => context.push('/settings'),
            child: Container(
              margin: const EdgeInsets.only(right: 16, left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
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
              final trendingMovies = state.trending
                  .toSet()
                  .toList(); // Deduplicate
              final categories = state.categories;

              final genres = {
                'Action': '28',
                'Adventure': '12',
                'Anime': '16',
                'Comedy': '35',
                'Crime': '80',
                'Drama': '18',
                'Horror': '27',
                'Sci-Fi': '878',
                'Romance': '10749',
              };

              if (trendingMovies.isEmpty && categories.isEmpty) {
                return const Center(child: Text('No anime found'));
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: genres.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final entry = genres.entries.elementAt(index);
                          return Center(
                            child: CategoryChip(
                              label: entry.key,
                              isSelected: false,
                              onTap: () {
                                context.push(
                                  '/genre/${entry.value}?name=${entry.key}',
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (trendingMovies.isNotEmpty) ...[
                            Text(
                              'TRENDING NOW',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            TrendingCarousel(
                              movies: trendingMovies.take(5).toList(),
                              onMovieTap: (movie) => context.push(
                                '/movie/${movie.id}?type=${movie.type}',
                                extra: movie,
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Dynamic Categories
                  if (categories.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final categoryName = categories.keys.elementAt(index);
                        final categoryMovies = categories[categoryName]!;

                        if (categoryMovies.isEmpty)
                          return const SizedBox.shrink();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoryName.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          letterSpacing: 1.0,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Better mapping logic
                                      String lookupKey = categoryName;
                                      if (categoryName == 'Top Anime')
                                        lookupKey = 'Anime';
                                      if (categoryName == 'Action Movies')
                                        lookupKey = 'Action';

                                      final genreId =
                                          genres[lookupKey] ??
                                          genres[categoryName
                                              .replaceAll('Movies', '')
                                              .trim()];

                                      if (genreId != null) {
                                        context.push(
                                          '/genre/$genreId?name=$lookupKey',
                                        );
                                      }
                                    },
                                    child: const Text('See All'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200, // Adjust based on card height
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: categoryMovies.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final movie = categoryMovies[index];
                                  return SizedBox(
                                    width:
                                        130, // Fixed width for horizontal items
                                    child: MovieCard(
                                      movie: movie,
                                      width: 130,
                                      height: 200,
                                      onTap: () => context.push(
                                        '/movie/${movie.id}?type=${movie.type}',
                                        extra: movie,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      }, childCount: categories.length),
                    ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ), // Bottom padding
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
