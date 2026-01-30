// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce/hive_ce.dart' as _i1055;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import 'features/auth/data/datasources/auth_supabase_datasource.dart' as _i647;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/get_current_user.dart' as _i191;
import 'features/auth/domain/usecases/sign_in_with_email.dart' as _i509;
import 'features/auth/domain/usecases/sign_out.dart' as _i872;
import 'features/auth/domain/usecases/sign_up_with_email.dart' as _i784;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/comments/data/datasources/comment_remote_datasource.dart'
    as _i799;
import 'features/comments/data/datasources/local_comment_datasource.dart'
    as _i665;
import 'features/comments/data/repositories/comment_repository_impl.dart'
    as _i674;
import 'features/comments/domain/repositories/comment_repository.dart' as _i876;
import 'features/comments/domain/usecases/add_comment.dart' as _i802;
import 'features/comments/domain/usecases/get_comments.dart' as _i90;
import 'features/comments/domain/usecases/get_replies.dart' as _i412;
import 'features/comments/domain/usecases/like_comment.dart' as _i137;
import 'features/comments/presentation/manager/comment_cubit.dart' as _i886;
import 'features/comments/presentation/widgets/home_trending_section.dart'
    as _i226;
import 'features/explore/data/datasources/explore_remote_datasource.dart'
    as _i726;
import 'features/explore/data/repositories/explore_repository_impl.dart'
    as _i942;
import 'features/explore/domain/repositories/explore_repository.dart' as _i30;
import 'features/explore/domain/usecases/get_genres.dart' as _i233;
import 'features/explore/domain/usecases/get_movies_by_filter.dart' as _i877;
import 'features/explore/domain/usecases/get_movies_by_genre.dart' as _i109;
import 'features/explore/presentation/bloc/explore_bloc.dart' as _i10;
import 'features/favorites/data/datasources/favorites_supabase_datasource.dart'
    as _i230;
import 'features/favorites/data/repositories/favorites_repository_impl.dart'
    as _i764;
import 'features/favorites/domain/repositories/favorites_repository.dart'
    as _i320;
import 'features/favorites/domain/usecases/add_favorite.dart' as _i332;
import 'features/favorites/domain/usecases/get_favorites.dart' as _i879;
import 'features/favorites/domain/usecases/is_favorite.dart' as _i8;
import 'features/favorites/domain/usecases/remove_favorite.dart' as _i907;
import 'features/favorites/presentation/bloc/favorites_bloc.dart' as _i906;
import 'features/history/data/datasources/history_local_datasource.dart'
    as _i612;
import 'features/history/data/datasources/history_local_datasource_impl.dart'
    as _i714;
import 'features/history/data/models/watch_progress_model.dart' as _i422;
import 'features/history/data/repositories/history_repository_impl.dart'
    as _i1064;
import 'features/history/domain/repositories/history_repository.dart' as _i190;
import 'features/history/domain/usecases/delete_watch_progress.dart' as _i806;
import 'features/history/domain/usecases/get_watch_history.dart' as _i890;
import 'features/history/domain/usecases/save_watch_progress.dart' as _i603;
import 'features/history/presentation/bloc/history_bloc.dart' as _i618;
import 'features/main/presentation/bloc/navigation_cubit.dart' as _i821;
import 'features/movies/data/datasources/movie_local_datasource.dart' as _i123;
import 'features/movies/data/datasources/movie_remote_datasource.dart' as _i47;
import 'features/movies/data/models/movie_model.dart' as _i892;
import 'features/movies/data/repositories/movie_repository_impl.dart' as _i981;
import 'features/movies/domain/repositories/movie_repository.dart' as _i961;
import 'features/movies/domain/usecases/get_cached_trending_movies.dart'
    as _i442;
import 'features/movies/domain/usecases/get_movie_details.dart' as _i1004;
import 'features/movies/domain/usecases/get_streaming_links.dart' as _i9;
import 'features/movies/domain/usecases/get_trending_movies.dart' as _i716;
import 'features/movies/domain/usecases/search_movies.dart' as _i82;
import 'features/movies/presentation/bloc/movie_details/movie_details_bloc.dart'
    as _i974;
import 'features/movies/presentation/bloc/search/search_bloc.dart' as _i730;
import 'features/movies/presentation/bloc/streaming/streaming_cubit.dart'
    as _i1072;
import 'features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart'
    as _i547;
import 'features/settings/data/datasources/settings_local_datasource.dart'
    as _i387;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i113;
import 'features/settings/domain/repositories/settings_repository.dart'
    as _i309;
import 'features/settings/domain/usecases/get_settings.dart' as _i709;
import 'features/settings/domain/usecases/save_settings.dart' as _i156;
import 'features/settings/presentation/bloc/settings_bloc.dart' as _i421;
import 'features/video_player/presentation/bloc/comments/comments_cubit.dart'
    as _i148;
