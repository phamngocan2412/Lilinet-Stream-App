import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Notification channel IDs
class NotificationChannels {
  static const String downloads = 'downloads_channel';
  static const String reminders = 'reminders_channel';
  static const String updates = 'updates_channel';
  static const String comments = 'comments_channel';
}

/// Notification IDs for different types
class NotificationIds {
  static const int downloadComplete = 1000;
  static const int watchReminder = 2000;
  static const int newEpisode = 3000;
  static const int commentReply = 4000;
}

@lazySingleton
class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz_data.initializeTimeZones();

    // Android settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Linux settings
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open',
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels for Android
    if (Platform.isAndroid) {
      await _createNotificationChannels();
    }

    _isInitialized = true;
    debugPrint('✅ LocalNotificationService initialized');
  }

  /// Create Android notification channels
  Future<void> _createNotificationChannels() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) return;

    // Downloads channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.downloads,
        'Downloads',
        description: 'Notifications for download progress and completion',
        importance: Importance.high,
      ),
    );

    // Reminders channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.reminders,
        'Watch Reminders',
        description: 'Reminders to continue watching',
        importance: Importance.defaultImportance,
      ),
    );

    // Updates channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.updates,
        'New Episodes',
        description: 'Notifications for new episodes',
        importance: Importance.high,
      ),
    );

    // Comments channel
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.comments,
        'Comments',
        description: 'Notifications for comment replies',
        importance: Importance.defaultImportance,
      ),
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('🔔 Notification tapped: ${response.payload}');
    // Handle navigation based on payload
    // The payload can contain route info like: "movie/123" or "comment/456"
  }

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? false;
    } else if (Platform.isIOS) {
      final iosPlugin = _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return true;
  }

  /// Show download complete notification
  Future<void> showDownloadComplete({
    required String title,
    required String fileName,
    String? movieId,
  }) async {
    await _notifications.show(
      NotificationIds.downloadComplete + DateTime.now().millisecond,
      '✅ Download Complete',
      '$title - $fileName',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.downloads,
          'Downloads',
          channelDescription: 'Download notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: movieId != null ? 'movie/$movieId' : null,
    );
  }

  /// Show download progress notification
  Future<void> showDownloadProgress({
    required int notificationId,
    required String title,
    required int progress,
    required int maxProgress,
  }) async {
    await _notifications.show(
      notificationId,
      'Downloading',
      title,
      NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.downloads,
          'Downloads',
          channelDescription: 'Download progress',
          importance: Importance.low,
          priority: Priority.low,
          showProgress: true,
          maxProgress: maxProgress,
          progress: progress,
          ongoing: true,
          autoCancel: false,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  /// Cancel download progress notification
  Future<void> cancelDownloadProgress(int notificationId) async {
    await _notifications.cancel(notificationId);
  }

  /// Show new episode notification
  Future<void> showNewEpisode({
    required String showTitle,
    required String episodeTitle,
    required String movieId,
  }) async {
    await _notifications.show(
      NotificationIds.newEpisode + DateTime.now().millisecond,
      '🎬 New Episode Available',
      '$showTitle - $episodeTitle',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.updates,
          'New Episodes',
          channelDescription: 'New episode notifications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'movie/$movieId',
    );
  }

  /// Show comment reply notification
  Future<void> showCommentReply({
    required String username,
    required String replyPreview,
    required String commentId,
    required String videoId,
  }) async {
    await _notifications.show(
      NotificationIds.commentReply + DateTime.now().millisecond,
      '💬 $username replied to your comment',
      replyPreview.length > 100
          ? '${replyPreview.substring(0, 100)}...'
          : replyPreview,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.comments,
          'Comments',
          channelDescription: 'Comment notifications',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'comment/$videoId/$commentId',
    );
  }

  /// Schedule a watch reminder
  Future<void> scheduleWatchReminder({
    required String movieTitle,
    required String movieId,
    required Duration delay,
    String? episodeInfo,
  }) async {
    final scheduledTime = tz.TZDateTime.now(tz.local).add(delay);

    await _notifications.zonedSchedule(
      NotificationIds.watchReminder + movieId.hashCode,
      '🍿 Continue Watching',
      episodeInfo != null
          ? '$movieTitle - $episodeInfo'
          : 'Continue watching $movieTitle',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.reminders,
          'Watch Reminders',
          channelDescription: 'Reminder notifications',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: null,
      payload: 'movie/$movieId',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    debugPrint('⏰ Watch reminder scheduled for $movieTitle at $scheduledTime');
  }

  /// Cancel a watch reminder
  Future<void> cancelWatchReminder(String movieId) async {
    await _notifications.cancel(
      NotificationIds.watchReminder + movieId.hashCode,
    );
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Get pending notifications count
  Future<int> getPendingNotificationsCount() async {
    final pending = await _notifications.pendingNotificationRequests();
    return pending.length;
  }
}
