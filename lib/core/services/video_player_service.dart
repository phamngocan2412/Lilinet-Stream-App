import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:simple_pip_mode/simple_pip.dart';

import '../../features/movies/domain/entities/streaming_link.dart';
import '../../features/settings/domain/entities/app_settings.dart';
import 'network_monitor_service.dart';

@lazySingleton
class VideoPlayerService {
  Player? _player;
  VideoController? _controller;
  Player? _tempPlayer;
  VideoController? _tempController;

  bool _isDisposed = false;
  bool _isSwitchingQuality = false;
  String? _lastPlayedUrl;

  // Stream subscriptions
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;
  StreamSubscription<String>? _errorSub;

  // Callbacks
  void Function(Duration position)? onPositionChanged;
  void Function()? onVideoCompleted;
  void Function(String error)? onError;
  void Function(bool isSwitching)? onQualitySwitchStateChanged;
  final SimplePip _pip = SimplePip();

  VideoPlayerService();

  /// Current player instance
  Player get player {
    if (_player == null) {
      throw StateError('VideoPlayerService not initialized');
    }
    return _player!;
  }

  /// Current video controller
  VideoController get controller {
    if (_controller == null) {
      throw StateError('VideoPlayerService not initialized');
    }
    return _controller!;
  }

  /// Whether currently switching quality
  bool get isSwitchingQuality => _isSwitchingQuality;

  /// Whether service is disposed
  bool get isDisposed => _isDisposed;

  /// Initialize player with default configuration
  Future<void> initialize() async {
    if (_player != null) return; // Already initialized

    _player = Player(
      configuration: const PlayerConfiguration(
        bufferSize: 128 * 1024 * 1024, // Increased from 64MB to 128MB
      ),
    );

    _controller = VideoController(
      _player!,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
      ),
    );

