// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../history/domain/entities/watch_progress.dart';
import '../../../history/presentation/bloc/history_bloc.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';

import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

// Colors
const kBgColor = Color(0xFF101010);
const kOrangeColor = Color(0xFFC6A664);
const kGreenVIP = Color(0xFF43A047);
const kBlueVIP = Color(0xFF1E88E5);
const kRedColor = Color(0xFFD32F2F);

class MiniplayerWidget extends StatefulWidget {
  final double miniplayerHeight;
  final double maxWidth;

  const MiniplayerWidget({
    super.key,
    required this.miniplayerHeight,
    required this.maxWidth,
  });

  @override
  State<MiniplayerWidget> createState() => _MiniplayerWidgetState();
}

class _MiniplayerWidgetState extends State<MiniplayerWidget> {
  final MiniplayerController _miniplayerController = MiniplayerController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == VideoPlayerStatus.expanded) {
          _miniplayerController.animateToHeight(state: PanelState.MAX);
        } else if (state.status == VideoPlayerStatus.minimized) {
          _miniplayerController.animateToHeight(state: PanelState.MIN);
        }
      },
      builder: (context, state) {
        if (state.status == VideoPlayerStatus.closed) {
          return const SizedBox.shrink();
        }

        return Miniplayer(
          controller: _miniplayerController,
          minHeight: widget.miniplayerHeight,
          maxHeight: MediaQuery.of(context).size.height,
          builder: (height, percentage) {
            final isMini = percentage < 0.2;
            // Determine if we should show full controls or mini controls
            // percentage 0.0 = min height, 1.0 = max height

            return _VideoPlayerContent(
              key: ValueKey(
                state.episodeId,
              ), // Rebuild if episode changes? No, handle inside
              state: state,
              isMini: isMini,
              percentage: percentage,
              miniplayerController: _miniplayerController,
              height: height,
              miniplayerHeight: widget.miniplayerHeight,
            );
          },
          onDismissed: () {
            context.read<VideoPlayerBloc>().add(CloseVideo());
          },
        );
      },
    );
  }
}

class _VideoPlayerContent extends StatefulWidget {
  final VideoPlayerState state;
  final bool isMini;
  final double percentage;
  final MiniplayerController miniplayerController;
  final double height;
  final double miniplayerHeight;

  const _VideoPlayerContent({
    super.key,
    required this.state,
    required this.isMini,
    required this.percentage,
    required this.miniplayerController,
    required this.height,
    required this.miniplayerHeight,
  });

