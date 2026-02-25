import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/network/dio_client.dart';
import 'core/supabase/supabase_config.dart';
import 'core/services/miniplayer_height_notifier.dart';
import 'features/movies/data/models/movie_model.dart';
import 'features/history/data/models/watch_progress_model.dart';
import 'hive_registrar.g.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  // Hive Setup
  await Hive.initFlutter();
  Hive.registerAdapters();

  // Initialize generated dependencies
  await getIt.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => NetworkModule.dio;

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          // ignore: deprecated_member_use
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );

  @lazySingleton
  SupabaseClient get supabaseClient => SupabaseConfig.client;

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          // ignore: deprecated_member_use
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );

  @preResolve
  Future<Box<WatchProgressModel>> get watchHistoryBox =>
      Hive.openBox<WatchProgressModel>('watch_history');

  @preResolve
  Future<Box<MovieListResponse>> get movieCacheBox =>
      Hive.openBox<MovieListResponse>('movie_cache');

  @preResolve
  Future<Box<MovieModel>> get movieDetailsBox =>
      Hive.openBox<MovieModel>('movie_details_cache');

  @preResolve
  Future<Box<DateTime>> get cacheTimestampBox =>
      Hive.openBox<DateTime>('cache_timestamps');

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  MiniplayerHeightNotifier get miniplayerHeightNotifier =>
      MiniplayerHeightNotifier();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
}