    _setupStreamListeners();
  }

  /// Detach all callbacks and cancel listeners to prevent memory leaks
  void detachCallbacks() {
    onPositionChanged = null;
    onVideoCompleted = null;
    onError = null;
    onQualitySwitchStateChanged = null;

    // We don't cancel stream subscriptions here because the service is a singleton
    // and the player might still be running in miniplayer mode.
    // However, if we want to stop listening when no UI is attached, we could.
    // But since the singleton keeps running, we just detach the external callbacks.
  }

  void _setupStreamListeners() {
    _positionSub?.cancel();
    _completeSub?.cancel();
    _errorSub?.cancel();

    _positionSub = _player!.stream.position.listen((position) {
      // if (_isDisposed) return; // Singleton doesn't really dispose in the same way
      onPositionChanged?.call(position);
    });

    _completeSub = _player!.stream.completed.listen((completed) {
      if (completed) {
        onVideoCompleted?.call();
      }
    });

    _errorSub = _player!.stream.error.listen((error) {
      if (kDebugMode) {
        debugPrint('❌ Media Player Error: $error');
      }
      onError?.call(error);
    });
  }

  /// Play video with optional seamless quality switching
  ///
  /// [url] - Video URL to play
  /// [startPosition] - Optional position to seek to on start
  /// [subtitleUrl] - Optional subtitle URL
  /// [subtitleLang] - Optional subtitle language label
  /// [headers] - Optional HTTP headers
  /// [isQualitySwitch] - If true, uses seamless dual-player switching
  Future<void> playVideo({
    required String url,
    Duration? startPosition,
    String? subtitleUrl,
    String? subtitleLang,
    Map<String, String>? headers,
    bool isQualitySwitch = false,
  }) async {
    if (_player == null) {
      throw StateError('VideoPlayerService not initialized');
    }

    // Skip if same URL, unless switching quality or forcing reload
    if (url == _lastPlayedUrl && !isQualitySwitch) {
      if (subtitleUrl != null) {
        _player!.setSubtitleTrack(
          SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
        );
      }
      return;
    }

    _lastPlayedUrl = url;

    if (isQualitySwitch) {
      await _seamlessQualitySwitch(
        url: url,
        subtitleUrl: subtitleUrl,
        subtitleLang: subtitleLang,
        headers: headers,
      );
    } else {
      await _normalPlay(
        url: url,
        startPosition: startPosition,
        subtitleUrl: subtitleUrl,
        subtitleLang: subtitleLang,
        headers: headers,
      );
    }
  }

  /// Normal video playback
  Future<void> _normalPlay({
    required String url,
    Duration? startPosition,
    String? subtitleUrl,
    String? subtitleLang,
    Map<String, String>? headers,
  }) async {
    await _player!.stop();

    Duration startPos = Duration.zero;
    if (startPosition != null && startPosition.inSeconds > 10) {
      startPos = startPosition;
    }

    await _player!.open(Media(url, httpHeaders: headers), play: false);

    if (startPos > Duration.zero) {
      try {
        await _player!.stream.duration
            .firstWhere((duration) => duration > Duration.zero)
            .timeout(const Duration(seconds: 10));
      } catch (_) {}
      await _player!.seek(startPos);
    }

    if (subtitleUrl != null) {
      _player!.setSubtitleTrack(
        SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
      );
    }

    await _player!.play();
  }

  /// Seamless quality switch using dual-player approach
  Future<void> _seamlessQualitySwitch({
    required String url,
    String? subtitleUrl,
    String? subtitleLang,
    Map<String, String>? headers,
  }) async {
    _isSwitchingQuality = true;
    onQualitySwitchStateChanged?.call(true);

    // Create temporary player
    _tempPlayer = Player(
      configuration: const PlayerConfiguration(bufferSize: 32 * 1024 * 1024),
    );
    _tempController = VideoController(
      _tempPlayer!,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
      ),
    );

    await _tempPlayer!.setVolume(0);
    await _tempPlayer!.open(Media(url, httpHeaders: headers), play: false);

    // Wait for stream to initialize
    try {
      await _tempPlayer!.stream.duration
          .firstWhere((duration) => duration > Duration.zero)
          .timeout(const Duration(seconds: 10));
    } catch (_) {}

    // Seek to current position and start playing
    final currentPos = _player!.state.position;
    await _tempPlayer!.seek(currentPos);
    await _tempPlayer!.play();

    // Wait for buffering to complete
    try {
      await Future.any([
        _tempPlayer!.stream.playing.firstWhere((isPlaying) => isPlaying),
        Future.delayed(
          const Duration(seconds: 15),
        ).then((_) => throw TimeoutException('Buffer timeout')),
      ]);
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      await _tempPlayer!.dispose();
      _tempPlayer = null;
      _tempController = null;
      _isSwitchingQuality = false;
      onQualitySwitchStateChanged?.call(false);

      // Resume original player if switch failed
      await _player?.play();

      onError?.call('quality_switch_failed');
      return;
    }

    if (_isDisposed) {
      await _tempPlayer!.dispose();
      _tempPlayer = null;
      _tempController = null;
      return;
    }

    // Swap players
    await _tempPlayer!.setVolume(100);
    final oldPlayer = _player!;

    _player = _tempPlayer;
    _controller = _tempController;
    _tempPlayer = null;
    _tempController = null;
    _isSwitchingQuality = false;

    // Re-setup listeners for new player
    _setupStreamListeners();

    if (subtitleUrl != null) {
      _player!.setSubtitleTrack(
        SubtitleTrack.uri(subtitleUrl, title: subtitleLang),
      );
    }

    onQualitySwitchStateChanged?.call(false);

    // Dispose old player
    await oldPlayer.dispose();
  }

  /// Select streaming link by quality preference
  ///
  /// Returns the best matching link based on [defaultQuality]
  /// Falls back to auto/m3u8 or first available link
  static StreamingLink selectLinkByQuality(
    List<StreamingLink> links,
    VideoQuality defaultQuality,
  ) {
    if (links.isEmpty) {
      throw Exception('No streaming links available');
    }

    String qualityTarget;
    switch (defaultQuality) {
      case VideoQuality.hd1080:
        qualityTarget = '1080p';
        break;
      case VideoQuality.hd720:
        qualityTarget = '720p';
        break;
      case VideoQuality.sd480:
        qualityTarget = '480p';
        break;
      case VideoQuality.sd360:
        qualityTarget = '360p';
        break;
      case VideoQuality.auto:
        qualityTarget = 'auto';
        break;
    }

    try {
      if (qualityTarget == 'auto') {
        return links.firstWhere(
          (l) => l.quality == 'auto' || l.isM3U8,
          orElse: () => links.first,
        );
      }
      return links.firstWhere((l) => l.quality == qualityTarget);
    } catch (_) {
      return links.firstWhere(
        (l) => l.quality == 'auto' || l.isM3U8,
        orElse: () => links.first,
      );
    }
  }

  /// Select streaming link with adaptive quality based on network conditions
  ///
  /// [links] - List of available streaming links
  /// [userQuality] - User's preferred quality setting
  /// [isLowBandwidth] - Whether to prefer lower quality
  /// Returns the best matching link based on network conditions
  static StreamingLink selectAdaptiveQuality(
    List<StreamingLink> links,
    VideoQuality userQuality,
    bool isLowBandwidth,
  ) {
    if (links.isEmpty) {
      throw Exception('No streaming links available');
    }

    // If user has a specific preference, use it (unless low bandwidth)
    if (userQuality != VideoQuality.auto && !isLowBandwidth) {
      return selectLinkByQuality(links, userQuality);
    }

    // Use network monitor to get optimal quality
    final networkMonitor = NetworkMonitorService();
    final optimalQuality = networkMonitor.getOptimalQuality();

    if (isLowBandwidth || optimalQuality != VideoQuality.auto) {
      return selectLinkByQuality(links, optimalQuality);
    }

    // Default to auto if no bandwidth data
    return links.firstWhere(
      (l) => l.quality == 'auto' || l.isM3U8,
      orElse: () => links.first,
    );
  }

  /// Stop current playback
  Future<void> stop() async {
    await _player?.stop();
  }

  /// Pause playback
  Future<void> pause() async {
    await _player?.pause();
  }

  /// Resume playback
  Future<void> play() async {
    await _player?.play();
  }

  /// Toggle play/pause
  Future<void> playOrPause() async {
    await _player?.playOrPause();
  }

  /// Set playback speed
  Future<void> setRate(double rate) async {
    await _player?.setRate(rate);
  }

  /// Enable Picture-in-Picture mode
  Future<void> enablePiP() async {
    try {
      await _pip.enterPipMode();
    } catch (e) {
      debugPrint('Failed to enable PiP: $e');
    }
  }

  /// Reset last played URL (for new video)
  void resetLastUrl() {
    _lastPlayedUrl = null;
  }

  /// Dispose all resources
  Future<void> dispose() async {
    // For singleton, we might want to just stop playback instead of full dispose?
    // But if we truly want to release resources when app closes (or user logs out)
    _isDisposed = true;
    _positionSub?.cancel();
    _completeSub?.cancel();
    _errorSub?.cancel();

    // Clear callbacks
    onPositionChanged = null;
    onVideoCompleted = null;
    onError = null;
    onQualitySwitchStateChanged = null;

    await _player?.dispose();
    await _tempPlayer?.dispose();
    _player = null;
    _controller = null;
    _tempPlayer = null;
    _tempController = null;
  }
}
