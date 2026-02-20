import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    final securePinCode = await secureStorage.read(key: _pinCodeKey);

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;

      // Prioritize secure storage for PIN code
      if (securePinCode != null) {
        json['pinCode'] = securePinCode;
      }

      return AppSettings.fromJson(json);
    }

    // Fallback: If no settings in shared prefs but PIN exists in secure storage
    if (securePinCode != null) {
      return const AppSettings().copyWith(pinCode: securePinCode);
    }

    return const AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    final jsonMap = settings.toJson();

    // Securely handle PIN code
    final pinCode = jsonMap['pinCode'] as String?;
    if (pinCode != null) {
      await secureStorage.write(key: _pinCodeKey, value: pinCode);
      // Remove PIN code from shared prefs storage to prevent plain text exposure
      jsonMap.remove('pinCode');
    } else {
      await secureStorage.delete(key: _pinCodeKey);
    }

    final jsonString = jsonEncode(jsonMap);
    await sharedPreferences.setString(_settingsKey, jsonString);
  }

  Future<void> resetSettings() async {
    await sharedPreferences.remove(_settingsKey);
    await secureStorage.delete(key: _pinCodeKey);
  }

  Future<void> clearCache() async {
    await AppImageCacheManager.clear();
  }
}
