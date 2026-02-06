import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:lilinet_app/features/video_player/presentation/bloc/video_player_state.dart';

@lazySingleton
class VideoSessionRepository {
  static const String boxName = 'video_session';
  static const String key = 'last_session';
  static const Duration cleanupInterval = Duration(minutes: 30);
  static const int maxSessionAgeHours = 24;

  Future<Box> get _box async => await Hive.openBox(boxName);
  Timer? _cleanupTimer;

  Future<void> saveSession({
    required VideoPlayerState state,
    required Duration position,
  }) async {
    final box = await _box;
    await box.put(key, {
      'episodeId': state.episodeId,
      'mediaId': state.mediaId,
      'title': state.title,
      'posterUrl': state.posterUrl,
      'episodeTitle': state.episodeTitle,
      'mediaType': state.mediaType,
      'positionSeconds': position.inSeconds,
      'timestamp': DateTime.now().toIso8601String(),
      // We don't save the full Movie object here as it's too complex.
      // We will reload it using the mediaId/episodeId.
    });
  }

  Future<Map<String, dynamic>?> getLastSession() async {
    final box = await _box;
    final session = box.get(key);

    if (session != null) {
      final timestamp = DateTime.parse(session['timestamp']);
      // Only restore if < 24 hours old
      if (DateTime.now().difference(timestamp).inHours < 24) {
        return Map<String, dynamic>.from(session);
      } else {
        await clearSession();
      }
    }
    return null;
  }

  Future<void> clearSession() async {
    final box = await _box;
    await box.delete(key);
  }

  /// Start periodic cleanup to prevent memory leaks
  void startPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(cleanupInterval, (_) async {
      try {
        await _cleanupOldSessions();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error during periodic cleanup: $e');
        }
      }
    });
  }

  /// Stop periodic cleanup (called when app closes)
  void stopPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }

  /// Cleanup old sessions and other cached data
  Future<void> _cleanupOldSessions() async {
    final box = await _box;
    final session = box.get(key);

    if (session != null) {
      try {
        final timestamp = DateTime.parse(session['timestamp']);
        final age = DateTime.now().difference(timestamp);

        // Clear if older than max age
        if (age.inHours >= maxSessionAgeHours) {
          await clearSession();
          if (kDebugMode) {
            debugPrint(
              '🧹 Cleaned up old video session (age: ${age.inHours}h)',
            );
          }
        }
      } catch (e) {
        // If parsing fails, clear invalid session
        await clearSession();
      }
    }

    // Compact the box to free up space
    await box.compact();
  }

  /// Clear all old data including temporary cache entries
  Future<int> clearExpiredCache() async {
    int deletedCount = 0;

    try {
      // Clear old video sessions
      final box = await _box;
      final session = box.get(key);

      if (session != null) {
        final timestamp = DateTime.parse(session['timestamp']);
        if (DateTime.now().difference(timestamp).inHours >=
            maxSessionAgeHours) {
          await clearSession();
          deletedCount++;
        }
      }

      // Compact database
      await box.compact();

      if (kDebugMode) {
        debugPrint('🧹 Cleaned up $deletedCount expired entries');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error clearing expired cache: $e');
      }
    }

    return deletedCount;
  }
}
