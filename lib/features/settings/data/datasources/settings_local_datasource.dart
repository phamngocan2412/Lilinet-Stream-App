import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/cache/app_image_cache_manager.dart';
import '../../domain/entities/app_settings.dart';

@lazySingleton
class SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;
  static const String _settingsKey = 'app_settings';
  static const String _pinCodeKey = 'settings_pin_code';

  SettingsLocalDataSource(this.sharedPreferences, this.secureStorage);

  Future<AppSettings> getSettings() async {
    final jsonString = sharedPreferences.getString(_settingsKey);
    String? pinCode;

    try {
      pinCode = await secureStorage.read(key: _pinCodeKey);
    } catch (e) {
      // Handle secure storage errors gracefully
      pinCode = null;
    }

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;

      // Migration: Check if pinCode is in SharedPreferences (legacy data)
      if (json.containsKey('pinCode')) {
        final legacyPin = json['pinCode'] as String?;

        if (legacyPin != null) {
          // Move to SecureStorage
          await secureStorage.write(key: _pinCodeKey, value: legacyPin);
          pinCode = legacyPin;
        }

        // Remove from SharedPreferences immediately to secure the data
        json.remove('pinCode');
        await sharedPreferences.setString(_settingsKey, jsonEncode(json));
      }

      // Inject pinCode if available (from SecureStorage or just migrated)
      if (pinCode != null) {
        json['pinCode'] = pinCode;
      }

      return AppSettings.fromJson(json);
    }

    // If no settings found, but pinCode exists, try to preserve it
    if (pinCode != null) {
      return const AppSettings().copyWith(pinCode: pinCode);
    }

    return const AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    final json = settings.toJson();
    final pinCode = settings.pinCode;

    // Remove sensitive data from shared preferences payload
    json.remove('pinCode');

    final jsonString = jsonEncode(json);
    await sharedPreferences.setString(_settingsKey, jsonString);

    // Save sensitive data to secure storage
    if (pinCode != null) {
      await secureStorage.write(key: _pinCodeKey, value: pinCode);
    } else {
      await secureStorage.delete(key: _pinCodeKey);
    }
  }

  Future<void> resetSettings() async {
    await sharedPreferences.remove(_settingsKey);
    await secureStorage.delete(key: _pinCodeKey);
  }

  Future<void> clearCache() async {
    await AppImageCacheManager.clear();
  }
}
