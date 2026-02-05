// ignore_for_file: deprecated_member_use, unreachable_switch_default

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/core/constants/streaming_config.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../injection_container.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../../core/services/video_session_repository.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../history/domain/entities/watch_progress.dart';
import '../../../history/presentation/bloc/history_bloc.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';

import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

import 'mini_player_content.dart';
import 'full_player_content.dart';
import 'expanded_player_content.dart';
import 'video_error_widget.dart';

import '../../../../core/network/network_cubit.dart';

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
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final GlobalKey _videoKey = GlobalKey();

  @override
  bool get wantKeepAlive => true; // Prevent disposal when scrolling

  // Access video service via Bloc to keep widget "dumb" about service instantiation
  late final VideoPlayerService _videoService;

  late VideoSessionRepository _videoSessionRepository;

  String? _currentServer = 'vidcloud';

  // Streaming Cubit instance managed here to reset on new video
  late StreamingCubit _streamingCubit;
  String? _movieProvider;
  String? _animeProvider;
  VideoQuality _defaultQuality = VideoQuality.auto;
  PreferredServer _preferredServer = PreferredServer.auto;

  // Offline handling
  bool _isOffline = false;
  bool _wasPlayingBeforeOffline = false;

  // Countdown handling
  bool _showCountdown = false;
  String? _nextEpisodeTitle;

  bool _isPlayerInitialized = false;

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
    _streamingCubit = getIt<StreamingCubit>();
    _loadSettingsAndVideo();

    if (widget.state.status == VideoPlayerStatus.expanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.miniplayerController.animateToHeight(state: PanelState.MAX);
      });
    }
  }

  @override
  void didUpdateWidget(VideoPlayerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload if episode changed
    if (widget.state.episodeId != oldWidget.state.episodeId ||
        widget.state.mediaId != oldWidget.state.mediaId) {
      // Close old cubit and get a new one for the new video
      _streamingCubit.close();
      _streamingCubit = getIt<StreamingCubit>();
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
        // If fails, use defaults (Fastest)
        _movieProvider = 'flixhq';
        _animeProvider = 'animepahe';
        _loadVideo();
      },
      (settings) {
        if (mounted) {
          setState(() {
            _autoPlayEnabled = settings.autoPlay;
            _movieProvider = settings.movieProvider;
            _animeProvider = settings.animeProvider;
            _defaultQuality = settings.defaultQuality;
            _preferredServer = settings.preferredServer;
          });
          _loadVideo();
        }
      },
    );
  }

  void _loadVideo() {
    // Use movie's stored provider if it exists, otherwise fall back to genres check
    final provider =
        widget.state.movie?.provider ??
        StreamingConfig.determineProvider(
          genres: widget.state.movie?.genres,
          movieProviderPref: _movieProvider,
          animeProviderPref: _animeProvider,
        );

    _streamingCubit.loadLinks(
      episodeId: widget.state.episodeId!,
      mediaId: widget.state.mediaId!,
      provider: provider,
      preferredServer: _preferredServer,
    );
  }

  void _switchServer(String server) {
    setState(() {
      _currentServer = server;
    });

    final provider =
        widget.state.movie?.provider ??
        StreamingConfig.determineProvider(
          genres: widget.state.movie?.genres,
          movieProviderPref: _movieProvider,
          animeProviderPref: _animeProvider,
        );

    _streamingCubit.loadLinks(
      episodeId: widget.state.episodeId!,
      mediaId: widget.state.mediaId!,
      server: server,
      provider: provider,
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

    // Detach callbacks but don't dispose service to keep player alive
    _videoService.detachCallbacks();

    // Do NOT close the singleton Cubit
    // BUT since we changed it to Factory, we SHOULD close it now!
    _streamingCubit.close();
    super.dispose();
  }

  void _onVideoCompleted() {
    // Only auto-play for TV Series if setting enabled
    if (!_autoPlayEnabled || widget.state.mediaType != 'TV Series') return;

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

  void _playVideo(
    String url, {
    String? subtitleUrl,
    String? subtitleLang,
    Map<String, String>? headers,
    bool isQualitySwitch = false,
  }) {
    if (!mounted) {
      debugPrint(
        '⚠️ VideoPlayerContent: _playVideo called but widget not mounted',
      );
      return;
    }
    context.read<VideoPlayerBloc>().add(
      LoadVideo(
        url: url,
        subtitleUrl: subtitleUrl,
        subtitleLang: subtitleLang,
        headers: headers,
        isQualitySwitch: isQualitySwitch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocListener<NetworkCubit, bool>(
      listener: (context, isConnected) {
        if (!isConnected) {
          setState(() {
            _isOffline = true;
            _wasPlayingBeforeOffline = _videoService.player.state.playing;
          });
          context.read<VideoPlayerBloc>().add(PauseVideoPlayback());
        } else {
          setState(() {
            _isOffline = false;
          });
          if (_wasPlayingBeforeOffline) {
            context.read<VideoPlayerBloc>().add(ResumeVideoPlayback());
          } else {
            // Reload if it failed initially due to network
            if (_streamingCubit.state is StreamingError) {
              _loadVideo();
            }
          }
        }
      },
      child: BlocProvider.value(
        value: _streamingCubit,
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
                    child: Stack(
                      children: [
                        _buildVideoPlayer(),
                        if (_isOffline)
                          Container(
                            color: Colors.black.withValues(alpha: 0.7),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.wifi_off_rounded,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'No Internet Connection',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Waiting for network...',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                // Expanded Content Area
                if (!widget.isMini && widget.height > 300)
                  Expanded(
                    child: ExpandedPlayerContent(
                      state: widget.state,
                      currentServer: _currentServer ?? 'vidcloud',
                      defaultQuality: _defaultQuality,
                      onServerSelected: _switchServer,
                      onQualitySelected: (url, subUrl, subLang, headers) {
                        _playVideo(
                          url,
                          subtitleUrl: subUrl,
                          subtitleLang: subLang,
                          headers: headers,
                          isQualitySwitch: true,
                        );
                      },
                      onMinimize: () {
                        widget.miniplayerController.animateToHeight(
                          state: PanelState.MIN,
                        );
                        context.read<VideoPlayerBloc>().add(MinimizeVideo());
                      },
                      onDownload: () {
                        final url = _videoService
                            .player
                            .state
                            .playlist
                            .medias
                            .firstOrNull
                            ?.uri;
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onStreamingLoaded(StreamingLoaded state) async {
    debugPrint(
      '📥 VideoPlayerContent: Streaming links loaded. Initializing playback...',
    );

    // Wait for player to be fully initialized before loading video
    if (!_isPlayerInitialized) {
      debugPrint('⏳ VideoPlayerContent: Waiting for player initialization...');
      int attempts = 0;
      while (!_isPlayerInitialized && mounted && attempts < 50) {
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }
      if (!_isPlayerInitialized) {
        debugPrint('❌ VideoPlayerContent: Player initialization timed out');
        return;
      }
    }

    if (!mounted) {
      debugPrint(
        '⚠️ VideoPlayerContent: Widget unmounted during streaming load',
      );
      return;
    }

    // Sync local state with actual server used by Cubit
    if (state.selectedServer != null) {
      _currentServer = state.selectedServer;
    }

    final link = VideoPlayerService.selectLinkByQuality(
      state.links,
      _defaultQuality,
    );

    String? subUrl;
    String? subLang;
    if (state.subtitles != null && state.subtitles!.isNotEmpty) {
      try {
        final englishSub = state.subtitles!.firstWhere(
          (s) => s.lang.toLowerCase().contains('english'),
        );
        subUrl = englishSub.url;
        subLang = englishSub.lang;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error parsing subtitles: $e');
        }
      }
    }

    // Debug logging
    if (kDebugMode) {
      debugPrint('🎬 Playing video:');
      debugPrint('  URL: ${link.url}');
      debugPrint('  Quality: ${link.quality}');
      debugPrint('  isM3U8: ${link.isM3U8}');
      debugPrint('  Headers: ${link.headers}');
      debugPrint('  Subtitle: $subUrl');
    }

    _playVideo(
      link.url,
      subtitleUrl: subUrl,
      subtitleLang: subLang,
      headers: link.headers,
    );
  }

  Widget _buildVideoPlayer() {
    return BlocConsumer<StreamingCubit, StreamingState>(
      buildWhen: (previous, current) {
        // Optimize rebuilds
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is StreamingLoaded && current is StreamingLoaded) {
          // Only rebuild if links or server changed, not just subtitles or internal flags
          return previous.selectedServer != current.selectedServer ||
              previous.links != current.links;
        }
        return true;
      },
      listener: (context, state) async {
        // Error is now handled in the builder, no need for SnackBar
        // if (state is StreamingError && context.mounted) { ... }

        if (state is StreamingLoaded && state.links.isNotEmpty) {
          _onStreamingLoaded(state);
        }
      },
      builder: (context, state) {
        if (state is StreamingLoading ||
            state is StreamingInitial ||
            state is StreamingError) {
          return Stack(
            children: [
              if (widget.state.posterUrl != null)
                AppCachedImage(
                  imageUrl: widget.state.posterUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              Container(color: Colors.black54),
              if (state is StreamingLoading)
                const Center(child: LoadingIndicator()),
              if (state is StreamingError)
                VideoErrorWidget(
                  message: state.message,
                  onRetry: _loadVideo,
                  onClose: () =>
                      context.read<VideoPlayerBloc>().add(CloseVideo()),
                ),
            ],
          );
        }

        // Miniplayer Controls
        if (widget.isMini) {
          return MiniPlayerContent(
            state: widget.state,
            videoService: _videoService,
            miniplayerHeight: widget.miniplayerHeight,
            videoKey: _videoKey,
            miniplayerController: widget.miniplayerController,
          );
        }

        // Full Player with Custom Controls
        return FullPlayerContent(
          state: widget.state,
          videoService: _videoService,
          videoKey: _videoKey,
          miniplayerController: widget.miniplayerController,
          showCountdown: _showCountdown,
          nextEpisodeTitle: _nextEpisodeTitle,
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
