import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

const kRedColor = Color(0xFFD32F2F);

class CustomVideoControls extends StatelessWidget {
  final VideoState state;
  final Player player;
  final String title;
  final VoidCallback onMinimize;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool hasNext;
  final bool hasPrev;

  const CustomVideoControls({
    super.key,
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
          // Gesture Handler to block Miniplayer drag when using controls
          GestureDetector(
            onVerticalDragUpdate: (details) {}, // Consume vertical drag
            child: MaterialVideoControls(state),
          ),

          // Custom Top Bar (Minimize Button)
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
