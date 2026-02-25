import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'local_notification_service.dart';
import '../../features/downloads/domain/entities/downloaded_file.dart';

@lazySingleton
class DownloadService {
  final Dio _dio;
  final LocalNotificationService _notificationService;

  DownloadService(this._dio, this._notificationService);

  // Track download progress: url -> progress (0.0 to 1.0)
  final Map<String, ValueNotifier<double>> _progressMap = {};

  // Cache of downloaded files
  List<DownloadedFile>? _cachedDownloads;

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

  /// Sanitize filename to prevent path traversal attacks
  String _sanitizeFileName(String fileName) {
    // Replace characters that are invalid in filenames or could lead to path traversal
    // Also remove control characters
    return fileName
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
        .replaceAll(RegExp(r'[\x00-\x1f]'), '');
  }

  Future<void> downloadVideo({
    required String url,
    required String fileName,
    String? movieId,
    String? movieTitle,
    String? episodeTitle,
    String? posterUrl,
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
      final sanitizedFileName = _sanitizeFileName(fileName);
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/downloads/$sanitizedFileName';

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
        title: movieTitle ?? sanitizedFileName,
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
                title: movieTitle ?? sanitizedFileName,
                progress: (progress * 100).toInt(),
                maxProgress: 100,
              );
            }
          }
        },
      );

      _progressMap.remove(url);

      // Get file size
      final file = File(savePath);
      final fileSize = await file.length();

      // Save to registry
      await _addToRegistry(
        DownloadedFile(
          id: url.hashCode.toString(),
          fileName: sanitizedFileName,
          filePath: savePath,
          movieId: movieId,
          movieTitle: movieTitle,
          episodeTitle: episodeTitle,
          posterUrl: posterUrl,
          fileSize: fileSize,
          downloadedAt: DateTime.now(),
          url: url,
        ),
      );

      // Cancel progress notification
      await _notificationService.cancelDownloadProgress(notificationId);

      // Show completion notification
      await _notificationService.showDownloadComplete(
        title: movieTitle ?? 'Video',
        fileName: sanitizedFileName,
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

  /// Get the registry file path
  Future<String> get _registryPath async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/downloads/registry.json';
  }

  /// Add a downloaded file to registry
  Future<void> _addToRegistry(DownloadedFile file) async {
    try {
      final downloads = await getDownloadedFiles();
      downloads.removeWhere((d) => d.id == file.id);
      downloads.add(file);

      final registryFile = File(await _registryPath);
      await registryFile.writeAsString(
        jsonEncode(downloads.map((d) => d.toJson()).toList()),
      );

      _cachedDownloads = downloads;
    } catch (e) {
      debugPrint('Error adding to registry: $e');
    }
  }

  /// Get all downloaded files
  Future<List<DownloadedFile>> getDownloadedFiles() async {
    if (_cachedDownloads != null) return _cachedDownloads!;

    try {
      final registryFile = File(await _registryPath);
      if (await registryFile.exists()) {
        final content = await registryFile.readAsString();
        final List<dynamic> json = jsonDecode(content);
        _cachedDownloads = json.map((j) => DownloadedFile.fromJson(j)).toList();

        // Clean up non-existent files
        _cachedDownloads = _cachedDownloads!.where((d) {
          return File(d.filePath).existsSync();
        }).toList();

        return _cachedDownloads!;
      }
    } catch (e) {
      debugPrint('Error reading registry: $e');
    }

    return [];
  }

  /// Delete a downloaded file
  Future<bool> deleteDownload(String id) async {
    try {
      final downloads = await getDownloadedFiles();
      final file = downloads.firstWhere((d) => d.id == id);

      // Delete the file
      final fileObj = File(file.filePath);
      if (await fileObj.exists()) {
        await fileObj.delete();
      }

      // Remove from registry
      downloads.removeWhere((d) => d.id == id);

      final registryFile = File(await _registryPath);
      await registryFile.writeAsString(
        jsonEncode(downloads.map((d) => d.toJson()).toList()),
      );

      _cachedDownloads = downloads;
      return true;
    } catch (e) {
      debugPrint('Error deleting download: $e');
      return false;
    }
  }

  /// Get total size of all downloads
  Future<int> getTotalDownloadSize() async {
    final downloads = await getDownloadedFiles();
    return downloads.fold<int>(0, (sum, d) => sum + d.fileSize);
  }

  /// Get formatted total size
  Future<String> getTotalDownloadSizeFormatted() async {
    final size = await getTotalDownloadSize();
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    if (size < 1024 * 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Check if a file is downloaded by URL
  Future<DownloadedFile?> getDownloadByUrl(String url) async {
    final downloads = await getDownloadedFiles();
    try {
      return downloads.firstWhere((d) => d.url == url);
    } catch (_) {
      return null;
    }
  }

  Future<bool> isFileDownloaded(String fileName) async {
    try {
      final sanitizedFileName = _sanitizeFileName(fileName);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloads/$sanitizedFileName');
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  Future<String?> getDownloadedFilePath(String fileName) async {
    try {
      final sanitizedFileName = _sanitizeFileName(fileName);
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/downloads/$sanitizedFileName';
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
