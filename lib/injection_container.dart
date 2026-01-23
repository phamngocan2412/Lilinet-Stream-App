import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_client.dart';
import 'core/supabase/supabase_config.dart';
import 'features/movies/data/datasources/movie_remote_datasource.dart';
import 'features/movies/data/datasources/movie_local_datasource.dart'; // Added
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/domain/repositories/movie_repository.dart';
import 'features/movies/domain/usecases/get_trending_movies.dart';
import 'features/movies/domain/usecases/get_cached_trending_movies.dart'; // Added
import 'features/movies/domain/usecases/search_movies.dart';
import 'features/movies/domain/usecases/get_movie_details.dart';
import 'features/movies/domain/usecases/get_streaming_links.dart';
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'features/movies/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'features/movies/presentation/bloc/search/search_bloc.dart';
import 'features/movies/presentation/bloc/streaming/streaming_cubit.dart';

// Explore
import 'features/explore/data/datasources/explore_remote_datasource.dart';
import 'features/explore/data/repositories/explore_repository_impl.dart';
import 'features/explore/domain/repositories/explore_repository.dart';
import 'features/explore/domain/usecases/get_genres.dart';
import 'features/explore/domain/usecases/get_movies_by_genre.dart';
import 'features/explore/domain/usecases/get_movies_by_filter.dart';
import 'features/explore/presentation/bloc/explore_bloc.dart';

// Settings
import 'features/settings/data/datasources/settings_local_datasource.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/get_settings.dart';
import 'features/settings/domain/usecases/save_settings.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

// Auth (NEW)
import 'features/auth/data/datasources/auth_supabase_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_with_email.dart';
import 'features/auth/domain/usecases/sign_up_with_email.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Favorites (NEW)
import 'features/favorites/data/datasources/favorites_supabase_datasource.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/favorites/domain/repositories/favorites_repository.dart';
import 'features/favorites/domain/usecases/add_favorite.dart';
import 'features/favorites/domain/usecases/remove_favorite.dart';
import 'features/favorites/domain/usecases/get_favorites.dart';
import 'features/favorites/domain/usecases/is_favorite.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/video_player/presentation/bloc/video_player_bloc.dart'; // NEW
import 'features/video_player/presentation/bloc/comments/comments_cubit.dart'; // NEW
import 'features/main/presentation/bloc/navigation_cubit.dart'; // Added

import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'hive_registrar.g.dart'; // Import generated registrar
import 'features/movies/data/models/movie_model.dart'; // Import MovieListResponse
import 'features/history/data/datasources/history_local_datasource.dart';
import 'features/history/data/models/watch_progress_model.dart'; // Changed import
import 'features/history/data/datasources/history_local_datasource_impl.dart';
// import 'features/history/data/models/watch_progress_model.dart';
import 'features/history/data/repositories/history_repository_impl.dart';
import 'features/history/domain/repositories/history_repository.dart';
import 'features/history/domain/usecases/delete_watch_progress.dart';
import 'features/history/domain/usecases/get_watch_history.dart';
import 'features/history/domain/usecases/save_watch_progress.dart';
import 'features/history/presentation/bloc/history_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Hive Setup
  await Hive.initFlutter();
  Hive.registerAdapters(); // Replaced individual registrations with generated extension

  final historyBox = await Hive.openBox<WatchProgressModel>('watch_history');
  getIt.registerLazySingleton(() => historyBox);

  final movieCacheBox = await Hive.openBox<MovieListResponse>('movie_cache');
  getIt.registerLazySingleton(() => movieCacheBox);

  // Movie Details Cache Box (NEW)
  final movieDetailsBox = await Hive.openBox<MovieModel>('movie_details_cache');
  getIt.registerLazySingleton(() => movieDetailsBox);

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Supabase Client
  getIt.registerLazySingleton(() => SupabaseConfig.client);

  // Network
  getIt.registerLazySingleton<Dio>(() => NetworkModule.dio);

  // DataSources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSource(getIt(), getIt()),
  );
  getIt.registerLazySingleton<ExploreRemoteDataSource>(
    () => ExploreRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(getIt()),
  );
  getIt.registerLazySingleton<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSource(getIt()),
  );
  getIt.registerLazySingleton<FavoritesSupabaseDataSource>(
    () => FavoritesSupabaseDataSource(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt()),
  );

  // History (Recently Watched)
  getIt.registerLazySingleton<HistoryLocalDataSource>(
    () => HistoryLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetWatchHistory(getIt()));
  getIt.registerLazySingleton(() => SaveWatchProgress(getIt()));
  getIt.registerLazySingleton(() => DeleteWatchProgress(getIt()));
  getIt.registerLazySingleton(
    () => HistoryBloc(
      getWatchHistory: getIt(),
      saveWatchProgress: getIt(),
      deleteWatchProgress: getIt(),
    ),
  );

  // UseCases - Movies
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => GetCachedTrendingMovies(getIt())); // Added
  getIt.registerLazySingleton(() => SearchMovies(getIt()));
  getIt.registerLazySingleton(() => GetMovieDetails(getIt()));
  getIt.registerLazySingleton(() => GetStreamingLinks(getIt()));

  // UseCases - Explore
  getIt.registerLazySingleton(() => GetGenres(getIt()));
  getIt.registerLazySingleton(() => GetMoviesByGenre(getIt()));
  getIt.registerLazySingleton(() => GetMoviesByFilter(getIt()));

  // UseCases - Settings
  getIt.registerLazySingleton(() => GetSettings(getIt()));
  getIt.registerLazySingleton(() => SaveSettings(getIt()));

  // UseCases - Auth
  getIt.registerLazySingleton(() => SignInWithEmail(getIt()));
  getIt.registerLazySingleton(() => SignUpWithEmail(getIt()));
  getIt.registerLazySingleton(() => SignOut(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));

  // UseCases - Favorites
  getIt.registerLazySingleton(() => AddFavorite(getIt()));
  getIt.registerLazySingleton(() => RemoveFavorite(getIt()));
  getIt.registerLazySingleton(() => GetFavorites(getIt()));
  getIt.registerLazySingleton(() => IsFavorite(getIt()));

  // Blocs
  getIt.registerLazySingleton(
    () => TrendingMoviesBloc(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(() => MovieDetailsBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => SearchBloc(getIt()));
  getIt.registerFactory(() => StreamingCubit(getIt()));
  getIt.registerLazySingleton(
    () => ExploreBloc(
      getGenres: getIt(),
      getMoviesByGenre: getIt(),
      repository: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SettingsBloc(
      getSettings: getIt(),
      saveSettings: getIt(),
      repository: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AuthBloc(
      signInWithEmail: getIt(),
      signUpWithEmail: getIt(),
      signOut: getIt(),
      getCurrentUser: getIt(),
      authRepository: getIt(),
    ),
  );
  getIt.registerFactory(
    () => FavoritesBloc(
      addFavoriteUseCase: getIt(),
      removeFavoriteUseCase: getIt(),
      getFavoritesUseCase: getIt(),
    ),
  );
  // Video Player
  getIt.registerLazySingleton<VideoPlayerBloc>(() => VideoPlayerBloc());
  getIt.registerLazySingleton<CommentsCubit>(() => CommentsCubit());

  // Navigation
  getIt.registerFactory(() => NavigationCubit());
}
