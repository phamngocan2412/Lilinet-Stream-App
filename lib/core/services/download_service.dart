import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'local_notification_service.dart';

@lazySingleton
class DownloadService {
  final Dio _dio;
  final LocalNotificationService _notificationService;

  DownloadService(this._dio, this._notificationService);

  // Track download progress: url -> progress (0.0 to 1.0)
  final Map<String, ValueNotifier<double>> _progressMap = {};

  ValueNotifier<double>? getProgressNotifier(String url) => _progressMap[url];

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      // For Android 13+, notifications permission is enough for foreground service
      // For storage, scoped storage is used.
      // We'll use app-specific storage which doesn't need explicit permission usually.
      return await _notificationService.requestPermissions();
    }
    return true;
  }

  Future<void> downloadVideo({
    required String url,
    required String fileName,
    String? movieId,
    String? movieTitle,
    Function(String path)? onCompleted,
    Function(String error)? onError,
  }) async {
    if (!await _requestPermission()) {
      onError?.call('Permission denied');
      return;
    }

    // Generate a stable ID for notification based on URL hash
    final notificationId = url.hashCode;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/downloads/$fileName';

      // Create directory if not exists
      final saveDir = Directory('${dir.path}/downloads');
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      // Check if already downloading
      if (_progressMap.containsKey(url)) {
        return;
      }

      final notifier = ValueNotifier<double>(0.0);
      _progressMap[url] = notifier;

      // Show initial notification
      await _notificationService.showDownloadProgress(
        notificationId: notificationId,
        title: movieTitle ?? fileName,
        progress: 0,
        maxProgress: 100,
      );

      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            notifier.value = progress;

            // Update notification every 5% to avoid flooding
            if ((progress * 100).toInt() % 5 == 0) {
              _notificationService.showDownloadProgress(
                notificationId: notificationId,
                title: movieTitle ?? fileName,
                progress: (progress * 100).toInt(),
                maxProgress: 100,
              );
            }
          }
        },
      );

      _progressMap.remove(url);

      // Cancel progress notification
      await _notificationService.cancelDownloadProgress(notificationId);

      // Show completion notification
      await _notificationService.showDownloadComplete(
        title: movieTitle ?? 'Video',
        fileName: fileName,
        movieId: movieId,
      );

      debugPrint('✅ Download completed: $savePath');
      onCompleted?.call(savePath);
    } catch (e) {
      _progressMap.remove(url);
      await _notificationService.cancelDownloadProgress(notificationId);
      debugPrint('❌ Download error: $e');
      onError?.call(e.toString());
    }
  }

  Future<bool> isFileDownloaded(String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloads/$fileName');
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  Future<String?> getDownloadedFilePath(String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/downloads/$fileName';
      if (await File(path).exists()) {
        return path;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void dispose() {
    for (final notifier in _progressMap.values) {
      notifier.dispose();
    }
    _progressMap.clear();
  }
}
