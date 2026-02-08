import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

import '../../../../core/services/video_player_service.dart';
import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

class MiniPlayerContent extends StatefulWidget {
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
  State<MiniPlayerContent> createState() => _MiniPlayerContentState();
}

class _MiniPlayerContentState extends State<MiniPlayerContent> {
  DateTime? _lastTapTime;
  static const _minTapInterval = Duration(milliseconds: 300);

  void _handleTap(BuildContext context) {
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) < _minTapInterval) {
      debugPrint('MiniPlayer: Tap ignored - too soon after last tap');
      return;
    }
    _lastTapTime = now;
    debugPrint('MiniPlayer: Maximizing from tap');
    context.read<VideoPlayerBloc>().add(MaximizeVideo());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      behavior: HitTestBehavior.translucent,
      child: Material(
        // Add Material widget for proper elevation and touch handling
        color: const Color(0xFF1A1A1A),
        elevation: 8,
        child: Row(
          children: [
            ClipRect(
              child: SizedBox(
                height: widget.miniplayerHeight - 10,
                width: (widget.miniplayerHeight - 10) * 16 / 9,
                child: Video(
                  key: widget.videoKey,
                  controller: widget.videoService.controller,
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
            StreamBuilder<bool>(
              stream: widget.videoService.player.stream.playing,
              initialData: widget.videoService.player.state.playing,
              builder: (context, snapshot) {
                final playing = snapshot.data ?? false;
                return IconButton(
                  icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                  onPressed: () =>
                      context.read<VideoPlayerBloc>().add(TogglePlayPause()),
                  tooltip: playing
                      ? AppLocalizations.of(context)!.pause
                      : AppLocalizations.of(context)!.play,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<VideoPlayerBloc>().add(CloseVideo());
              },
              tooltip: AppLocalizations.of(context)!.close,
            ),
          ],
        ),
      ),
    );
  }
}
