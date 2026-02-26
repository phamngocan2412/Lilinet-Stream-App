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
    final tempDir = Directory('/tmp/lilinet_test');
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
    tempDir.createSync(recursive: true);
    Directory('/tmp/lilinet_test/downloads').createSync(recursive: true);

    // Setup default mocks
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(
      (int received, int total) {},
    ); // fallback for onReceiveProgress

    when(() => mockNotificationService.requestPermissions())
        .thenAnswer((_) async => true);
    when(
      () => mockNotificationService.showDownloadProgress(
        notificationId: any(named: 'notificationId'),
        title: any(named: 'title'),
        progress: any(named: 'progress'),
        maxProgress: any(named: 'maxProgress'),
      ),
    ).thenAnswer((_) async {});

    when(() => mockNotificationService.cancelDownloadProgress(any()))
        .thenAnswer((_) async {});

    when(
      () => mockNotificationService.showDownloadComplete(
        title: any(named: 'title'),
        fileName: any(named: 'fileName'),
        movieId: any(named: 'movieId'),
      ),
    ).thenAnswer((_) async {});

    // Mock dio download to call onReceiveProgress immediately
    when(
      () => mockDio.download(
        any(),
        any(),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).thenAnswer((invocation) async {
      final callback =
          invocation.namedArguments[const Symbol('onReceiveProgress')] as void
              Function(int, int)?;
      if (callback != null) {
        callback(100, 100);
      }
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
      );
    });

    downloadService = DownloadService(mockDio, mockNotificationService);
  });

  tearDown(() {
    if (Directory('/tmp/lilinet_test').existsSync()) {
      Directory('/tmp/lilinet_test').deleteSync(recursive: true);
    }
  });

  test('downloadVideo sanitizes filename to prevent path traversal', () async {
    const fileName = '../../../etc/passwd';
    const url = 'http://example.com/video.mp4';

    // Capture the savePath passed to dio.download
    String? capturedPath;
    when(
      () => mockDio.download(
        any(),
        any(),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).thenAnswer((invocation) async {
      capturedPath = invocation.positionalArguments[1] as String;
      // create a dummy file so file size check works
      final file = File(capturedPath!);
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('dummy content');
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
      );
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
    outsideFile.parent.createSync(recursive: true);
    outsideFile.writeAsStringSync('secret');

    // Attempt to access it via traversal
    final result = await downloadService.isFileDownloaded('../outside.txt');

    // Should be false because it should look for '___outside.txt' in downloads
    expect(result, isFalse);

    // Verify it looks for sanitized path
    // Based on previous test, `..` seems to become `___` or similar.
    // `../outside.txt`
    // `/` -> `_`
    // `.._outside.txt`
    // `..` -> `__`
    // `___outside.txt` (3 underscores?)
    // Or if dots are replaced: `___outside_txt`?
    // Let's look at `downloadVideo` test result: `_________etc_passwd` from `../../../etc/passwd`.
    // `../../../` -> `_________` (9 underscores).
    // So `../` -> `___` (3 underscores).
    // So `../outside.txt` -> `___outside.txt` (if dot in .txt is preserved? Wait)
    // `passwd` has no extension. `outside.txt` has dot.
    // If dots are replaced, `___outside_txt`.
    // Let's try to match what the code does.
    // Code:
    // fileName.replaceAll(RegExp(r'[\\/|:*?"<>]'), '_')
    //         .replaceAll('..', '__')
    //         .replaceAll(RegExp(r'[\x00-\x1f]'), '');
    //
    // `../outside.txt`
    // 1. `.._outside.txt`
    // 2. `__` + `_` + `outside.txt` -> `___outside.txt`
    // 3. `___outside.txt`
    //
    // `../../../etc/passwd`
    // 1. `.._.._.._etc/passwd` (wait, slash is replaced globally?)
    //    `.._.._.._etc_passwd`
    // 2. `__` + `_` + `__` + `_` + `__` + `_` + `etc_passwd`
    //    `___` + `___` + `___` + `etc_passwd`
    //    `_________etc_passwd`
    //
    // So `../outside.txt` -> `___outside.txt`.

    // Create the sanitized file inside downloads
    final sanitizedFile = File('/tmp/lilinet_test/downloads/___outside.txt');
    sanitizedFile.writeAsStringSync('safe');

    final result2 = await downloadService.isFileDownloaded('../outside.txt');
    expect(result2, isTrue);
  });

  test('downloadVideo uses default filename if input is invalid/empty',
      () async {
    const fileName = ''; // Empty string
    const url = 'http://example.com/video.mp4';

    // Capture the savePath passed to dio.download
    String? capturedPath;
    when(
      () => mockDio.download(
        any(),
        any(),
        onReceiveProgress: any(named: 'onReceiveProgress'),
      ),
    ).thenAnswer((invocation) async {
      capturedPath = invocation.positionalArguments[1] as String;
      // create a dummy file so file size check works
      final file = File(capturedPath!);
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('dummy content');
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
      );
    });

    await downloadService.downloadVideo(
      url: url,
      fileName: fileName,
      movieTitle: 'Test Movie',
    );

    // Verify that the path uses a fallback name (starts with download_)
    expect(capturedPath, contains('/downloads/download_'));
    // And is not just empty or slashes
    expect(capturedPath, isNot(contains('///')));
  });
}