  @override
  State<_VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<_VideoPlayerContent> {
  late Player player;
  late VideoController controller;

  // Dual-player support for seamless switching
  Player? _tempPlayer;
  VideoController? tempController;
  bool isSwitchingQuality = false;

  bool _isDisposed = false;
  String? _currentServer = 'vidcloud';
  String? _lastPlayedUrl;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;
  bool _autoPlayEnabled = false;

  // Streaming Cubit instance managed here to reset on new video
  late StreamingCubit _streamingCubit;
  String? _movieProvider;
  String? _animeProvider;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initPlayer(); // Initialize player first
    _streamingCubit = getIt<StreamingCubit>();
    _loadSettingsAndVideo(); // Consolidated loading

    // Check initial state for expansion
    if (widget.state.status == VideoPlayerStatus.expanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.miniplayerController.animateToHeight(state: PanelState.MAX);
      });
    }
  }

  // Load Settings AND THEN Video
  Future<void> _loadSettingsAndVideo() async {
    final result = await getIt<SettingsRepository>().getSettings();
    result.fold(
      (l) {
        // If fails, use defaults
        _movieProvider = 'goku';
        _animeProvider = 'hianime';
        _loadVideo();
      },
      (settings) {
        if (mounted) {
          setState(() {
            _autoPlayEnabled = settings.autoPlay;
            _movieProvider = settings.movieProvider;
            _animeProvider = settings.animeProvider;
          });
          _loadVideo();
        }
      },
    );
  }

  void _loadVideo() {
    // Reset state for new video
    _lastPlayedUrl = null;

    final isAnime =
        widget.state.movie?.genres.any(
          (g) => g.toLowerCase().contains('anime'),
        ) ??
        false;

    final provider = isAnime
        ? (_animeProvider ?? 'animekai')
        : (_movieProvider ?? 'himovies');

    _streamingCubit.loadLinks(
      episodeId: widget.state.episodeId!,
      mediaId: widget.state.mediaId!,
      provider: provider,
    );
  }

  // Update _switchServer to use the provider too
  void _switchServer(String server) {
    setState(() {
      _currentServer = server;
    });

    final isAnime =
        widget.state.movie?.genres.any(
          (g) => g.toLowerCase().contains('anime'),
        ) ??
        false;

    final provider = isAnime
        ? (_animeProvider ?? 'animekai')
        : (_movieProvider ?? 'himovies');

    _streamingCubit.loadLinks(
      episodeId: widget.state.episodeId!,
      mediaId: widget.state.mediaId!,
      server: server,
      provider: provider,
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _positionSub?.cancel();
    _completeSub?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    player.dispose();
    _tempPlayer?.dispose(); // Dispose temp player if exists

    _streamingCubit
        .close(); // Close the cubit since we created it via GetIt factory
    super.dispose();
  }

  Future<void> _initPlayer() async {
    player = Player(
      configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024),
    );

    controller = VideoController(
      player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
      ),
    );

    _positionSub = player.stream.position.listen((position) {
      if (_isDisposed) return;
      _saveProgress(position);
    });

    _completeSub = player.stream.completed.listen((completed) {
      if (completed && !_isDisposed) {
        _onVideoCompleted();
      }
    });
  }

  void _onVideoCompleted() {
    if (_autoPlayEnabled && widget.state.mediaType == 'TV Series') {
      _playNextEpisode();
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

  void _saveProgress(Duration position) {
    final duration = player.state.duration;
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
    bool isQualitySwitch = false,
  }) async {
    if (url == _lastPlayedUrl) {
      if (subtitleUrl != null) {
        player.setSubtitleTrack(
          SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
        );
      }
      return;
    }

    _lastPlayedUrl = url;

    // --- SEAMLESS QUALITY SWITCHING LOGIC ---
    if (isQualitySwitch) {
      if (mounted) setState(() => isSwitchingQuality = true);

      // 1. Initialize Temp Player (Background)
      final tempPlayer = Player(
        configuration: const PlayerConfiguration(bufferSize: 32 * 1024 * 1024),
      );
      final tempController = VideoController(
        tempPlayer,
        configuration: const VideoControllerConfiguration(
          enableHardwareAcceleration: true,
        ),
      );

      // 2. Prepare without playing/sound
      await tempPlayer.setVolume(0);
      await tempPlayer.open(Media(url), play: false);

      // 3. Sync position
      // Wait for duration to be available before seeking (Critical for HLS)
      try {
        await tempPlayer.stream.duration
            .firstWhere((duration) => duration > Duration.zero)
            .timeout(const Duration(seconds: 10));
      } catch (_) {
        // If timeout, we try seeking anyway or just let it play
      }

      final currentPos = player.state.position;
      await tempPlayer.seek(currentPos);

      // 4. Start buffering/playing in background
      await tempPlayer.play();

      // 5. Wait for it to be ready (playing & not buffering)
      // Safety timeout: if it takes too long (>15s), abort switch to avoid stuck UI
      try {
        await Future.any([
          tempPlayer.stream.playing.firstWhere((isPlaying) => isPlaying),
          Future.delayed(
            const Duration(seconds: 15),
          ).then((_) => throw TimeoutException('Buffer timeout')),
        ]);

        // Wait a tiny bit more for frame render
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        // Fallback: If failed, just dispose temp and keep playing old quality
        await tempPlayer.dispose();
        if (mounted) setState(() => isSwitchingQuality = false);
        return;
      }

      // 6. SWAP PLAYERS
      if (_isDisposed) {
        await tempPlayer.dispose();
        return;
      }

      // Restore volume
      await tempPlayer.setVolume(100);

      // Update UI references
      final oldPlayer = player;

      setState(() {
        player = tempPlayer;
        controller = tempController;
        isSwitchingQuality = false;
      });

      // Re-attach listeners to new player
      _positionSub?.cancel();
      _completeSub?.cancel();

      _positionSub = player.stream.position.listen((position) {
        if (_isDisposed) return;
        _saveProgress(position);
      });

      _completeSub = player.stream.completed.listen((completed) {
        if (completed && !_isDisposed) {
          _onVideoCompleted();
        }
      });

      // Set Subtitles if needed
      if (subtitleUrl != null) {
        player.setSubtitleTrack(
          SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
        );
      }

      // 7. Cleanup old player
      await oldPlayer.dispose();
      return;
    }
    // --- END SEAMLESS LOGIC ---

    await player.stop();

    Duration startPos = Duration.zero;
    if (widget.state.startPosition != null &&
        widget.state.startPosition!.inSeconds > 10) {
      startPos = widget.state.startPosition!;
    }

    // Note: We skip the "Resume Dialog" for miniplayer to keep it seamless.
    // Or we could implement it, but showing dialog in Miniplayer might be weird if minimized.
    // For now, auto-resume if startPos passed.

    await player.open(Media(url), play: false);

    // Seek
    if (startPos > Duration.zero) {
      try {
        await player.stream.duration
            .firstWhere((duration) => duration > Duration.zero)
            .timeout(const Duration(seconds: 10));
      } catch (_) {}
      await player.seek(startPos);
    }

    if (subtitleUrl != null) {
      player.setSubtitleTrack(
        SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
      );
    }

    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    // Provide the LOCAL streaming cubit to children
    return BlocProvider.value(
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
                  child: _buildVideoPlayer(),
                ),

              // Content Area
              if (!widget.isMini)
                Expanded(
                  child: 250 >= widget.height
                      ? const SizedBox.shrink()
                      : _buildExpandedContent(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return BlocConsumer<StreamingCubit, StreamingState>(
      listener: (context, state) {
        if (state is StreamingLoaded && state.links.isNotEmpty) {
          final link = state.links.firstWhere(
            (l) => l.quality == 'auto' || l.isM3U8,
            orElse: () => state.links.first,
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
            } catch (_) {}
          }
          _playVideo(link.url, subtitleUrl: subUrl, subtitleLang: subLang);
        }
      },
      builder: (context, state) {
        // Show Poster if loading or error or idle
        if (state is StreamingLoading || state is StreamingInitial) {
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
            ],
          );
        }

        // Miniplayer Controls vs Full Controls
        if (widget.isMini) {
          return Row(
            children: [
              // Tiny Video Preview - Constrained Size
              SizedBox(
                height: widget.miniplayerHeight - 10,
                width: (widget.miniplayerHeight - 10) * 16 / 9,
                child: Video(controller: controller, controls: NoVideoControls),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.state.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.state.episodeTitle != null)
                        Text(
                          widget.state.episodeTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Mini Controls
              IconButton(
                icon: StreamBuilder<bool>(
                  stream: player.stream.playing,
                  initialData: player.state.playing, // Add initial data
                  builder: (context, snapshot) {
                    final playing = snapshot.data ?? false;
                    return Icon(playing ? Icons.pause : Icons.play_arrow);
                  },
                ),
                onPressed: () => player.playOrPause(),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.read<VideoPlayerBloc>().add(CloseVideo());
                },
              ),
            ],
          );
        }

        // Full Player
        return Video(
          controller: controller,
          controls: (state) {
            // Determine if Next/Prev is available
            final movie = widget.state.movie;
            bool hasNext = false;
            bool hasPrev = false;
            if (movie != null && movie.episodes != null) {
              final idx = movie.episodes!.indexWhere(
                (e) => e.id == widget.state.episodeId,
              );
              if (idx != -1) {
                if (idx < movie.episodes!.length - 1) hasNext = true;
                if (idx > 0) hasPrev = true;
              }
            }

            return GestureDetector(
              onTap: () {
                // Prevent Miniplayer from handling tap
              },
              child: _CustomVideoControls(
                state: state,
                player: player,
                title: widget.state.title ?? '',
                onMinimize: () {
                  widget.miniplayerController.animateToHeight(
                    state: PanelState.MIN,
                  );
                },
                onNext: _playNextEpisode,
                onPrev: _playPreviousEpisode,
                hasNext: hasNext,
                hasPrev: hasPrev,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildExpandedContent() {
    return BlocBuilder<StreamingCubit, StreamingState>(
      builder: (context, streamingState) {
        String? description;
        final movie = widget.state.movie;
        if (movie != null) {
          description = movie.description;
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              '${widget.state.title}${widget.state.episodeTitle != null ? " - ${widget.state.episodeTitle}" : ""}',
              style: const TextStyle(
                color: kOrangeColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Server Selector
            Row(
              children: [
                const Text('Server', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 8),
                _buildVipButton(
                  'VidCloud',
                  kGreenVIP,
                  _currentServer == 'vidcloud',
                  () => _switchServer('vidcloud'),
                ),
                const SizedBox(width: 8),
                _buildVipButton(
                  'UpCloud',
                  kBlueVIP,
                  _currentServer == 'upcloud',
                  () => _switchServer('upcloud'),
                ),
                const SizedBox(width: 8),
                _buildVipButton(
                  'VidStream',
                  kOrangeColor,
                  _currentServer == 'vidstream',
                  () => _switchServer('vidstream'),
                ),
                const SizedBox(width: 8),
                _buildVipButton(
                  'MixDrop',
                  const Color(0xFF8E24AA),
                  _currentServer == 'mixdrop',
                  () => _switchServer('mixdrop'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quality Selector
            if (streamingState is StreamingLoaded &&
                streamingState.links.isNotEmpty) ...[
              Builder(
                builder: (context) {
                  final uniqueLinks = <String, String>{};
                  for (var link in streamingState.links) {
                    if (!uniqueLinks.containsKey(link.quality)) {
                      uniqueLinks[link.quality] = link.url;
                    }
                  }
                  if (uniqueLinks.length <= 1) return const SizedBox.shrink();

                  return Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const Center(
                          child: Text(
                            "Quality: ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...uniqueLinks.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kOrangeColor),
                                foregroundColor: kOrangeColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              onPressed: () {
                                String? subUrl;
                                String? subLang;
                                if (streamingState.subtitles != null &&
                                    streamingState.subtitles!.isNotEmpty) {
                                  try {
                                    final englishSub = streamingState.subtitles!
                                        .firstWhere(
                                          (s) => s.lang.toLowerCase().contains(
                                            'english',
                                          ),
                                        );
                                    subUrl = englishSub.url;
                                    subLang = englishSub.lang;
                                  } catch (_) {}
                                }
                                _playVideo(
                                  entry.value,
                                  subtitleUrl: subUrl,
                                  subtitleLang: subLang,
                                  isQualitySwitch:
                                      true, // Enable seamless switch
                                );
                              },
                              child: Text(entry.key.toUpperCase()),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ],

            if (description != null)
              Text(description, style: const TextStyle(color: Colors.grey)),
          ],
        );
      },
    );
  }

  Widget _buildVipButton(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? Border.all(color: Colors.white, width: 1)
              : Border.all(color: Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// Add this new widget class at the end of the file or in a separate file
class _CustomVideoControls extends StatelessWidget {
  final VideoState state;
  final Player player;
  final String title;
  final VoidCallback onMinimize;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool hasNext;
  final bool hasPrev;

  const _CustomVideoControls({
    required this.state,
    required this.player,
    required this.title,
    required this.onMinimize,
    required this.onNext,
    required this.onPrev,
    required this.hasNext,
    required this.hasPrev,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialDesktopVideoControlsTheme(
      normal: const MaterialDesktopVideoControlsThemeData(
        seekBarThumbColor: kRedColor,
        seekBarPositionColor: kRedColor,
        toggleFullscreenOnDoublePress: true,
      ),
      fullscreen: const MaterialDesktopVideoControlsThemeData(
        seekBarThumbColor: kRedColor,
        seekBarPositionColor: kRedColor,
      ),
      child: Stack(
        children: [
          // Use MaterialVideoControls but wrap the bottom bar to block gestures?
          // media_kit's MaterialVideoControls is a complex widget.
          // We can't easily modify its internal structure without reimplementing it.
          // However, we can put a transparent Listener over the Seek Bar area if we knew where it is.
          // Better approach: Re-implement a simple overlay using AdaptiveVideoControls logic or similar.
          // But that's a lot of code.

          // Workaround for Gesture Conflict:
          // The Miniplayer minimizes when dragging down.
          // If we wrap the MaterialVideoControls in a GestureDetector that handles vertical drag
          // and does nothing, it might stop the propagation.
          GestureDetector(
            onVerticalDragUpdate: (details) {}, // Consume vertical drag
            child: MaterialVideoControls(state),
          ),

          // Custom Top Bar (Minimize Button)
          // We wrap in SafeArea to avoid notch/status bar issues
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: onMinimize,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Custom Center Controls (Next/Prev)
          // We overlay these on top of MaterialVideoControls.
          // Note: MaterialVideoControls puts Play/Pause in the center.
          // We can put Next/Prev to the left and right of the center.
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (hasPrev)
                  IconButton(
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: onPrev,
                  )
                else
                  const SizedBox(width: 40), // Placeholder

                const SizedBox(width: 80), // Space for Play/Pause button

                if (hasNext)
                  IconButton(
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: onNext,
                  )
                else
                  const SizedBox(width: 40), // Placeholder
              ],
            ),
          ),
        ],
      ),
    );
  }
}
