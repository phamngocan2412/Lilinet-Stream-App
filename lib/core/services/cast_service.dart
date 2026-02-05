import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CastService {
  bool _isCasting = false;

  bool get isCasting => _isCasting;

  Future<void> initialize() async {
    // Initialize Cast SDK here
    // For now, this is a placeholder as full Cast SDK requires
    // specific platform configuration (Gradle/Info.plist)
    debugPrint('📺 CastService initialized');
  }

  Future<void> startCasting({
    required String videoUrl,
    required String title,
    String? subtitleUrl,
  }) async {
    debugPrint('🚀 Starting cast for: $title ($videoUrl)');
    _isCasting = true;
    // Implement actual cast logic here
  }

  Future<void> stopCasting() async {
    debugPrint('🛑 Stopping cast');
    _isCasting = false;
  }

  Future<List<String>> getDevices() async {
    // Mock devices for UI testing
    await Future.delayed(const Duration(seconds: 1));
    return ['Living Room TV', 'Bedroom Chromecast', 'Office TV'];
  }

  void dispose() {
    // Cleanup resources
  }
}
