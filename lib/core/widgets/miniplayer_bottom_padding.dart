import 'package:flutter/material.dart';

import '../../injection_container.dart';
import '../services/miniplayer_height_notifier.dart';

/// A widget that adds bottom padding equal to the current miniplayer height.
///
/// Use this at the bottom of scrollable views (ListView, CustomScrollView, etc.)
/// to prevent content from being obscured by the minimized video player.
class MiniplayerBottomPadding extends StatelessWidget {
  const MiniplayerBottomPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: getIt<MiniplayerHeightNotifier>(),
      builder: (context, _) {
        final height = getIt<MiniplayerHeightNotifier>().height;
        return SizedBox(height: height);
      },
    );
  }
}
