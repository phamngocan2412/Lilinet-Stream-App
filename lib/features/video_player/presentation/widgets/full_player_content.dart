import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../../core/services/video_player_service.dart';
import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';
import 'custom_video_controls.dart';
import 'next_episode_countdown.dart';
import '../../../movies/domain/entities/streaming_link.dart';

class FullPlayerContent extends StatelessWidget {
  final VideoPlayerState state;
  final VideoPlayerService videoService;
  final GlobalKey videoKey;
  final MiniplayerController miniplayerController;
  final bool showCountdown;
  final String? nextEpisodeTitle;
  final List<String> availableServers;
  final String? currentServer;
  final List<StreamingLink> availableQualities;
  final String? currentQuality;
  final Function(String) onServerSelected;
  final Function(StreamingLink) onQualitySelected;
  final VoidCallback onDownload;
  final VoidCallback onPlayNext;
  final VoidCallback onPlayPrevious;
  final VoidCallback onCancelCountdown;
  final VoidCallback onDismissCountdown;

  const FullPlayerContent({
    super.key,
    required this.state,
    required this.videoService,
    required this.videoKey,
    required this.miniplayerController,
    required this.showCountdown,
    this.nextEpisodeTitle,
    required this.availableServers,
    this.currentServer,
    required this.availableQualities,
    this.currentQuality,
    required this.onServerSelected,
    required this.onQualitySelected,
    required this.onDownload,
    required this.onPlayNext,
    required this.onPlayPrevious,
    required this.onCancelCountdown,
    required this.onDismissCountdown,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: Video(
            key: videoKey,
            controller: videoService.controller,
            controls: (state) {
              final movie = this.state.movie;
              bool hasNext = false;
              bool hasPrev = false;
              if (movie != null && movie.episodes != null) {
                final idx = movie.episodes!.indexWhere(
                  (e) => e.id == this.state.episodeId,
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
                  player: videoService.player,
                  onMinimize: () {
                    miniplayerController.animateToHeight(state: PanelState.MIN);
                    context.read<VideoPlayerBloc>().add(MinimizeVideo());
                  },
                  onNext: onPlayNext,
                  onPrev: onPlayPrevious,
                  onSpeedChanged: (speed) {
                    context.read<VideoPlayerBloc>().add(
                          SetPlaybackSpeed(speed),
                        );
                  },
                  onEnterPiP: () {
                    context.read<VideoPlayerBloc>().add(EnterPiP());
                  },
                  onCast: () {
                    if (this.state.title != null) {
                      context.read<VideoPlayerBloc>().add(
                            StartCast(
                              videoService.player.state.playlist.medias
                                      .firstOrNull?.uri ??
                                  '',
                            ),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Casting feature is a prototype'),
                        ),
                      );
                    }
                  },
                  onDownload: onDownload,
                  availableServers: availableServers,
                  currentServer: currentServer ?? '',
                  availableQualities: availableQualities,
                  currentQuality: currentQuality ?? '',
                  onServerSelected: onServerSelected,
                  onQualitySelected: onQualitySelected,
                  hasNext: hasNext,
                  hasPrev: hasPrev,
                ),
              );
            },
          ),
        ),
        if (showCountdown && nextEpisodeTitle != null)
          NextEpisodeCountdown(
            nextEpisodeTitle: nextEpisodeTitle!,
            onPlayNow: onDismissCountdown,
            onCancel: onCancelCountdown,
          ),
      ],
    );
  }
}
