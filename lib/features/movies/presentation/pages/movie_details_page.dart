// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../injection_container.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
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
import '../../../../core/services/miniplayer_height_notifier.dart';

// New Imports
import '../widgets/movie_details_header.dart';
import '../widgets/movie_info_section.dart';
import '../widgets/movie_cast_section.dart';
// import '../widgets/movie_recommendations_section.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;
  final String mediaType;
  final Movie? moviePreview;
  final String? initialEpisodeId;
  final int? initialTimestamp;

  const MovieDetailsPage({
    super.key,
    required this.movieId,
    required this.mediaType,
    this.moviePreview,
    this.initialEpisodeId,
    this.initialTimestamp,
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
        initialEpisodeId: initialEpisodeId,
        initialTimestamp: initialTimestamp,
      ),
    );
  }
}

class MovieDetailsView extends StatefulWidget {
  final String movieId;
  final String mediaType;
  final Movie? moviePreview;
  final String? initialEpisodeId;
  final int? initialTimestamp;

  const MovieDetailsView({
    super.key,
    required this.movieId,
    required this.mediaType,
    this.moviePreview,
    this.initialEpisodeId,
    this.initialTimestamp,
  });

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  // bool _showRecommendations = false;
  final _playDebouncer = Debouncer(milliseconds: 500);
  bool _hasPrecachedImage = false;

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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (mounted) {
  //       setState(() {
  //         _showRecommendations = true;
  //       });
  //     }
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheMovieImage();
  }

  @override
  void dispose() {
    _playDebouncer.dispose();
    super.dispose();
  }

  void _precacheMovieImage() {
    if (_hasPrecachedImage) return;

    final movie = widget.moviePreview;
    if (movie != null) {
      final imageUrl = movie.poster ?? movie.cover;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        precacheImage(CachedNetworkImageProvider(imageUrl), context);
        _hasPrecachedImage = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          if (state is MovieDetailsLoaded && widget.initialEpisodeId != null) {
            final movie = state.movie;
            final episodes = movie.episodes;
            if (episodes != null) {
              try {
                final episode = episodes.firstWhere(
                  (e) => e.id == widget.initialEpisodeId,
                );

                // Calculate start position
                Duration startPos = Duration.zero;
                if (widget.initialTimestamp != null) {
                  startPos = Duration(seconds: widget.initialTimestamp!);
                } else {
                  // Fallback to history if no timestamp provided
                  startPos =
                      _getStartPosition(context, episode.id) ?? Duration.zero;
                }

                // Trigger playback
                context.read<VideoPlayerBloc>().add(
                      PlayVideo(
                        episodeId: episode.id,
                        mediaId: movie.id,
                        title: movie.title,
                        posterUrl:
                            (episode.image != null && episode.image!.isNotEmpty)
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
              } catch (_) {
                debugPrint(
                  'Initial episode not found: ${widget.initialEpisodeId}',
                );
              }
            }
          }
        },
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
                    _playDebouncer.run(() {
                      if (!mounted) return;
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
                    });
                  };

            return CustomScrollView(
              slivers: [
                MovieDetailsHeader(
                  movie: movie,
                  isLoading: isLoading,
                  onPlayPressed: onPlayPressed,
                ),
                MovieInfoSection(movie: movie, isLoading: isLoading),

                if (isLoading)
                  const SliverToBoxAdapter(child: SizedBox(height: 100))
                else ...[
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
                                color: colorScheme.onSurface
                                    .withOpacity(0.6),
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

                  MovieCastSection(movie: movie),

                  // MovieRecommendationsSection(
                  //   recommendations: movie.recommendations ?? [],
                  //   showRecommendations: _showRecommendations,
                  // ),
                ],

                // Add bottom padding for Miniplayer
                SliverToBoxAdapter(
                  child: ListenableBuilder(
                    listenable: getIt<MiniplayerHeightNotifier>(),
                    builder: (context, _) {
                      final height = getIt<MiniplayerHeightNotifier>().height;
                      return SizedBox(height: height + 16);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