import 'features/video_player/presentation/bloc/video_player_bloc.dart'
    as _i692;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i821.NavigationCubit>(() => _i821.NavigationCubit());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    await gh.factoryAsync<_i965.Box<_i422.WatchProgressModel>>(
      () => registerModule.watchHistoryBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i965.Box<_i892.MovieListResponse>>(
      () => registerModule.movieCacheBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i965.Box<_i892.MovieModel>>(
      () => registerModule.movieDetailsBox,
      preResolve: true,
    );
    gh.singleton<_i148.CommentsCubit>(() => _i148.CommentsCubit());
    gh.lazySingleton<_i692.VideoPlayerBloc>(() => _i692.VideoPlayerBloc());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i123.MovieLocalDataSource>(
      () => _i123.MovieLocalDataSource(
        gh<_i738.Box<_i892.MovieListResponse>>(),
        gh<_i738.Box<_i892.MovieModel>>(),
      ),
    );
    gh.lazySingleton<_i665.LocalCommentDataSource>(
      () => _i665.LocalCommentDataSourceImpl(),
    );
    gh.lazySingleton<_i230.FavoritesSupabaseDataSource>(
      () => _i230.FavoritesSupabaseDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i647.AuthSupabaseDataSource>(
      () => _i647.AuthSupabaseDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i47.MovieRemoteDataSource>(
      () => _i47.MovieRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i799.CommentRemoteDataSource>(
      () => _i799.SupabaseCommentDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i612.HistoryLocalDataSource>(
      () => _i714.HistoryLocalDataSourceImpl(
        gh<_i1055.Box<_i422.WatchProgressModel>>(),
      ),
    );
    gh.lazySingleton<_i961.MovieRepository>(
      () => _i981.MovieRepositoryImpl(
        gh<_i47.MovieRemoteDataSource>(),
        gh<_i123.MovieLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i387.SettingsLocalDataSource>(
      () => _i387.SettingsLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i320.FavoritesRepository>(
      () => _i764.FavoritesRepositoryImpl(
        gh<_i230.FavoritesSupabaseDataSource>(),
      ),
    );
    gh.lazySingleton<_i876.CommentRepository>(
      () => _i674.CommentRepositoryImpl(
        gh<_i799.CommentRemoteDataSource>(),
        gh<_i665.LocalCommentDataSource>(),
      ),
    );
    gh.lazySingleton<_i726.ExploreRemoteDataSource>(
      () => _i726.ExploreRemoteDataSource(gh<_i47.MovieRemoteDataSource>()),
    );
    gh.lazySingleton<_i1015.AuthRepository>(
      () => _i111.AuthRepositoryImpl(gh<_i647.AuthSupabaseDataSource>()),
    );
    gh.lazySingleton<_i190.HistoryRepository>(
      () => _i1064.HistoryRepositoryImpl(gh<_i612.HistoryLocalDataSource>()),
    );
    gh.factory<_i90.GetComments>(
      () => _i90.GetComments(gh<_i876.CommentRepository>()),
    );
    gh.factory<_i802.AddComment>(
      () => _i802.AddComment(gh<_i876.CommentRepository>()),
    );
    gh.factory<_i137.LikeComment>(
      () => _i137.LikeComment(gh<_i876.CommentRepository>()),
    );
    gh.factory<_i412.GetReplies>(
      () => _i412.GetReplies(gh<_i876.CommentRepository>()),
    );
    gh.factory<_i226.HomeTrendingCubit>(
      () => _i226.HomeTrendingCubit(gh<_i876.CommentRepository>()),
    );
    gh.lazySingleton<_i309.SettingsRepository>(
      () => _i113.SettingsRepositoryImpl(gh<_i387.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i442.GetCachedTrendingMovies>(
      () => _i442.GetCachedTrendingMovies(gh<_i961.MovieRepository>()),
    );
    gh.factory<_i716.GetTrendingMovies>(
      () => _i716.GetTrendingMovies(gh<_i961.MovieRepository>()),
    );
    gh.factory<_i1004.GetMovieDetails>(
      () => _i1004.GetMovieDetails(gh<_i961.MovieRepository>()),
    );
    gh.factory<_i9.GetStreamingLinks>(
      () => _i9.GetStreamingLinks(gh<_i961.MovieRepository>()),
    );
    gh.factory<_i82.SearchMovies>(
      () => _i82.SearchMovies(gh<_i961.MovieRepository>()),
    );
    gh.lazySingleton<_i709.GetSettings>(
      () => _i709.GetSettings(gh<_i309.SettingsRepository>()),
    );
    gh.lazySingleton<_i156.SaveSettings>(
      () => _i156.SaveSettings(gh<_i309.SettingsRepository>()),
    );
    gh.factory<_i421.SettingsBloc>(
      () => _i421.SettingsBloc(
        getSettings: gh<_i709.GetSettings>(),
        saveSettings: gh<_i156.SaveSettings>(),
        repository: gh<_i309.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i509.SignInWithEmail>(
      () => _i509.SignInWithEmail(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i784.SignUpWithEmail>(
      () => _i784.SignUpWithEmail(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i872.SignOut>(
      () => _i872.SignOut(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i191.GetCurrentUser>(
      () => _i191.GetCurrentUser(gh<_i1015.AuthRepository>()),
    );
    gh.factory<_i603.SaveWatchProgress>(
      () => _i603.SaveWatchProgress(gh<_i190.HistoryRepository>()),
    );
    gh.factory<_i890.GetWatchHistory>(
      () => _i890.GetWatchHistory(gh<_i190.HistoryRepository>()),
    );
    gh.factory<_i806.DeleteWatchProgress>(
      () => _i806.DeleteWatchProgress(gh<_i190.HistoryRepository>()),
    );
    gh.factory<_i1072.StreamingCubit>(
      () => _i1072.StreamingCubit(gh<_i9.GetStreamingLinks>()),
    );
    gh.factory<_i730.SearchBloc>(
      () => _i730.SearchBloc(gh<_i82.SearchMovies>()),
    );
    gh.lazySingleton<_i332.AddFavorite>(
      () => _i332.AddFavorite(gh<_i320.FavoritesRepository>()),
    );
    gh.lazySingleton<_i907.RemoveFavorite>(
      () => _i907.RemoveFavorite(gh<_i320.FavoritesRepository>()),
    );
    gh.lazySingleton<_i879.GetFavorites>(
      () => _i879.GetFavorites(gh<_i320.FavoritesRepository>()),
    );
    gh.lazySingleton<_i8.IsFavorite>(
      () => _i8.IsFavorite(gh<_i320.FavoritesRepository>()),
    );
    gh.factory<_i363.AuthBloc>(
      () => _i363.AuthBloc(
        signInWithEmail: gh<_i509.SignInWithEmail>(),
        signUpWithEmail: gh<_i784.SignUpWithEmail>(),
        signOut: gh<_i872.SignOut>(),
        getCurrentUser: gh<_i191.GetCurrentUser>(),
        authRepository: gh<_i1015.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i30.ExploreRepository>(
      () => _i942.ExploreRepositoryImpl(gh<_i726.ExploreRemoteDataSource>()),
    );
    gh.factory<_i886.CommentCubit>(
      () => _i886.CommentCubit(
        gh<_i90.GetComments>(),
        gh<_i802.AddComment>(),
        gh<_i137.LikeComment>(),
        gh<_i412.GetReplies>(),
      ),
    );
    gh.lazySingleton<_i618.HistoryBloc>(
      () => _i618.HistoryBloc(
        getWatchHistory: gh<_i890.GetWatchHistory>(),
        saveWatchProgress: gh<_i603.SaveWatchProgress>(),
        deleteWatchProgress: gh<_i806.DeleteWatchProgress>(),
      ),
    );
    gh.factory<_i974.MovieDetailsBloc>(
      () => _i974.MovieDetailsBloc(
        gh<_i1004.GetMovieDetails>(),
        gh<_i961.MovieRepository>(),
        gh<_i309.SettingsRepository>(),
      ),
    );
    gh.factory<_i906.FavoritesBloc>(
      () => _i906.FavoritesBloc(
        addFavoriteUseCase: gh<_i332.AddFavorite>(),
        removeFavoriteUseCase: gh<_i907.RemoveFavorite>(),
        getFavoritesUseCase: gh<_i879.GetFavorites>(),
      ),
    );
    gh.lazySingleton<_i233.GetGenres>(
      () => _i233.GetGenres(gh<_i30.ExploreRepository>()),
    );
    gh.lazySingleton<_i109.GetMoviesByGenre>(
      () => _i109.GetMoviesByGenre(gh<_i30.ExploreRepository>()),
    );
    gh.lazySingleton<_i877.GetMoviesByFilter>(
      () => _i877.GetMoviesByFilter(gh<_i30.ExploreRepository>()),
    );
    gh.lazySingleton<_i547.TrendingMoviesBloc>(
      () => _i547.TrendingMoviesBloc(
        gh<_i716.GetTrendingMovies>(),
        gh<_i442.GetCachedTrendingMovies>(),
        gh<_i109.GetMoviesByGenre>(),
      ),
    );
    gh.lazySingleton<_i10.ExploreBloc>(
      () => _i10.ExploreBloc(
        getGenres: gh<_i233.GetGenres>(),
        getMoviesByGenre: gh<_i109.GetMoviesByGenre>(),
        repository: gh<_i30.ExploreRepository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i809.RegisterModule {}
