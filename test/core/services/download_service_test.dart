import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/services/download_service.dart';
import 'package:lilinet_app/core/services/local_notification_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDio extends Mock implements Dio {}

class MockLocalNotificationService extends Mock
    implements LocalNotificationService {}

class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return Directory.systemTemp.path;
  }
}

void main() {
  late DownloadService downloadService;
  late MockDio mockDio;
  late MockLocalNotificationService mockNotificationService;

  setUp(() {
    mockDio = MockDio();
    mockNotificationService = MockLocalNotificationService();
    PathProviderPlatform.instance = MockPathProviderPlatform();
    downloadService = DownloadService(mockDio, mockNotificationService);

    // Mock successful download
    when(() => mockDio.download(any(), any(),
        onReceiveProgress:
            any(named: 'onReceiveProgress'))).thenAnswer((_) async =>
        Response(requestOptions: RequestOptions(path: ''), statusCode: 200));

    // Mock notification service
    when(() => mockNotificationService.requestPermissions())
        .thenAnswer((_) async => true);
    when(() => mockNotificationService.showDownloadProgress(
          notificationId: any(named: 'notificationId'),
          title: any(named: 'title'),
          progress: any(named: 'progress'),
          maxProgress: any(named: 'maxProgress'),
        )).thenAnswer((_) async {});
    when(() => mockNotificationService.showDownloadComplete(
          title: any(named: 'title'),
          fileName: any(named: 'fileName'),
          movieId: any(named: 'movieId'),
        )).thenAnswer((_) async {});
    when(() => mockNotificationService.cancelDownloadProgress(any()))
        .thenAnswer((_) async {});
  });

  test('downloadVideo sanitizes filename to prevent path traversal', () async {
    const maliciousFileName = '../../evil.sh';
    // We expect sanitization to replace '..' and '/' with '_'
    // The exact replacement depends on implementation, but assuming typical replacement:
    // ../../evil.sh -> .._.._evil.sh or ____evil.sh
    // Let's assume we implement replacing / and \ with _ and .. with __
    // For now, let's just check that it DOESN'T contain '..' or '/'

    // Actually, to make verify precise, let's define the expected sanitized name.
    // If I replace / and \ with _, it becomes '.._.._evil.sh'.
    // If I also replace '..', it might be different.
    // A simple safe filename sanitization is replacing all non-alphanumeric (except . - _) with _.

    // Let's assume the fix will sanitize `../../evil.sh` to `.._.._evil.sh` (just replacing slashes).
    // Or better, `____evil.sh`.

    // Sanitization replaces `/` with `_`. `..` remains but is no longer a path segment.
    const expectedPathSuffix = '.._.._evil.sh';

    await downloadService.downloadVideo(
      url: 'http://example.com/video.mp4',
      fileName: maliciousFileName,
    );

    // Verify that Dio.download was called with a path that ends with the sanitized filename
    // and definitely NOT with ../../
    final captured = verify(() => mockDio.download(
          any(),
          captureAny(),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        )).captured;

    final savedPath = captured.last as String;

    // Ensure path traversal is mitigated
    expect(savedPath.contains('../../'), isFalse,
        reason: 'Path traversal detected!');
    expect(savedPath.endsWith('/downloads/$expectedPathSuffix'), isTrue,
        reason: 'Filename was not sanitized as expected');
  });
}
