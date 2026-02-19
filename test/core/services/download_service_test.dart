import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:lilinet_app/core/services/download_service.dart';
import 'package:lilinet_app/core/services/local_notification_service.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDio extends Mock implements Dio {}

class MockLocalNotificationService extends Mock
    implements LocalNotificationService {}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/tmp/lilinet_test';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return '/tmp/lilinet_test';
  }

  @override
  Future<String?> getLibraryPath() async {
    return '/tmp/lilinet_test';
  }

  @override
  Future<String?> getTemporaryPath() async {
    return '/tmp/lilinet_test';
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return '/tmp/lilinet_test';
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return ['/tmp/lilinet_test'];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return ['/tmp/lilinet_test'];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return '/tmp/lilinet_test';
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

    // Create temp directory
    Directory('/tmp/lilinet_test').createSync(recursive: true);
    Directory('/tmp/lilinet_test/downloads').createSync(recursive: true);

    // Setup default mocks
    when(() => mockNotificationService.requestPermissions())
        .thenAnswer((_) async => true);
    when(() => mockNotificationService.showDownloadProgress(
          notificationId: any(named: 'notificationId'),
          title: any(named: 'title'),
          progress: any(named: 'progress'),
          maxProgress: any(named: 'maxProgress'),
        )).thenAnswer((_) async {});

    when(() => mockNotificationService.cancelDownloadProgress(any()))
        .thenAnswer((_) async {});

    when(() => mockNotificationService.showDownloadComplete(
          title: any(named: 'title'),
          fileName: any(named: 'fileName'),
          movieId: any(named: 'movieId'),
        )).thenAnswer((_) async {});

    downloadService = DownloadService(mockDio, mockNotificationService);
  });

  tearDown(() {
    if (Directory('/tmp/lilinet_test').existsSync()) {
      Directory('/tmp/lilinet_test').deleteSync(recursive: true);
    }
  });

  test('downloadVideo sanitizes filename to prevent path traversal', () async {
    final fileName = '../../../etc/passwd';
    final url = 'http://example.com/video.mp4';

    // Capture the savePath passed to dio.download
    String? capturedPath;
    when(() => mockDio.download(any(), any(),
            onReceiveProgress: any(named: 'onReceiveProgress')))
        .thenAnswer((invocation) async {
      capturedPath = invocation.positionalArguments[1] as String;
      // create a dummy file so file size check works
      File(capturedPath!).createSync(recursive: true);
      return Response(
          requestOptions: RequestOptions(path: ''), statusCode: 200);
    });

    await downloadService.downloadVideo(
      url: url,
      fileName: fileName,
      movieTitle: 'Test Movie',
    );

    // Verify that the path is sanitized and does NOT contain traversal
    expect(capturedPath, isNot(contains('/downloads/../../../etc/passwd')));
    expect(capturedPath, contains('_________etc_passwd'));
  });

  test('isFileDownloaded sanitizes filename', () async {
    // We create a file outside the downloads directory to simulate what a traversal would try to access
    final outsideFile = File('/tmp/lilinet_test/outside.txt');
    outsideFile.writeAsStringSync('secret');

    // Attempt to access it via traversal
    final result = await downloadService.isFileDownloaded('../outside.txt');

    // Should be false because it should look for '___outside.txt' in downloads
    expect(result, isFalse);

    // Verify it looks for sanitized path
    // We can't verify what file.exists() was called on without mocking File, but we can verify behaviour.

    // Create the sanitized file inside downloads
    final sanitizedFile = File('/tmp/lilinet_test/downloads/___outside.txt');
    sanitizedFile.writeAsStringSync('safe');

    final result2 = await downloadService.isFileDownloaded('../outside.txt');
    expect(result2, isTrue);
  });
}
