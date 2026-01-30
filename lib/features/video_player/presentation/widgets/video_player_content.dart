// ignore_for_file: deprecated_member_use, unreachable_switch_default

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
import '../../../settings/domain/entities/app_settings.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';
import '../../../movies/domain/entities/streaming_link.dart';

import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

import 'custom_video_controls.dart';
import 'expanded_player_content.dart';

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
  StreamSubscription<String>? _errorSub;
  bool _autoPlayEnabled = false;

  // Streaming Cubit instance managed here to reset on new video
  late StreamingCubit _streamingCubit;
  String? _movieProvider;
  String? _animeProvider;
  VideoQuality _defaultQuality = VideoQuality.auto;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WakelockPlus.enable();
    _initPlayer();
    _streamingCubit = getIt<StreamingCubit>();
    _loadSettingsAndVideo();

    if (widget.state.status == VideoPlayerStatus.expanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.miniplayerController.animateToHeight(state: PanelState.MAX);
      });
    }
  }

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
          });
          _loadVideo();
        }
      },
    );
  }

  void _loadVideo() {
    _lastPlayedUrl = null;

    // Use movie's stored provider if it exists, otherwise fall back to genres check
    final provider =
        widget.state.movie?.provider ?? _determineProviderByGenres();

    _streamingCubit.loadLinks(
      episodeId: widget.state.episodeId!,
      mediaId: widget.state.mediaId!,
      provider: provider,
    );
  }

  String _determineProviderByGenres() {
    final genres = widget.state.movie?.genres ?? [];
    print('🧐 Determining provider for movie: ${widget.state.movie?.title}');
    print('  Genres: $genres');

    final isAnime = genres.any(
      (g) =>
          g.toLowerCase().contains('anime') ||
          g.toLowerCase().contains('animation'),
    );

    print('  isAnime: $isAnime');
    print('  Movie Provider User Pref: $_movieProvider');
    print('  Anime Provider User Pref: $_animeProvider');

    final selected = isAnime
        ? (_animeProvider ?? 'animepahe')
        : (_movieProvider ?? 'flixhq');

    print('  Selected Provider: $selected');
    return selected;
  }

  void _switchServer(String server) {
    setState(() {
      _currentServer = server;
    });

    final provider =
        widget.state.movie?.provider ?? _determineProviderByGenres();

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
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      // Optional: Auto-resume or keep paused based on preference
      // player.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _positionSub?.cancel();
    _completeSub?.cancel();
    _errorSub?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    player.dispose();
    _tempPlayer?.dispose();
    _streamingCubit.close();
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

    // Listen for errors
    _errorSub = player.stream.error.listen((error) {
      if (!_isDisposed) {
        print('❌ Media Player Error: $error');
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
    Map<String, String>? headers,
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

      final tempPlayer = Player(
        configuration: const PlayerConfiguration(bufferSize: 32 * 1024 * 1024),
      );
      final tempController = VideoController(
        tempPlayer,
        configuration: const VideoControllerConfiguration(
          enableHardwareAcceleration: true,
        ),
      );

      await tempPlayer.setVolume(0);
      await tempPlayer.open(Media(url, httpHeaders: headers), play: false);

      try {
        await tempPlayer.stream.duration
            .firstWhere((duration) => duration > Duration.zero)
            .timeout(const Duration(seconds: 10));
      } catch (_) {}

      final currentPos = player.state.position;
      await tempPlayer.seek(currentPos);
      await tempPlayer.play();

      try {
        await Future.any([
          tempPlayer.stream.playing.firstWhere((isPlaying) => isPlaying),
          Future.delayed(
            const Duration(seconds: 15),
          ).then((_) => throw TimeoutException('Buffer timeout')),
        ]);
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        await tempPlayer.dispose();
        if (mounted) setState(() => isSwitchingQuality = false);
        return;
      }

      if (_isDisposed) {
        await tempPlayer.dispose();
        return;
      }

      await tempPlayer.setVolume(100);
      final oldPlayer = player;

      setState(() {
        player = tempPlayer;
        controller = tempController;
        isSwitchingQuality = false;
      });

      _positionSub?.cancel();
      _completeSub?.cancel();
      _errorSub?.cancel();

      _positionSub = player.stream.position.listen((position) {
        if (_isDisposed) return;
        _saveProgress(position);
      });

      _completeSub = player.stream.completed.listen((completed) {
        if (completed && !_isDisposed) {
          _onVideoCompleted();
        }
      });

      _errorSub = player.stream.error.listen((error) {
        if (!_isDisposed) {
          print('❌ Media Player Error: $error');
        }
      });

      if (subtitleUrl != null) {
        player.setSubtitleTrack(
          SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
        );
      }

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

    await player.open(Media(url, httpHeaders: headers), play: false);

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

              // Expanded Content Area (Refactored)
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
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  StreamingLink _selectLinkByQuality(
    List<StreamingLink> links,
    VideoQuality defaultQuality,
  ) {
    if (links.isEmpty) throw Exception('No streaming links');

    String qualityTarget;
    switch (defaultQuality) {
      case VideoQuality.hd1080:
        qualityTarget = '1080p';
        break;
      case VideoQuality.hd720:
        qualityTarget = '720p';
        break;
      case VideoQuality.sd480:
        qualityTarget = '480p';
        break;
      case VideoQuality.sd360:
        qualityTarget = '360p';
        break;
      case VideoQuality.auto:
      default:
        qualityTarget = 'auto';
        break;
    }

    try {
      if (qualityTarget == 'auto') {
        return links.firstWhere(
          (l) => l.quality == 'auto' || l.isM3U8,
          orElse: () => links.first,
        );
      }
      return links.firstWhere((l) => l.quality == qualityTarget);
    } catch (_) {
      return links.firstWhere(
        (l) => l.quality == 'auto' || l.isM3U8,
        orElse: () => links.first,
      );
    }
  }

  Widget _buildVideoPlayer() {
    return BlocConsumer<StreamingCubit, StreamingState>(
      listener: (context, state) async {
        if (state is StreamingLoading) {
          await player.stop();
        }
        if (state is StreamingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  _loadVideo();
                },
              ),
            ),
          );
        }

        if (state is StreamingLoaded && state.links.isNotEmpty) {
          // Sync local state with actual server used by Cubit
          if (state.selectedServer != null) {
            _currentServer = state.selectedServer;
          }

          final link = _selectLinkByQuality(state.links, _defaultQuality);

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

          // Debug logging
          print('🎬 Playing video:');
          print('  URL: ${link.url}');
          print('  Quality: ${link.quality}');
          print('  isM3U8: ${link.isM3U8}');
          print('  Headers: ${link.headers}');
          print('  Subtitle: $subUrl');

          _playVideo(
            link.url,
            subtitleUrl: subUrl,
            subtitleLang: subLang,
            headers: link.headers,
          );
        }
      },
      builder: (context, state) {
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

        // Miniplayer Controls
        if (widget.isMini) {
          return Row(
            children: [
              ClipRect(
                child: SizedBox(
                  height: widget.miniplayerHeight - 10,
                  width: (widget.miniplayerHeight - 10) * 16 / 9,
                  child: Video(
                    controller: controller,
                    controls: NoVideoControls,
                  ),
                ),
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
              IconButton(
                icon: StreamBuilder<bool>(
                  stream: player.stream.playing,
                  initialData: player.state.playing,
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

        // Full Player with Custom Controls
        // Wrap in ClipRect to prevent surface overflow issues
        return ClipRect(
          child: Video(
            controller: controller,
            controls: (state) {
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
                onTap: () {},
                child: CustomVideoControls(
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
          ),
        );
      },
    );
  }
}
