import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import '../../features/settings/domain/entities/app_settings.dart';

/// Service to monitor network status and bandwidth
class NetworkMonitorService {
  static const int _sampleInterval = 2000; // 2 seconds
  static const int _samplesToKeep = 10; // Keep last 10 samples

  // List of speed samples (bytes/second)
  final List<double> _speedSamples = [];

  // Current network status
  bool _isConnected = true;
  ConnectivityResult _connectionType = ConnectivityResult.mobile;
  bool _isInitialized = false;

  // Timer to update speed samples
  Timer? _timer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  // Stream controller to send bandwidth change events
  final StreamController<double> _bandwidthController =
      StreamController.broadcast();
  Stream<double> get onBandwidthChanged => _bandwidthController.stream;

  // Getter for average bandwidth
  double get averageBandwidth => _speedSamples.isNotEmpty
      ? _speedSamples.reduce((a, b) => a + b) / _speedSamples.length
      : 0;

  // Getter for connection status
  bool get isConnected => _isConnected;
  ConnectivityResult get connectionType => _connectionType;

  NetworkMonitorService._privateConstructor();

  static final NetworkMonitorService _instance =
      NetworkMonitorService._privateConstructor();

  factory NetworkMonitorService() {
    return _instance;
  }

  bool get isInitialized => _isInitialized;

  /// Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Get initial connection status
    final connectivityResults = await Connectivity().checkConnectivity();
    final connectivityResult = connectivityResults.isNotEmpty
        ? connectivityResults.first
        : ConnectivityResult.none;
    _connectionType = connectivityResult;
    _isConnected = connectivityResult != ConnectivityResult.none;

    // Monitor connection changes
    _connectivitySubscription?.cancel();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final result =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
      _isConnected = result != ConnectivityResult.none;
      _connectionType = result;

      // Clear speed samples if connection is lost
      if (!_isConnected) {
        _speedSamples.clear();
      }
    });

    // Start monitoring network speed
    _startMonitoring();
  }

  /// Start monitoring network speed
  void _startMonitoring() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: _sampleInterval), (
      timer,
    ) {
      if (_isConnected) {
        _sampleNetworkSpeed();
      }
    });
  }

  /// Sample network speed by downloading a small file
  Future<void> _sampleNetworkSpeed() async {
    try {
      final startTime = DateTime.now();
      const url =
          'http://www.google.com/generate_204'; // Lightweight URL for testing

      final httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 5);

      final request = await httpClient.getUrl(Uri.parse(url));
      request.headers.add(
        HttpHeaders.rangeHeader,
        'bytes=0-1023',
      ); // Download only 1KB

      final response = await request.close().timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode == 200 || response.statusCode == 206) {
        final endTime = DateTime.now();
        final duration = endTime.difference(startTime).inMicroseconds;

        if (duration > 0) {
          // Calculate speed in bytes/second
          final speed = (1024 / duration) * 1000000; // bytes/second
          _addSpeedSample(speed);

          if (kDebugMode) {
            print('Network speed: ${(speed / 1024).toStringAsFixed(2)} KB/s');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Network speed test failed: $e');
      }
    }
  }

  /// Add speed sample to list
  void _addSpeedSample(double speed) {
    _speedSamples.add(speed);

    // Limit number of samples
    if (_speedSamples.length > _samplesToKeep) {
      _speedSamples.removeAt(0);
    }

    // Send bandwidth change event
    _bandwidthController.add(averageBandwidth);
  }

  /// Select optimal quality based on current bandwidth
  VideoQuality getOptimalQuality() {
    if (!_isConnected) return VideoQuality.auto;

    final bandwidthKBps = averageBandwidth / 1024; // KB/s

    if (bandwidthKBps <= 0) return VideoQuality.auto;

    // Determine quality based on bandwidth
    if (bandwidthKBps < 200) {
      return VideoQuality.sd360; // ~150 KB/s for 360p
    } else if (bandwidthKBps < 500) {
      return VideoQuality.sd480; // ~300 KB/s for 480p
    } else if (bandwidthKBps < 1200) {
      return VideoQuality.hd720; // ~800 KB/s for 720p
    } else {
      return VideoQuality.hd1080; // ~1500+ KB/s for 1080p
    }
  }

  /// Dispose service
  void dispose() {
    _connectivitySubscription?.cancel();
    _timer?.cancel();
    _isInitialized = false;
    if (!_bandwidthController.isClosed) {
      _bandwidthController.close();
    }
  }
}
