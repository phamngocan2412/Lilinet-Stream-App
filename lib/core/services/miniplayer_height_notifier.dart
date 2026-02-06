import 'package:flutter/foundation.dart';

/// Service to notify all screens about the current miniplayer height
/// so they can add bottom padding to avoid content being obscured.
class MiniplayerHeightNotifier extends ChangeNotifier {
  double _height = 0;

  double get height => _height;

  void updateHeight(double newHeight) {
    if (_height != newHeight) {
      _height = newHeight;
      notifyListeners();
    }
  }

  void reset() {
    updateHeight(0);
  }
}
