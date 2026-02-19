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
    final pinCode = await secureStorage.read(key: _pinCodeKey);

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      if (pinCode != null) {
        json['pinCode'] = pinCode;
      }
      return AppSettings.fromJson(json);
    }
    return const AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    if (settings.pinCode != null) {
      await secureStorage.write(key: _pinCodeKey, value: settings.pinCode);
    } else {
      await secureStorage.delete(key: _pinCodeKey);
    }

    final json = settings.toJson();
    json.remove('pinCode');

    final jsonString = jsonEncode(json);
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
