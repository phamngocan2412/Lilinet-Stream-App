import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../../core/services/video_player_service.dart';
import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

class MiniPlayerContent extends StatelessWidget {
  final VideoPlayerState state;
  final VideoPlayerService videoService;
  final double miniplayerHeight;
  final GlobalKey videoKey;
  final MiniplayerController miniplayerController;

  const MiniPlayerContent({
    super.key,
    required this.state,
    required this.videoService,
    required this.miniplayerHeight,
    required this.videoKey,
    required this.miniplayerController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<VideoPlayerBloc>().add(MaximizeVideo()),
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          ClipRect(
            child: SizedBox(
              height: miniplayerHeight - 10,
              width: (miniplayerHeight - 10) * 16 / 9,
              child: Video(
                key: videoKey,
                controller: videoService.controller,
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
                    state.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state.episodeTitle != null)
                    Text(
                      state.episodeTitle!,
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
              stream: videoService.player.stream.playing,
              initialData: videoService.player.state.playing,
              builder: (context, snapshot) {
                final playing = snapshot.data ?? false;
                return Icon(playing ? Icons.pause : Icons.play_arrow);
              },
            ),
            onPressed: () =>
                context.read<VideoPlayerBloc>().add(TogglePlayPause()),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<VideoPlayerBloc>().add(CloseVideo());
            },
          ),
        ],
      ),
    );
  }
}
