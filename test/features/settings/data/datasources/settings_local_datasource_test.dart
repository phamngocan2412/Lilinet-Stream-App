import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:lilinet_app/features/settings/domain/entities/app_settings.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SettingsLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource =
        SettingsLocalDataSource(mockSharedPreferences, mockSecureStorage);
  });

  const tPinCode = '1234';
  final tAppSettings =
      const AppSettings().copyWith(pinCode: tPinCode, language: 'vi');
  final tAppSettingsNoPin = const AppSettings().copyWith(language: 'vi');

  group('saveSettings', () {
    test(
        'should save pinCode to SecureStorage and other settings to SharedPreferences',
        () async {
      // Arrange
      when(() => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async {});
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveSettings(tAppSettings);

      // Assert
      verify(() => mockSecureStorage.write(
          key: 'settings_pin_code', value: tPinCode)).called(1);

      final jsonCaptor = verify(() =>
              mockSharedPreferences.setString('app_settings', captureAny()))
          .captured
          .first as String;
      final jsonMap = jsonDecode(jsonCaptor) as Map<String, dynamic>;

      expect(
          jsonMap['pinCode'], isNull); // Verify PIN is NOT in SharedPreferences
      expect(jsonMap['language'], 'vi');
    });

    test('should delete pinCode from SecureStorage if it is null', () async {
      // Arrange
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveSettings(tAppSettingsNoPin);

      // Assert
      verify(() => mockSecureStorage.delete(key: 'settings_pin_code'))
          .called(1);
    });
  });

  group('getSettings', () {
    test('should return AppSettings with pinCode from SecureStorage', () async {
      // Arrange
      final jsonMap = tAppSettingsNoPin.toJson(); // No PIN in JSON
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(jsonEncode(jsonMap));
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tPinCode);

      // Act
      final result = await dataSource.getSettings();

      // Assert
      expect(result.pinCode, tPinCode);
      expect(result.language, 'vi');
    });

    test('should return AppSettings without pinCode if not in SecureStorage',
        () async {
      // Arrange
      final jsonMap = tAppSettingsNoPin.toJson();
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(jsonEncode(jsonMap));
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      // Act
      final result = await dataSource.getSettings();

      // Assert
      expect(result.pinCode, isNull);
    });
  });
}
