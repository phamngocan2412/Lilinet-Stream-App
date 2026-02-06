import 'dart:async';
import 'package:flutter/foundation.dart';

/// A utility class to debounce function calls.
///
/// Useful for preventing rapid-fire events like button taps or search input.
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  /// Runs the [action] after the specified [milliseconds] delay.
  /// If run is called again before the delay expires, the previous call is cancelled.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancels any pending action.
  void dispose() {
    _timer?.cancel();
  }
}
