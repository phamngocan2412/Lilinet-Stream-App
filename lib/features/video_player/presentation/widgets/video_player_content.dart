// ignore_for_file: deprecated_member_use, unreachable_switch_default

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../injection_container.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../../core/services/video_session_repository.dart';
import '../../../../core/services/network_monitor_service.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../history/domain/entities/watch_progress.dart';
import '../../../history/presentation/bloc/history_bloc.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../../../settings/domain/entities/app_settings.dart';

import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';
import '../bloc/streaming_state.dart';

import 'mini_player_content.dart';
import 'full_player_content.dart';
import 'expanded_player_content.dart';
import 'video_error_widget.dart';

import '../../../../core/network/network_cubit.dart';
import '../../../../core/utils/media_type_helper.dart';

import '../../../../features/movies/domain/usecases/get_movie_details.dart';

// Colors
const kBgColor = Color(0xFF101010);
const kOrangeColor = Color(0xFFC6A664);

class VideoPlayerContent extends StatefulWidget {
  final VideoPlayerState state;
  final bool isMini;
  final double percentage;
  final MiniplayerController miniplayerController;
  final double height;
  final double miniplayerHeight;

  const VideoPlayerContent({
    super.key,
    required this.state,
    required this.isMini,
    required this.percentage,
    required this.miniplayerController,
    required this.height,
    required this.miniplayerHeight,
  });

