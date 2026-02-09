import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'core/supabase/supabase_config.dart';
import 'core/services/video_player_service.dart';
import 'core/services/cast_service.dart';
import 'core/services/download_service.dart';
import 'core/services/video_session_repository.dart';
import 'app.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'features/explore/presentation/bloc/explore_bloc.dart';
import 'features/explore/presentation/bloc/explore_event.dart';
import 'features/movies/data/datasources/movie_local_datasource.dart';
import 'core/widgets/loading_indicator.dart';
import 'injection_container.dart';

void main() {
  // Wrap everything in runZonedGuarded to catch async errors
  runZonedGuarded(() {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set up Flutter error handler
    FlutterError.onError = _handleFlutterError;

    // Set up custom error widget for release mode
    ErrorWidget.builder = _buildErrorWidget;

    // Set system UI mode early
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    // Run the app with a splash/loading screen first
    runApp(const SplashApp());

    // Initialize everything in the background
    _initializeApp();
  }, _handleUncaughtError);
}

/// Handles Flutter framework errors
void _handleFlutterError(FlutterErrorDetails details) {
  if (kDebugMode) {
    // In debug mode, print to console
    FlutterError.dumpErrorToConsole(details);
  } else {
    // In release mode, log silently (could send to crash reporting service)
    debugPrint('Flutter Error: ${details.exceptionAsString()}');
  }
}

/// Handles uncaught async errors
void _handleUncaughtError(Object error, StackTrace stackTrace) {
  if (kDebugMode) {
    debugPrint('═══════════════════════════════════════════════════════');
    debugPrint('🚨 UNCAUGHT ERROR');
    debugPrint('Error: $error');
    debugPrint('Stack trace:\n$stackTrace');
    debugPrint('═══════════════════════════════════════════════════════');
  } else {
    // In release mode, log silently (could send to crash reporting service)
    debugPrint('Uncaught Error: $error');
  }
}

/// Builds a user-friendly error widget for release mode
Widget _buildErrorWidget(FlutterErrorDetails details) {
  if (kDebugMode) {
    // In debug mode, show the default red error screen with details
    return ErrorWidget(details.exception);
  }

  // In release mode, show a friendly error UI
  return Material(
    child: Container(
      color: const Color(0xFF101010),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'An unexpected error occurred',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please restart the app',
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

class SplashApp extends StatelessWidget {
  const SplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 150, height: 150),
              const SizedBox(height: 32),
              const LoadingIndicator(size: 40, color: Color(0xFFC6A664)),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _initializeApp() async {
  try {
    // Initialize MediaKit (lightweight call)
    MediaKit.ensureInitialized();

    // Initialize Supabase
    await SupabaseConfig.initialize();

    // Initialize DI
    await configureDependencies();

    // Register app lifecycle observer
    WidgetsBinding.instance.addObserver(_AppLifecycleObserver());

    // Switch to main app
    runApp(const MyApp());

    // Load data in background AFTER app is running
    _loadBackgroundData();
  } catch (e, stackTrace) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.error_outline, color: Colors.red, size: 48),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Initialization Failed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Error:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                Text(e.toString()),
                const SizedBox(height: 16),
                if (kDebugMode) ...[
                  Text(
                    'Stack Trace:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    stackTrace.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _loadBackgroundData() {
  // Use microtask to avoid blocking
  Future.microtask(() async {
    try {
      // Clean up expired cache entries
      await _cleanupExpiredCache();

      // Start periodic cleanup for video sessions
      getIt<VideoSessionRepository>().startPeriodicCleanup();

      // Load history
      getIt<HistoryCubit>().loadHistory();

      // Small delay between operations
      await Future.delayed(const Duration(milliseconds: 100));

      // Load trending with delay to stagger
      getIt<TrendingMoviesBloc>().add(const LoadTrendingMovies());

      await Future.delayed(const Duration(milliseconds: 100));

      // Load genres last
      getIt<ExploreBloc>().add(const LoadGenres());
    } catch (e) {
      // Silently fail - data will load when screens open
      debugPrint('Background data load error: $e');
    }
  });
}

/// Clean up expired cache entries to prevent storage bloat
Future<void> _cleanupExpiredCache() async {
  try {
    final localDataSource = getIt<MovieLocalDataSource>();
    final deletedCount = await localDataSource.clearExpiredCache();
    if (kDebugMode && deletedCount > 0) {
      debugPrint('🧹 Cleaned up $deletedCount expired cache entries');
    }
  } catch (e) {
    debugPrint('Cache cleanup error: $e');
  }
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // App is closing completely
      try {
        getIt<VideoPlayerService>().dispose();
        getIt<DownloadService>().dispose();
        getIt<CastService>().dispose();
        getIt<VideoSessionRepository>().stopPeriodicCleanup();
      } catch (e) {
        debugPrint('Error disposing services: $e');
      }
    }
  }
}
