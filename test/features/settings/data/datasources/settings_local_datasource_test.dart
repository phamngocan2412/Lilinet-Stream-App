import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lilinet_app/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:lilinet_app/features/settings/domain/entities/app_settings.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SettingsLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource = SettingsLocalDataSource(mockSharedPreferences, mockSecureStorage);
  });

  const tAppSettings = AppSettings(
    pinCode: '1234',
    themeMode: ThemeMode.dark,
  );

  group('saveSettings', () {
    test('should save non-sensitive data to SharedPreferences and sensitive data to SecureStorage', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      // act
      await dataSource.saveSettings(tAppSettings);

      // assert
      // Verify SharedPreferences does NOT contain pinCode
      verify(() => mockSharedPreferences.setString(
        'app_settings',
        any(that: predicate<String>((jsonString) {
          final Map<String, dynamic> json = jsonDecode(jsonString);
          return !json.containsKey('pinCode');
        })),
      ));

      // Verify SecureStorage DOES contain pinCode
      verify(() => mockSecureStorage.write(
        key: 'settings_pin_code',
        value: '1234',
      ));
    });

    test('should remove pinCode from SecureStorage if it is null', () async {
      // arrange
      const tAppSettingsNullPin = AppSettings(pinCode: null);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      // act
      await dataSource.saveSettings(tAppSettingsNullPin);

      // assert
      verify(() => mockSecureStorage.delete(key: 'settings_pin_code'));
    });
  });

  group('getSettings', () {
    test('should merge sensitive data from SecureStorage', () async {
      // arrange
      final tAppSettingsJson = tAppSettings.toJson();
      tAppSettingsJson.remove('pinCode');

      when(() => mockSharedPreferences.getString('app_settings'))
          .thenReturn(jsonEncode(tAppSettingsJson));
      when(() => mockSecureStorage.read(key: 'settings_pin_code'))
          .thenAnswer((_) async => '1234');

      // act
      final result = await dataSource.getSettings();

      // assert
      expect(result, tAppSettings);
      expect(result.pinCode, '1234');
    });

     test('should return settings with null pinCode if not in SecureStorage', () async {
      // arrange
      final tAppSettingsJson = tAppSettings.toJson();
      tAppSettingsJson.remove('pinCode');

      when(() => mockSharedPreferences.getString('app_settings'))
          .thenReturn(jsonEncode(tAppSettingsJson));
      when(() => mockSecureStorage.read(key: 'settings_pin_code'))
          .thenAnswer((_) async => null);

      // act
      final result = await dataSource.getSettings();

      // assert
      expect(result.pinCode, null);
    });

    test('should migrate pinCode from SharedPreferences to SecureStorage if present', () async {
      // arrange
      final tLegacyJson = tAppSettings.toJson();
      // Ensure pinCode IS in the legacy JSON
      tLegacyJson['pinCode'] = '1234';

      when(() => mockSharedPreferences.getString('app_settings'))
          .thenReturn(jsonEncode(tLegacyJson));
      when(() => mockSecureStorage.read(key: 'settings_pin_code'))
          .thenAnswer((_) async => null); // Initially empty in secure storage
      when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // act
      final result = await dataSource.getSettings();

      // assert
      // Should write to secure storage
      verify(() => mockSecureStorage.write(key: 'settings_pin_code', value: '1234'));

      // Should remove from shared preferences
      verify(() => mockSharedPreferences.setString(
        'app_settings',
        any(that: predicate<String>((jsonString) {
          final Map<String, dynamic> json = jsonDecode(jsonString);
          return !json.containsKey('pinCode');
        })),
      ));

      // Should return correctly populated settings
      expect(result.pinCode, '1234');
    });
  });

  group('resetSettings', () {
    test('should clear both SharedPreferences and SecureStorage', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any())).thenAnswer((_) async => true);
      when(() => mockSecureStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});

      // act
      await dataSource.resetSettings();

      // assert
      verify(() => mockSharedPreferences.remove('app_settings'));
      verify(() => mockSecureStorage.delete(key: 'settings_pin_code'));
    });
  });
}