  @override
  State<VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<VideoPlayerContent>
    with WidgetsBindingObserver {
  final GlobalKey _videoKey = GlobalKey();

  // Access video service via Bloc to keep widget "dumb" about service instantiation
  late final VideoPlayerService _videoService;

  late VideoSessionRepository _videoSessionRepository;

  String? _playbackError;

  VideoQuality _defaultQuality = VideoQuality.auto;

  // Offline handling - used for auto-resume when connection restored
  bool _wasPlayingBeforeOffline = false;

  // Countdown handling
  bool _showCountdown = false;
  String? _nextEpisodeTitle;

  bool _isPlayerInitialized = false;
  bool _isPreloaded = false; // Track if next episode is preloaded

  // Stream subscription for player state
  StreamSubscription<bool>? _playingSubscription;
  String? _initialQualityAppliedEpisodeId;

  @override
  void initState() {
    super.initState();
    debugPrint('🏗️ VideoPlayerContent: initState');
    WidgetsBinding.instance.addObserver(this);
    WakelockPlus.enable();

    _videoService = context.read<VideoPlayerBloc>().videoService;

    // Services are now handled by Bloc, except VideoSessionRepository which is used for saving state
    // Ideally this should also be in Bloc, but minimizing changes for now
    _videoSessionRepository = getIt<VideoSessionRepository>();

    _initPlayer();
    _loadSettingsAndVideo();

    // H-003: If movie details are missing (restored session), fetch them
    if (widget.state.movie == null && widget.state.mediaId != null) {
      _fetchMovieDetails();
    }

    // Listen to player playing state
    _playingSubscription =
        _videoService.player.stream.playing.listen((playing) {
      // Handle playing state changes
    });

    if (widget.state.status == VideoPlayerStatus.expanded) {
      // Schedule the expansion after the first frame to prevent layout conflicts
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.miniplayerController.animateToHeight(state: PanelState.MAX);
        }
      });
    }
  }

  // H-003: Fetch movie details for restored sessions
  Future<void> _fetchMovieDetails() async {
    try {
      final getMovieDetails = getIt<GetMovieDetails>();
      final result = await getMovieDetails(
        GetMovieDetailsParams(
          id: widget.state.mediaId!,
          type: widget.state.mediaType ?? 'Movie',
        ),
      );

      if (!mounted) return;

      result.fold(
        (failure) {
          debugPrint(
            '⚠️ Failed to fetch movie details for restored session: ${failure.message}',
          );
        },
        (movie) {
          debugPrint('✅ Restored movie details for: ${movie.title}');
          // H-003 FIX: Use UpdateMovieDetails instead of PlayVideo to avoid
          // double-dispatch and playback reset when player is already running
          context.read<VideoPlayerBloc>().add(UpdateMovieDetails(movie));
        },
      );
    } catch (e) {
      debugPrint('⚠️ Error fetching movie details: $e');
    }
  }

  @override
  void didUpdateWidget(VideoPlayerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload if episode changed
    if (widget.state.episodeId != oldWidget.state.episodeId ||
        widget.state.mediaId != oldWidget.state.mediaId) {
      _initialQualityAppliedEpisodeId = null;
      _isPreloaded = false;

      // Reset error state
      setState(() {
        _playbackError = null;
      });

      _loadSettingsAndVideo();
    }
  }

  Future<void> _initPlayer() async {
    // Attach callbacks
    // Note: Ideally these should also be handled by Bloc via streams
    _videoService.onPositionChanged = _saveProgress;
    _videoService.onVideoCompleted = _onVideoCompleted;
    _videoService.onError = (error) {
      if (kDebugMode) {
        debugPrint('❌ Video error: $error');
      }
      // H-002: Show error UI
      if (mounted) {
        setState(() {
          _playbackError = error;
        });
      }
    };
    _videoService.onQualitySwitchStateChanged = (isSwitching) {
      if (mounted) setState(() {});
    };

    // Initialize is safe to call multiple times (checked inside service)
    await _videoService.initialize();
    if (mounted) {
      setState(() {
        _isPlayerInitialized = true;
      });
      debugPrint('✅ VideoPlayerContent: Player initialized');
    }
  }

  bool _autoPlayEnabled = false;

  Future<void> _loadSettingsAndVideo() async {
    final result = await getIt<SettingsRepository>().getSettings();
    result.fold(
      (l) {
        // If fails, keep defaults
      },
      (settings) {
        if (mounted) {
          setState(() {
            _autoPlayEnabled = settings.autoPlay;
            _defaultQuality = settings.defaultQuality;
          });
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      context.read<VideoPlayerBloc>().add(PauseVideoPlayback());
    }
  }

  @override
  void dispose() {
    debugPrint('🗑️ VideoPlayerContent: dispose');
    WidgetsBinding.instance.removeObserver(this);
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Cancel stream subscription to prevent memory leak
    _playingSubscription?.cancel();

    // Detach callbacks but don't dispose service to keep player alive
    _videoService.detachCallbacks();

    super.dispose();
  }

  void _onVideoCompleted() {
    // Only auto-play for series (TV/Anime) if setting enabled
    if (!_autoPlayEnabled ||
        !MediaTypeHelper.isSeries(widget.state.mediaType)) {
      return;
    }

    final movie = widget.state.movie;
    if (movie != null) {
      final episodes = movie.episodes;
      if (episodes != null && episodes.isNotEmpty) {
        final currentIndex = episodes.indexWhere(
          (e) => e.id == widget.state.episodeId,
        );

        // Check if there is a next episode
        if (currentIndex != -1 && currentIndex < episodes.length - 1) {
          final nextEpisode = episodes[currentIndex + 1];
          setState(() {
            _nextEpisodeTitle = nextEpisode.title;
            _showCountdown = true;
          });
        }
      }
    }
  }

  /// Preload next episode when current episode is 70% complete
  void _preloadNextEpisode(Duration position, Duration duration) {
    // Only preload for series (TV/Anime)
    if (!MediaTypeHelper.isSeries(widget.state.mediaType)) return;

    // Check if we're at 70% of the video
    if (duration.inSeconds > 0 &&
        position.inSeconds > (duration.inSeconds * 0.7) &&
        !_isPreloaded) {
      _isPreloaded = true;

      final movie = widget.state.movie;
      if (movie != null) {
        final episodes = movie.episodes;
        if (episodes != null && episodes.isNotEmpty) {
          final currentIndex = episodes.indexWhere(
            (e) => e.id == widget.state.episodeId,
          );

          // Preload next episode if exists
          if (currentIndex != -1 && currentIndex < episodes.length - 1) {
            final nextEpisode = episodes[currentIndex + 1];
            debugPrint('📦 Preload skipped (single-source streaming state)');
            debugPrint('   Next episode candidate: ${nextEpisode.id}');
          }
        }
      }
    }
  }

  void _playPreviousEpisode() {
    final movie = widget.state.movie;
    if (movie != null) {
      final episodes = movie.episodes;
      if (episodes == null || episodes.isEmpty) return;

      final currentIndex = episodes.indexWhere(
        (e) => e.id == widget.state.episodeId,
      );

      if (currentIndex > 0) {
        final prevEpisode = episodes[currentIndex - 1];
        context.read<VideoPlayerBloc>().add(
              PlayVideo(
                episodeId: prevEpisode.id,
                mediaId: widget.state.mediaId!,
                title: widget.state.title!,
                posterUrl: widget.state.posterUrl,
                episodeTitle: prevEpisode.title,
                mediaType: widget.state.mediaType,
                movie: movie,
              ),
            );
      }
    }
  }

  void _playNextEpisode() {
    final movie = widget.state.movie;
    if (movie != null) {
      final episodes = movie.episodes;
      if (episodes == null || episodes.isEmpty) return;

      final currentIndex = episodes.indexWhere(
        (e) => e.id == widget.state.episodeId,
      );

      if (currentIndex != -1 && currentIndex < episodes.length - 1) {
        final nextEpisode = episodes[currentIndex + 1];
        context.read<VideoPlayerBloc>().add(
              PlayVideo(
                episodeId: nextEpisode.id,
                mediaId: widget.state.mediaId!,
                title: widget.state.title!,
                posterUrl: widget.state.posterUrl,
                episodeTitle: nextEpisode.title,
                mediaType: widget.state.mediaType,
                movie: movie,
              ),
            );
      }
    }
  }

  DateTime? _lastSaveTime;
  static const _saveDebounceDuration = Duration(seconds: 5);

  void _saveProgress(Duration position) {
    if (!mounted || _videoService.isDisposed) return;

    final now = DateTime.now();
    if (_lastSaveTime != null &&
        now.difference(_lastSaveTime!) < _saveDebounceDuration) {
      return; // Skip if less than 5 seconds
    }
    _lastSaveTime = now;

    final duration = _videoService.player.state.duration;
    if (duration == Duration.zero) return;

    // Preload next episode when we're at 70% of current episode
    _preloadNextEpisode(position, duration);

    final progress = WatchProgress(
      mediaId: widget.state.mediaId!,
      title: widget.state.title!,
      posterUrl: widget.state.posterUrl,
      episodeId: widget.state.episodeId,
      episodeTitle: widget.state.episodeTitle,
      positionSeconds: position.inSeconds,
      durationSeconds: duration.inSeconds,
      lastUpdated: DateTime.now(),
      isFinished: _isFinished(position, duration),
    );

    context.read<HistoryBloc>().saveProgress(progress);

    // Save active session state for crash recovery
    _videoSessionRepository.saveSession(
      state: widget.state,
      position: position,
    );
  }

  bool _isFinished(Duration position, Duration duration) {
    if (duration.inSeconds == 0) return false;
    final percentage = position.inSeconds / duration.inSeconds;
    return percentage > 0.90;
  }

  @override
  Widget build(BuildContext context) {
    // Use the constraints already provided by parent Miniplayer LayoutBuilder
    return BlocListener<NetworkCubit, bool>(
      listener: (context, isConnected) {
        if (!isConnected) {
          _wasPlayingBeforeOffline = _videoService.player.state.playing;
          context.read<VideoPlayerBloc>().add(PauseVideoPlayback());
        } else {
          if (_wasPlayingBeforeOffline) {
            context.read<VideoPlayerBloc>().add(ResumeVideoPlayback());
          } else {
            // Reload if it failed initially due to network
            if (context.read<VideoPlayerBloc>().state.hasStreamingError) {
              context.read<VideoPlayerBloc>().add(RetryStreaming());
            }
          }
        }
      },
      child: Material(
        color: kBgColor,
        child: SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Video Area
              if (widget.isMini)
                Expanded(child: _buildVideoPlayer())
              else
                SizedBox(
                  height: 250 > widget.height ? widget.height : 250,
                  child: _buildVideoPlayer(),
                ),

              // Expanded Content Area - Only render when needed to prevent
              // blank space showing in miniplayer
              if (!widget.isMini && widget.height > 300)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Absorb tap to prevent miniplayer gesture detection
                    },
                    child: ExpandedPlayerContent(
                      state: widget.state,
                      onMinimize: () {
                        widget.miniplayerController.animateToHeight(
                          state: PanelState.MIN,
                        );
                        context.read<VideoPlayerBloc>().add(MinimizeVideo());
                      },
                      onDownload: () {
                        final url = _videoService
                            .player.state.playlist.medias.firstOrNull?.uri;
                        if (url != null) {
                          final fileName =
                              '${widget.state.title ?? "video"}_${widget.state.episodeTitle ?? "episode"}.mp4'
                                  .replaceAll(RegExp(r'[^\w\s\.-]'), '')
                                  .replaceAll(' ', '_');

                          context.read<VideoPlayerBloc>().add(
                                DownloadCurrentVideo(
                                  url: url,
                                  fileName: fileName,
                                  movieId: widget.state.mediaId,
                                  movieTitle: widget.state.title,
                                  episodeTitle: widget.state.episodeTitle,
                                  posterUrl: widget.state.posterUrl,
                                ),
                              );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Download started...'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No video loaded to download'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onStreamingLoaded(
    VideoPlayerState playerState,
    StreamingLoaded streamingState,
  ) async {
    if (_initialQualityAppliedEpisodeId == playerState.episodeId) {
      return;
    }

    if (!_isPlayerInitialized) {
      int attempts = 0;
      while (!_isPlayerInitialized && mounted && attempts < 50) {
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }
      if (!_isPlayerInitialized || !mounted) {
        return;
      }
    }

    final networkMonitor = NetworkMonitorService();
    final measuredBandwidth = networkMonitor.averageBandwidth;
    final isLowBandwidth = !networkMonitor.isConnected ||
        (measuredBandwidth > 0 && measuredBandwidth < 500 * 1024);

    final preferredLink = VideoPlayerService.selectAdaptiveQuality(
      streamingState.links,
      _defaultQuality,
      isLowBandwidth,
    );

    if (kDebugMode) {
      debugPrint(
        '🔗 Preferred quality: ${preferredLink.quality} (low bandwidth: $isLowBandwidth)',
      );
    }

    _initialQualityAppliedEpisodeId = playerState.episodeId;
    if (preferredLink.quality != playerState.currentQuality) {
      context.read<VideoPlayerBloc>().add(SwitchQuality(preferredLink.quality));
    }
  }

  Widget _buildVideoPlayer() {
    return BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
      listenWhen: (previous, current) {
        return previous.streamingState != current.streamingState ||
            previous.episodeId != current.episodeId;
      },
      buildWhen: (previous, current) {
        if (previous.streamingState.runtimeType !=
            current.streamingState.runtimeType) {
          return true;
        }

        final prevStreaming = previous.streamingState;
        final currentStreaming = current.streamingState;

        if (prevStreaming is StreamingLoaded &&
            currentStreaming is StreamingLoaded) {
          return prevStreaming.links != currentStreaming.links ||
              prevStreaming.selectedServer != currentStreaming.selectedServer ||
              prevStreaming.selectedQuality !=
                  currentStreaming.selectedQuality ||
              previous.currentQuality != current.currentQuality ||
              previous.posterUrl != current.posterUrl;
        }

        if (prevStreaming is StreamingError &&
            currentStreaming is StreamingError) {
          return prevStreaming.message != currentStreaming.message;
        }

        return previous.currentQuality != current.currentQuality ||
            previous.posterUrl != current.posterUrl;
      },
      listener: (context, playerState) {
        final streamingState = playerState.streamingState;
        if (streamingState is StreamingLoaded &&
            streamingState.links.isNotEmpty) {
          _onStreamingLoaded(playerState, streamingState);
        }
      },
      builder: (context, playerState) {
        final streamingState = playerState.streamingState;

        if (_playbackError != null) {
          return Stack(
            children: [
              Container(color: Colors.black),
              VideoErrorWidget(
                message: _playbackError!,
                onRetry: () {
                  setState(() => _playbackError = null);
                  context.read<VideoPlayerBloc>().add(RetryStreaming());
                },
                onClose: () =>
                    context.read<VideoPlayerBloc>().add(CloseVideo()),
              ),
            ],
          );
        }

        if (streamingState is StreamingLoading ||
            streamingState is StreamingInitial ||
            streamingState is StreamingError) {
          return Stack(
            children: [
              if (playerState.posterUrl != null)
                AppCachedImage(
                  imageUrl: playerState.posterUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              Container(color: Colors.black54),
              if (streamingState is StreamingLoading)
                VideoPlayerShimmer(isMini: widget.isMini),
              if (streamingState is StreamingError)
                VideoErrorWidget(
                  message: streamingState.message,
                  onRetry: () =>
                      context.read<VideoPlayerBloc>().add(RetryStreaming()),
                  onClose: () =>
                      context.read<VideoPlayerBloc>().add(CloseVideo()),
                ),
              if (streamingState is StreamingLoading && widget.isMini)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      context.read<VideoPlayerBloc>().add(CloseVideo());
                    },
                    tooltip: AppLocalizations.of(context)!.close,
                  ),
                ),
            ],
          );
        }

        if (widget.isMini) {
          return MiniPlayerContent(
            state: playerState,
            videoService: _videoService,
            miniplayerHeight: widget.miniplayerHeight,
            videoKey: _videoKey,
            miniplayerController: widget.miniplayerController,
          );
        }

        final loadedStreaming =
            streamingState is StreamingLoaded ? streamingState : null;

        return FullPlayerContent(
          state: playerState,
          videoService: _videoService,
          videoKey: _videoKey,
          miniplayerController: widget.miniplayerController,
          showCountdown: _showCountdown,
          nextEpisodeTitle: _nextEpisodeTitle,
          availableServers: playerState.availableServers ?? [],
          currentServer: playerState.currentServer,
          availableQualities: loadedStreaming?.links ?? [],
          currentQuality: playerState.currentQuality,
          onServerSelected: (server) {
            context.read<VideoPlayerBloc>().add(SwitchServer(server));
          },
          onQualitySelected: (link) {
            context.read<VideoPlayerBloc>().add(SwitchQuality(link.quality));
          },
          onDownload: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Download started...')),
            );
          },
          onPlayNext: _playNextEpisode,
          onPlayPrevious: _playPreviousEpisode,
          onCancelCountdown: () {
            setState(() {
              _showCountdown = false;
            });
          },
          onDismissCountdown: () {
            setState(() {
              _showCountdown = false;
            });
            _playNextEpisode();
          },
        );
      },
    );
  }
}
