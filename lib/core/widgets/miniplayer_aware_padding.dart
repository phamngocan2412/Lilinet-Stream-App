import 'package:flutter/material.dart';
import '../services/miniplayer_height_notifier.dart';
import '../../injection_container.dart';

/// A wrapper that adds bottom padding to its child to prevent
/// content from being obscured by the miniplayer.
///
/// Usage:
/// ```dart
/// MiniplayerAwarePadding(
///   child: ListView(...),
/// )
/// ```
class MiniplayerAwarePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? additionalPadding;

  const MiniplayerAwarePadding({
    super.key,
    required this.child,
    this.additionalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: getIt<MiniplayerHeightNotifier>(),
      builder: (context, _) {
        final miniplayerHeight = getIt<MiniplayerHeightNotifier>().height;

        EdgeInsets bottomPadding = EdgeInsets.only(bottom: miniplayerHeight);

        if (additionalPadding != null) {
          bottomPadding = bottomPadding.add(additionalPadding!) as EdgeInsets;
        }

        return Padding(
          padding: bottomPadding,
          child: child,
        );
      },
    );
  }
}

/// Extension to make it easier to add miniplayer-aware padding to SliverList
extension SliverMiniplayerPadding on Widget {
  Widget withMiniplayerPadding({EdgeInsetsGeometry? additionalPadding}) {
    return MiniplayerAwarePadding(
      additionalPadding: additionalPadding,
      child: this,
    );
  }
}
