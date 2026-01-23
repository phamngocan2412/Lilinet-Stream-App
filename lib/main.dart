import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'core/supabase/supabase_config.dart';
import 'app.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'features/explore/presentation/bloc/explore_bloc.dart';
import 'features/explore/presentation/bloc/explore_event.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize MediaKit
    MediaKit.ensureInitialized();

    // Initialize Supabase
    await SupabaseConfig.initialize();

    // Initialize Dependency Injection
    await configureDependencies();

    // Load Watch History
    getIt<HistoryBloc>().loadHistory();

    // Trigger Initial Data Loads
    getIt<TrendingMoviesBloc>().add(const LoadTrendingMovies());
    getIt<ExploreBloc>().add(LoadGenres());

    runApp(const MyApp());
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
                Text(
                  'Stack Trace:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  stackTrace.toString(),
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
