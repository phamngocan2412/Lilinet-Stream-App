import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/genre_card.dart';
import '../widgets/category_chip.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExploreView();
  }
}

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  String _selectedCategory = 'genres';

  @override
  bool get wantKeepAlive => true; // Keep state alive

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    // Optimization: Calculate optimal memory cache size for images.
    final screenWidth = MediaQuery.sizeOf(context).width;
    final itemWidth = (screenWidth - 32 - 12) / 2;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final memCacheWidth = (itemWidth * pixelRatio).toInt();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              title: const Text(
                'Explore',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        CategoryChip(
                          label: 'Genres',
                          icon: Icons.category,
                          isSelected: _selectedCategory == 'genres',
                          onTap: () {
                            setState(() => _selectedCategory = 'genres');
                            context.read<ExploreBloc>().add(const LoadGenres());
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'Popular',
                          icon: Icons.trending_up,
                          isSelected: _selectedCategory == 'popular',
                          onTap: () {
                            setState(() => _selectedCategory = 'popular');
                            context.read<ExploreBloc>().add(
                                  const LoadPopularMovies(),
                                );
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'Top Rated',
                          icon: Icons.star,
                          isSelected: _selectedCategory == 'top_rated',
                          onTap: () {
                            setState(() => _selectedCategory = 'top_rated');
                            context.read<ExploreBloc>().add(
                                  const LoadTopRatedMovies(),
                                );
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: 'Recently Added',
                          icon: Icons.new_releases,
                          isSelected: _selectedCategory == 'recent',
                          onTap: () {
                            setState(() => _selectedCategory = 'recent');
                            context.read<ExploreBloc>().add(
                                  const LoadRecentlyAdded(),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
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
                    if (_selectedCategory == 'genres') {
                      context.read<ExploreBloc>().add(const LoadGenres());
                    } else if (_selectedCategory == 'popular') {
                      context.read<ExploreBloc>().add(
                            const LoadPopularMovies(),
                          );
                    } else if (_selectedCategory == 'top_rated') {
                      context.read<ExploreBloc>().add(
                            const LoadTopRatedMovies(),
                          );
                    } else if (_selectedCategory == 'recent') {
                      context.read<ExploreBloc>().add(
                            const LoadRecentlyAdded(),
                          );
                    }
                  },
                ),
              );
            }

            if (state is GenresLoaded) {
              return ListenableBuilder(
                listenable: getIt<MiniplayerHeightNotifier>(),
                builder: (context, _) {
                  final miniplayerHeight =
                      getIt<MiniplayerHeightNotifier>().height;

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ExploreBloc>().add(const LoadGenres());
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: miniplayerHeight + 16,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.genres.length,
                      itemBuilder: (context, index) {
                        final genre = state.genres[index];
                        return GenreCard(
                          genre: genre,
                          onTap: () {
                            context.read<ExploreBloc>().add(
                                  LoadMoviesByGenre(
                                    genreId: genre.id,
                                    genreName: genre.name,
                                  ),
                                );
                            setState(
                              () => _selectedCategory = 'genre_${genre.id}',
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }

            if (state is MoviesLoaded) {
              return ListenableBuilder(
                listenable: getIt<MiniplayerHeightNotifier>(),
                builder: (context, _) {
                  final miniplayerHeight =
                      getIt<MiniplayerHeightNotifier>().height;

                  return RefreshIndicator(
                    onRefresh: () async {
                      // Refresh based on current category
                      if (_selectedCategory == 'popular') {
                        context.read<ExploreBloc>().add(
                              const LoadPopularMovies(),
                            );
                      } else if (_selectedCategory == 'top_rated') {
                        context.read<ExploreBloc>().add(
                              const LoadTopRatedMovies(),
                            );
                      } else if (_selectedCategory == 'recent') {
                        context.read<ExploreBloc>().add(
                              const LoadRecentlyAdded(),
                            );
                      } else if (_selectedCategory.startsWith('genre_')) {
                        final genreId = _selectedCategory.replaceFirst(
                          'genre_',
                          '',
                        );
                        context.read<ExploreBloc>().add(
                              LoadMoviesByGenre(
                                genreId: genreId,
                                genreName: 'Genre',
                              ),
                            );
                      }
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: miniplayerHeight + 16,
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
                          onTap: () {
                            context.push(
                              '/movie/${movie.id}?type=${movie.type}',
                              extra: movie,
                            );
                          },
                          memCacheWidth: memCacheWidth,
                        );
                      },
                    ),
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
