// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/content_unavailable_widget.dart';
import '../../../../features/history/presentation/bloc/history_bloc.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';
import '../bloc/movie_details/movie_details_bloc.dart';
import '../bloc/movie_details/movie_details_event.dart';
import '../bloc/movie_details/movie_details_state.dart';
import '../../domain/entities/episode.dart';
import '../../domain/entities/movie.dart';
import '../widgets/season_selector.dart';
import '../widgets/episode_sliver_list.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';

// New Imports
import '../widgets/movie_details_header.dart';
import '../widgets/movie_info_section.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;
  final String mediaType;
  final Movie? moviePreview;

  const MovieDetailsPage({
    super.key,
    required this.movieId,
    required this.mediaType,
    this.moviePreview,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MovieDetailsBloc>()
            ..add(LoadMovieDetails(id: movieId, type: mediaType)),
        ),
      ],
      child: MovieDetailsView(
        movieId: movieId,
        mediaType: mediaType,
        moviePreview: moviePreview,
      ),
    );
  }
}

class MovieDetailsView extends StatefulWidget {
  final String movieId;
  final String mediaType;
  final Movie? moviePreview;

  const MovieDetailsView({
    super.key,
    required this.movieId,
    required this.mediaType,
    this.moviePreview,
  });

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  bool _showRecommendations = false;

  Duration? _getStartPosition(BuildContext context, String episodeId) {
    final state = context.read<HistoryBloc>().state;
    if (state is HistoryLoaded) {
      try {
        final progress = state.history.firstWhere(
          (element) =>
              element.episodeId == episodeId &&
              element.mediaId == widget.movieId,
        );
        return Duration(seconds: progress.positionSeconds);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _showRecommendations = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: Calculate optimal memory cache size for recommendation items.
    // (Screen Width - Padding - Spacing) / Columns * Pixel Density
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Padding: 16 (left) + 16 (right) = 32
    // CrossAxisSpacing: 12
    // Columns: 2
    final itemWidth = (screenWidth - 32 - 12) / 2;
    final memCacheWidth = (itemWidth * devicePixelRatio).toInt();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          Movie? movieToRender;
          bool isLoading = false;
          int selectedSeason = 1;
          List<Episode> episodesToShow = [];

          if (state is MovieDetailsLoaded) {
            movieToRender = state.movie;
            selectedSeason = state.selectedSeason;
            episodesToShow = state.filteredEpisodes;
          } else if (state is MovieDetailsLoading) {
            movieToRender = widget.moviePreview;
            isLoading = true;
          }

          if (state is MovieDetailsLoading && movieToRender == null) {
            return const Center(child: LoadingIndicator());
          }

          if (state is MovieDetailsError) {
            if (state.message.contains('unavailable') ||
                state.message.contains('corrupted')) {
              return ContentUnavailableWidget(message: state.message);
            }
            return Center(
              child: AppErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<MovieDetailsBloc>().add(
                        LoadMovieDetails(
                          id: widget.movieId,
                          type: widget.mediaType,
                        ),
                      );
                },
              ),
            );
          }

          if (movieToRender != null) {
            final movie = movieToRender;
            final List<Episode> allEpisodes = movie.episodes ?? [];
            final List<Episode> episodes = allEpisodes.where((ep) {
              if (ep.releaseDate != null &&
                  ep.releaseDate!.isAfter(DateTime.now())) {
                return false;
              }
              return true;
            }).toList();
            final bool hasEpisodes = episodes.isNotEmpty;

            final historyState = context.watch<HistoryBloc>().state;
            final List<WatchProgress> watchProgress =
                historyState is HistoryLoaded ? historyState.history : [];

            final VoidCallback? onPlayPressed = isLoading
                ? null
                : () {
                    if (hasEpisodes) {
                      final firstEpisode = episodes.first;
                      final startPos = _getStartPosition(
                        context,
                        firstEpisode.id,
                      );

                      context.read<VideoPlayerBloc>().add(
                            PlayVideo(
                              episodeId: firstEpisode.id,
                              mediaId: movie.id,
                              title: movie.title,
                              posterUrl: (firstEpisode.image != null &&
                                      firstEpisode.image!.isNotEmpty)
                                  ? firstEpisode.image
                                  : (movie.poster ?? movie.cover),
                              episodeTitle: firstEpisode.title.isNotEmpty
                                  ? firstEpisode.title
                                  : 'Episode ${firstEpisode.number}',
                              startPosition: startPos,
                              mediaType: movie.type,
                              movie: movie,
                            ),
                          );
                    } else if (movie.type.toLowerCase() == 'movie') {
                      final episodeId = movie.episodeId ?? movie.id;
                      final startPos = _getStartPosition(context, episodeId);

                      context.read<VideoPlayerBloc>().add(
                            PlayVideo(
                              episodeId: episodeId,
                              mediaId: movie.id,
                              title: movie.title,
                              posterUrl: movie.poster ?? movie.cover,
                              startPosition: startPos,
                              mediaType: movie.type,
                              movie: movie,
                            ),
                          );
                    }
                  };

            return CustomScrollView(
              slivers: [
                // 1. Refactored Header
                MovieDetailsHeader(
                  movie: movie,
                  isLoading: isLoading,
                  onPlayPressed: onPlayPressed,
                ),

                // 2. Refactored Info Section
                MovieInfoSection(movie: movie, isLoading: isLoading),

                if (isLoading)
                  const SliverToBoxAdapter(child: SizedBox(height: 100))
                else ...[
                  // Episode List
                  if (movie.episodes != null && movie.episodes!.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Episodes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${movie.episodes?.length ?? 0} episodes total',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SeasonSelector(
                        movie: movie,
                        selectedSeason: selectedSeason,
                        onSeasonSelected: (season) {
                          context.read<MovieDetailsBloc>().add(
                                SelectSeason(season),
                              );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    EpisodeSliverList(
                      episodes: episodesToShow,
                      mediaId: movie.id,
                      posterUrl: movie.poster ?? movie.cover,
                      watchProgress: watchProgress,
                      onEpisodeTap: (episode) {
                        final startPos = _getStartPosition(context, episode.id);
                        context.read<VideoPlayerBloc>().add(
                              PlayVideo(
                                episodeId: episode.id,
                                mediaId: movie.id,
                                title: movie.title,
                                posterUrl: (episode.image != null &&
                                        episode.image!.isNotEmpty)
                                    ? episode.image
                                    : (movie.poster ?? movie.cover),
                                episodeTitle: episode.title.isNotEmpty
                                    ? episode.title
                                    : 'Episode ${episode.number}',
                                startPosition: startPos,
                                mediaType: movie.type,
                                movie: movie,
                              ),
                            );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],

                  // Casts
                  if (movie.casts != null && movie.casts!.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: movie.casts!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                movie.casts![index],
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],

                  // Recommendations
                  if (_showRecommendations &&
                      movie.recommendations != null &&
                      movie.recommendations!.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'You May Also Like',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = movie.recommendations![index];
                          return GestureDetector(
                            onTap: () {
                              if (item.id.isEmpty) return;
                              context.push(
                                '/movie/${item.id}?type=${item.type}',
                                extra: item,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: 'poster_${item.id}',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: AppCachedImage(
                                        imageUrl:
                                            item.poster ?? item.cover ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        memCacheWidth: memCacheWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }, childCount: movie.recommendations!.length),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                ],
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
