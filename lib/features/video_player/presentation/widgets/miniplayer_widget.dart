// ignore_for_file: deprecated_member_use, unreachable_switch_default

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../../injection_container.dart';
import '../../../../core/services/video_player_service.dart';
import '../bloc/video_player_bloc.dart';
import '../bloc/video_player_event.dart';
import '../bloc/video_player_state.dart';

import 'video_player_content.dart';

// Colors
const kBgColor = Color(0xFF101010);
const kOrangeColor = Color(0xFFC6A664);

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<VideoPlayerBloc>().state;
      if (state.status == VideoPlayerStatus.expanded) {
        _miniplayerController.animateToHeight(state: PanelState.MAX);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
      // Listen to all changes so we can re-expand even if status is Same (but timestamp changed)
      listener: (context, state) {
        if (state.status == VideoPlayerStatus.expanded) {
          _miniplayerController.animateToHeight(state: PanelState.MAX);
        } else if (state.status == VideoPlayerStatus.minimized) {
          _miniplayerController.animateToHeight(state: PanelState.MIN);
        } else if (state.status == VideoPlayerStatus.closed) {
          // Stop playback and reset URL when player is closed
          final service = getIt<VideoPlayerService>();
          service.stop();
          service.resetLastUrl();
        }
      },
      builder: (context, state) {
        if (state.status == VideoPlayerStatus.closed) {
          return const SizedBox.shrink();
        }

        // Use LayoutBuilder to get proper constraints
        return LayoutBuilder(
          builder: (context, constraints) {
            return PopScope(
              canPop: state.status != VideoPlayerStatus.expanded,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;

                // If expanded, minimize instead of popping
                if (state.status == VideoPlayerStatus.expanded) {
                  _miniplayerController.animateToHeight(state: PanelState.MIN);
                  context.read<VideoPlayerBloc>().add(MinimizeVideo());
                }
              },
              child: Miniplayer(
                controller: _miniplayerController,
                minHeight: widget.miniplayerHeight,
                maxHeight: constraints.maxHeight.isFinite
                    ? constraints.maxHeight
                    : MediaQuery.of(context).size.height,
                builder: (height, percentage) {
                  final isMini = percentage < 0.2;

                  return VideoPlayerContent(
                    key: ValueKey(state.episodeId),
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
              ),
            );
          },
        );
      },
    );
  }
}
