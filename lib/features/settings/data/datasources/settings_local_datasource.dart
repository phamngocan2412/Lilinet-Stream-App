import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';
import '../../domain/entities/app_settings.dart';

@lazySingleton
class SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _settingsKey = 'app_settings';

  SettingsLocalDataSource(this.sharedPreferences);

  Future<AppSettings> getSettings() async {
    final jsonString = sharedPreferences.getString(_settingsKey);
    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJson(json);
    }
    return const AppSettings();
  }

  Future<void> saveSettings(AppSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await sharedPreferences.setString(_settingsKey, jsonString);
  }

  Future<void> resetSettings() async {
    await sharedPreferences.remove(_settingsKey);
  }

  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
