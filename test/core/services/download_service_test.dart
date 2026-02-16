import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:lilinet_app/core/services/download_service.dart';
import 'package:lilinet_app/core/services/local_notification_service.dart';

class MockDio extends Mock implements Dio {}

class MockLocalNotificationService extends Mock
    implements LocalNotificationService {}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {}

class MockDirectory extends Mock implements Directory {}

class MockFile extends Mock implements File {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DownloadService downloadService;
  late MockDio mockDio;
  late MockLocalNotificationService mockNotificationService;
  late MockPathProviderPlatform mockPathProviderPlatform;

  setUp(() {
    mockDio = MockDio();
    mockNotificationService = MockLocalNotificationService();
    mockPathProviderPlatform = MockPathProviderPlatform();

    PathProviderPlatform.instance = mockPathProviderPlatform;
    when(() => mockPathProviderPlatform.getApplicationDocumentsPath())
        .thenAnswer((_) async => '/mock/path');

    downloadService = DownloadService(mockDio, mockNotificationService);

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
  });

  test('downloadVideo sanitizes filename to prevent path traversal', () async {
    const maliciousFileName = '../../evil.sh';
    // Logic: replaceAll(RegExp(r'[\\/|:*?"<>]'), '_').replaceAll('..', '__');
    // ../../evil.sh -> .._.._evil.sh -> ______evil.sh
    const safeFileName = '______evil.sh';
    const url = 'http://example.com/video.mp4';
    // Double downloads because mockDirectory.path is /mock/path/downloads and code appends /downloads
    const expectedPath = '/mock/path/downloads/downloads/$safeFileName';

    // Mock dio download
    when(() => mockDio.download(
          any(),
          any(),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: null,
        ));

    final mockDirectory = MockDirectory();
    when(() => mockDirectory.exists()).thenAnswer((_) async => true);
    when(() => mockDirectory.create(recursive: any(named: 'recursive')))
        .thenAnswer((_) async => mockDirectory);
    when(() => mockDirectory.path).thenReturn('/mock/path/downloads');

    final mockFile = MockFile();
    when(() => mockFile.length()).thenAnswer((_) async => 1024);
    when(() => mockFile.exists())
        .thenAnswer((_) async => true); // for cleanup check
    when(() => mockFile.readAsString())
        .thenAnswer((_) async => '[]'); // empty registry
    when(() => mockFile.writeAsString(any())).thenAnswer((_) async => mockFile);

    await IOOverrides.runZoned(
      () async {
        await downloadService.downloadVideo(
          url: url,
          fileName: maliciousFileName,
        );
      },
      createDirectory: (String path) => mockDirectory,
      createFile: (String path) => mockFile,
    );

    // Verify download was called with sanitized path
    verify(() => mockDio.download(
          url,
          expectedPath,
          onReceiveProgress: any(named: 'onReceiveProgress'),
        )).called(1);
  });
}
