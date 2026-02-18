import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/trending_carousel.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../explore/presentation/widgets/category_chip.dart';
import '../../../comments/presentation/widgets/home_trending_section.dart';
import '../bloc/trending_movies/trending_movies_bloc.dart';
import '../bloc/trending_movies/trending_movies_event.dart';
import '../bloc/trending_movies/trending_movies_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // _checkLastSession methods removed

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    // final devicePixelRatio = mediaQuery.devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LILINET',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
            tooltip: AppLocalizations.of(context)!.search,
          ),
          GestureDetector(
            onTap: () => context.push('/settings'),
            child: Container(
              margin: const EdgeInsets.only(right: 16, left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: colorScheme.onPrimaryContainer,
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
          buildWhen: (previous, current) {
            return previous.runtimeType != current.runtimeType ||
                previous.maybeMap(
                  loaded: (p) => current.maybeMap(
                    loaded: (c) =>
                        p.trending != c.trending ||
                        p.categories != c.categories,
                    orElse: () => true,
                  ),
                  orElse: () => true,
                );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: LoadingIndicator()),
              error: (message) => Center(
                child: AppErrorWidget(
                  message: message,
                  onRetry: () {
                    context.read<TrendingMoviesBloc>().add(
                          const TrendingMoviesEvent.load(),
                        );
                  },
                ),
              ),
              loaded: (trending, categories) {
                final trendingMovies = trending.toSet().toList();
                // Optimization: Pre-calculate cache width for horizontal lists
                final devicePixelRatio = MediaQuery.of(
                  context,
                ).devicePixelRatio;
                final categoryMemCacheWidth = (130 * devicePixelRatio).toInt();

                final genres = AppConstants.genres;
                final genreEntries = genres.entries.toList();
                final categoryEntries = categories.entries.toList();

                if (trendingMovies.isEmpty && categories.isEmpty) {
                  return const Center(child: Text('No anime found'));
                }

                // Optimization: Calculate explicit cache width to avoid LayoutBuilder overhead
                final trendingCacheWidth =
                    ((screenWidth - 32) * devicePixelRatio).toInt();

                // Optimization: Pre-calculate category entries to avoid O(N) lookup in builder
                final categoryEntries = categories.entries.toList();

                return CustomScrollView(
                  slivers: [
                    // Genre chips
                    SliverToBoxAdapter(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListView.separated(
                          cacheExtent: 300,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: genres.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final entry = genreEntries[index];
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
                                style: textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TrendingCarousel(
                                movies: trendingMovies.take(5).toList(),
                                memCacheWidth: trendingCacheWidth,
                                onMovieTap: (movie) => context.push(
                                  '/movie/${movie.id}?type=${movie.type}',
                                  extra: movie,
                                ),
                              ),
                            ],
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),

                    // Trending Comments Section
                    const SliverToBoxAdapter(child: HomeTrendingSection()),

                    // Dynamic Categories
                    if (categoryEntries.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final entry = categoryEntries[index];
                          final categoryName = entry.key;
                          final categoryMovies = entry.value;

                          // Optimization: Calculate explicit cache width (130px * pixelRatio)
                          // to avoid LayoutBuilder overhead in MovieCard -> AppCachedImage
                          // Uses devicePixelRatio from parent scope to avoid repetitive MediaQuery lookups
                          final memCacheWidth =
                              (130 * devicePixelRatio).toInt();

                          if (categoryMovies.isEmpty) {
                            return const SizedBox.shrink();
                          }

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
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.secondary,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        String lookupKey = categoryName;
                                        if (categoryName == 'Top Anime') {
                                          lookupKey = 'Anime';
                                        }
                                        if (categoryName == 'Action Movies') {
                                          lookupKey = 'Action';
                                        }

                                        final genreId = genres[lookupKey] ??
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
                                height: 200,
                                child: ListView.builder(
                                  cacheExtent: 300,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  itemCount: categoryMovies.length,
                                  itemExtent: 142, // 130 width + 12 spacing
                                  itemBuilder: (context, index) {
                                    final movie = categoryMovies[index];
                                    return Container(
                                      width: 130,
                                      margin: const EdgeInsets.only(right: 12),
                                      child: MovieCard(
                                        movie: movie,
                                        memCacheWidth: categoryMemCacheWidth,
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
                        }, childCount: categoryEntries.length),
                      ),

                    // Dynamic bottom padding for miniplayer
                    SliverToBoxAdapter(
                      child: ListenableBuilder(
                        listenable: getIt<MiniplayerHeightNotifier>(),
                        builder: (context, _) {
                          final miniplayerHeight =
                              getIt<MiniplayerHeightNotifier>().height;
                          // Add extra 16px padding for spacing
                          return SizedBox(height: miniplayerHeight + 16);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
