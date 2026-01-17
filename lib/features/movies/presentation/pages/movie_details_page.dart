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
          create: (context) =>
              getIt<MovieDetailsBloc>()
                ..add(LoadMovieDetails(id: movieId, type: mediaType)),
        ),
        // HistoryBloc is now global in MyApp, no need to provide it locally
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
    // Defer recommendations rendering to improve initial load
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
            // Only loaded movie has episodes
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
                          posterUrl:
                              (firstEpisode.image != null &&
                                  firstEpisode.image!.isNotEmpty)
                              ? firstEpisode.image
                              : (movie.poster ?? movie.cover),
                          episodeTitle: firstEpisode.title.isNotEmpty
                              ? firstEpisode.title
                              : 'Episode ${firstEpisode.number}',
                          startPosition: startPos,
                          mediaType: movie.type,
                          movie: movie, // Pass movie
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
                          movie: movie, // Pass movie
                        ),
                      );
                    }
                  };

            return CustomScrollView(
              slivers: [
                // 1. Hero AppBar
                SliverAppBar(
                  expandedHeight: 450,
                  pinned: true,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: 'poster_${movie.id}',
                          child: AppCachedImage(
                            imageUrl: movie.poster ?? movie.cover ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.5),
                                Theme.of(context).colorScheme.surface,
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                          ),
                        ),
                        // Content Overlay
                        Positioned(
                          bottom: 20,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface, // Adapted to theme
                                      letterSpacing: 1.0,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface
                                              .withValues(
                                                alpha: 0.8,
                                              ), // Shadow color adapted
                                          offset: const Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                              ),
                              const SizedBox(height: 12),
                              if (isLoading)
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                )
                              else
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (movie.releaseDate != null) ...[
                                      Text(
                                        movie.releaseDate!.split('-').first,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                    if (movie.duration != null) ...[
                                      Text(
                                        movie.duration!,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        movie.type == 'TV Series' ? 'TV' : 'HD',
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 24),
                              if (!isLoading)
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton.icon(
                                    onPressed: onPlayPressed,
                                    icon: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 28,
                                    ),
                                    label: const Text(
                                      'Play Now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Details Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isLoading)
                          _buildSkeletonText()
                        else if (movie.description != null) ...[
                          Text(
                            movie.description!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.8),
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Genres
                        if (!isLoading)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres.map((genre) {
                              return Chip(
                                label: Text(genre),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                labelStyle: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide.none,
                                ),
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 24),

                        // Info Grid
                        if (!isLoading)
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            children: [
                              if (movie.rating != null)
                                _buildInfoItem(
                                  context,
                                  'Rating',
                                  '${movie.rating!.toStringAsFixed(1)}/10',
                                  Icons.star_rounded,
                                  Colors.amber,
                                ),
                              if (movie.country != null)
                                _buildInfoItem(
                                  context,
                                  'Country',
                                  movie.country!,
                                  Icons.public,
                                  Colors.blueAccent,
                                ),
                              if (movie.production != null)
                                _buildInfoItem(
                                  context,
                                  'Production',
                                  movie.production!,
                                  Icons.business,
                                  Colors.purpleAccent,
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (isLoading)
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100), // Placeholder space
                  )
                else ...[
                  // Episode List / Season Selector
                  if (!isLoading &&
                      movie.episodes != null &&
                      movie.episodes!.isNotEmpty) ...[
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
                                // Color handled by theme default or inherit
                              ),
                            ),
                            // Show aired/total episodes count
                            Text(
                              '${movie.episodes?.length ?? 0} episodes total',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
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
                            posterUrl:
                                (episode.image != null &&
                                    episode.image!.isNotEmpty)
                                ? episode.image
                                : (movie.poster ?? movie.cover),
                            episodeTitle: episode.title.isNotEmpty
                                ? episode.title
                                : 'Episode ${episode.number}',
                            startPosition: startPos,
                            mediaType: movie.type,
                            movie: movie, // Pass movie
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],

                  // 3. Casts
                  if (movie.casts != null && movie.casts!.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color handled by theme
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

                  // 4. Recommendations (deferred loading)
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
                            // color handled by theme
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

  Widget _buildSkeletonText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 16,
          width: 300,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 250,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 280,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
