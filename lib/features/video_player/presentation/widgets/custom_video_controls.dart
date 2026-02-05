import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

const kRedColor = Color(0xFFD32F2F);

class CustomVideoControls extends StatefulWidget {
  final VideoState state;
  final Player player;
  final VoidCallback onMinimize;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final Function(double) onSpeedChanged;
  final VoidCallback onEnterPiP;
  final VoidCallback onCast;
  final bool hasNext;
  final bool hasPrev;

  const CustomVideoControls({
    super.key,
    required this.state,
    required this.player,
    required this.onMinimize,
    required this.onNext,
    required this.onPrev,
    required this.onSpeedChanged,
    required this.onEnterPiP,
    required this.onCast,
    required this.hasNext,
    required this.hasPrev,
  });

  @override
  State<CustomVideoControls> createState() => _CustomVideoControlsState();
}

class _CustomVideoControlsState extends State<CustomVideoControls> {
  bool _controlsVisible = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    if (_controlsVisible) {
      _startHideTimer();
    }
  }

  void _onUserInteraction() {
    if (!_controlsVisible) {
      setState(() {
        _controlsVisible = true;
      });
    }
    _startHideTimer();
  }

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
      child: GestureDetector(
        onTap: _toggleControls,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Base MaterialVideoControls (always present for seek bar)
            GestureDetector(
              onVerticalDragUpdate: (details) {}, // Consume vertical drag
              onTap: _toggleControls,
              child: MaterialVideoControls(widget.state),
            ),

            // Custom overlay controls (conditionally visible)
            if (_controlsVisible) ...[
              // Top Bar (Minimize Button)
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
                          onPressed: () {
                            _onUserInteraction();
                            widget.onMinimize();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Speed Control & PiP Buttons (Top Right)
              Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cast, color: Colors.white),
                          onPressed: () {
                            _onUserInteraction();
                            widget.onCast();
                          },
                          tooltip: 'Cast to TV',
                        ),
                        IconButton(
                          icon: const Icon(Icons.picture_in_picture_alt, color: Colors.white),
                          onPressed: () {
                            _onUserInteraction();
                            widget.onEnterPiP();
                          },
                          tooltip: 'Picture in Picture',
                        ),
                        IconButton(
                          icon: const Icon(Icons.speed, color: Colors.white),
                          onPressed: () {
                            _onUserInteraction();
                            _showSpeedMenu(context);
                          },
                          tooltip: 'Playback Speed',
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
                    if (widget.hasPrev)
                      IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          _onUserInteraction();
                          widget.onPrev();
                        },
                      )
                    else
                      const SizedBox(width: 40), // Placeholder

                    const SizedBox(width: 80), // Space for Play/Pause button

                    if (widget.hasNext)
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          _onUserInteraction();
                          widget.onNext();
                        },
                      )
                    else
                      const SizedBox(width: 40), // Placeholder
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSpeedMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // Show above video player when in fullscreen
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Playback Speed',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ...[0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
              return ListTile(
                title: Text(
                  '${speed}x',
                  style: TextStyle(
                    color: widget.player.state.rate == speed
                        ? kRedColor
                        : Colors.white,
                  ),
                ),
                trailing: widget.player.state.rate == speed
                    ? const Icon(Icons.check, color: kRedColor)
                    : null,
                onTap: () {
                  widget.onSpeedChanged(speed);
                  Navigator.pop(context);
                },
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
