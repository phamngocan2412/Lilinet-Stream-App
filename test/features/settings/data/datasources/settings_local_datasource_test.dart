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
  const pinCodeKey = 'settings_pin_code';
  const settingsKey = 'app_settings';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource =
        SettingsLocalDataSource(mockSharedPreferences, mockSecureStorage);
  });

  group('getSettings', () {
    test('should return default settings when no data is cached', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      // act
      final result = await dataSource.getSettings();

      // assert
      expect(result, const AppSettings());
      verify(() => mockSharedPreferences.getString(settingsKey));
      verify(() => mockSecureStorage.read(key: pinCodeKey));
    });

    test('should return cached settings with secure PIN code', () async {
      // arrange
      const tPinCode = '1234';
      final tSettings = const AppSettings().copyWith(language: 'vi');
      final tSettingsJson = tSettings.toJson();
      // Assume stored JSON does not have PIN code (as intended)
      tSettingsJson.remove('pinCode');

      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(jsonEncode(tSettingsJson));
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tPinCode);

      // act
      final result = await dataSource.getSettings();

      // assert
      expect(result.pinCode, tPinCode);
      expect(result.language, 'vi');
      verify(() => mockSharedPreferences.getString(settingsKey));
      verify(() => mockSecureStorage.read(key: pinCodeKey));
    });

    test(
        'should prioritise secure PIN over shared prefs PIN (migration scenario)',
        () async {
      // arrange
      const tSecurePin = '1234';
      const tInsecurePin = '0000';
      final tSettings = const AppSettings().copyWith(pinCode: tInsecurePin);
      final tSettingsJson = tSettings.toJson(); // Contains insecure PIN

      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(jsonEncode(tSettingsJson));
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tSecurePin);

      // act
      final result = await dataSource.getSettings();

      // assert
      expect(result.pinCode, tSecurePin);
    });
  });

  group('saveSettings', () {
    test('should save PIN code to secure storage and others to shared prefs',
        () async {
      // arrange
      const tPinCode = '1234';
      final tSettings = const AppSettings().copyWith(pinCode: tPinCode);

      when(() => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async {});
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // act
      await dataSource.saveSettings(tSettings);

      // assert
      verify(() => mockSecureStorage.write(key: pinCodeKey, value: tPinCode));

      final captured = verify(
              () => mockSharedPreferences.setString(settingsKey, captureAny()))
          .captured
          .first as String;

      final savedJson = jsonDecode(captured) as Map<String, dynamic>;
      expect(savedJson.containsKey('pinCode'), false);
    });

    test('should clear secure PIN if settings has no PIN', () async {
      // arrange
      final tSettings = const AppSettings().copyWith(pinCode: null);

      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // act
      await dataSource.saveSettings(tSettings);

      // assert
      verify(() => mockSecureStorage.delete(key: pinCodeKey));
      verify(() => mockSharedPreferences.setString(settingsKey, any()));
    });
  });

  group('resetSettings', () {
    test('should clear both storage locations', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      // act
      await dataSource.resetSettings();

      // assert
      verify(() => mockSharedPreferences.remove(settingsKey));
      verify(() => mockSecureStorage.delete(key: pinCodeKey));
    });
  });
}
