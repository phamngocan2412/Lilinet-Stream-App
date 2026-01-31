import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'core/supabase/supabase_config.dart';
import 'app.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'features/explore/presentation/bloc/explore_bloc.dart';
import 'features/explore/presentation/bloc/explore_event.dart';
import 'injection_container.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

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
}

class SplashApp extends StatelessWidget {
  const SplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF101010),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo or icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFC6A664),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'LILINET',
                style: TextStyle(
                  color: Color(0xFFC6A664),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC6A664)),
                ),
              ),
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
                        fontSize: 12, fontFamily: 'monospace'),
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
      // Load history
      getIt<HistoryBloc>().loadHistory();

      // Small delay between operations
      await Future.delayed(const Duration(milliseconds: 100));

      // Load trending with delay to stagger
      getIt<TrendingMoviesBloc>().add(const LoadTrendingMovies());

      await Future.delayed(const Duration(milliseconds: 100));

      // Load genres last
      getIt<ExploreBloc>().add(LoadGenres());
    } catch (e) {
      // Silently fail - data will load when screens open
      debugPrint('Background data load error: $e');
    }
  });
}
