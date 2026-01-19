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
}
