import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../movies/domain/entities/streaming_link.dart';

class CustomVideoControls extends StatefulWidget {
  final VideoState state;
  final Player player;
  final VoidCallback onMinimize;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final Function(double) onSpeedChanged;
  final VoidCallback onEnterPiP;
  final VoidCallback onCast;
  final VoidCallback onDownload;
  final List<String> availableServers;
  final String currentServer;
  final List<StreamingLink> availableQualities;
  final String currentQuality;
  final Function(String) onServerSelected;
  final Function(StreamingLink) onQualitySelected;
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
    required this.onDownload,
    required this.availableServers,
    required this.currentServer,
    required this.availableQualities,
    required this.currentQuality,
    required this.onServerSelected,
    required this.onQualitySelected,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final errorColor = colorScheme.error;

    return MaterialDesktopVideoControlsTheme(
      normal: MaterialDesktopVideoControlsThemeData(
        seekBarThumbColor: errorColor,
        seekBarPositionColor: errorColor,
        toggleFullscreenOnDoublePress: true,
      ),
      fullscreen: MaterialDesktopVideoControlsThemeData(
        seekBarThumbColor: errorColor,
        seekBarPositionColor: errorColor,
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
                          tooltip: AppLocalizations.of(context)!.minimize,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cast, color: Colors.white),
                          onPressed: () {
                            _onUserInteraction();
                            widget.onCast();
                          },
                          tooltip: AppLocalizations.of(context)!.cast,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.picture_in_picture_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _onUserInteraction();
                            widget.onEnterPiP();
                          },
                          tooltip: AppLocalizations.of(context)!.pip,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _onUserInteraction();
                            _showMoreMenu(context);
                          },
                          tooltip: AppLocalizations.of(context)!.more,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Custom Center Controls (Prev/Play-Pause/Next)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous button
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
                        tooltip: AppLocalizations.of(context)!.previous,
                      )
                    else
                      const SizedBox(
                        width: 64,
                      ), // Placeholder to keep alignment

                    const SizedBox(width: 24),

                    // Play/Pause button with StreamBuilder for sync
                    StreamBuilder<bool>(
                      stream: widget.player.stream.playing,
                      initialData: widget.player.state.playing,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data ?? false;
                        return IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 72,
                          ),
                          onPressed: () {
                            _onUserInteraction();
                            widget.player.playOrPause();
                          },
                          tooltip: isPlaying
                              ? AppLocalizations.of(context)!.pause
                              : AppLocalizations.of(context)!.play,
                        );
                      },
                    ),

                    const SizedBox(width: 24),

                    // Next button
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
                        tooltip: AppLocalizations.of(context)!.next,
                      )
                    else
                      const SizedBox(
                        width: 64,
                      ), // Placeholder to keep alignment
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMoreMenu(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              // Download
              ListTile(
                leading: const Icon(Icons.download_rounded),
                title: Text(l10n.download),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDownload();
                },
              ),
              const Divider(),
              // Servers
              if (widget.availableServers.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.dns_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        l10n.server,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.availableServers.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final server = widget.availableServers[index];
                      final isSelected = widget.currentServer == server;
                      return ChoiceChip(
                        label: Text(server.toUpperCase()),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            widget.onServerSelected(server);
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Quality
              if (widget.availableQualities.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.high_quality_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        l10n.quality,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.availableQualities.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final link = widget.availableQualities[index];
                      final isSelected = widget.currentQuality == link.quality;
                      return ChoiceChip(
                        label: Text(link.quality.toUpperCase()),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            widget.onQualitySelected(link);
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Speed
              ListTile(
                leading: const Icon(Icons.speed),
                title: Text(l10n.speed),
                trailing: Text('${widget.player.state.rate}x'),
                onTap: () {
                  Navigator.pop(context);
                  _showSpeedMenu(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showSpeedMenu(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final errorColor = colorScheme.error;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // Show above video player when in fullscreen
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Playback Speed',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ...[0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
              final isSelected = widget.player.state.rate == speed;
              return ListTile(
                title: Text(
                  '${speed}x',
                  style: TextStyle(
                    color: isSelected ? errorColor : colorScheme.onSurface,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: errorColor)
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
