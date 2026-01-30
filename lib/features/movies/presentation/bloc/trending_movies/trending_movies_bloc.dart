import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import '../../../domain/usecases/get_cached_trending_movies.dart';
import '../../../../explore/domain/usecases/get_movies_by_genre.dart';
import '../../../../movies/domain/entities/movie.dart';
import 'trending_movies_event.dart';
import 'trending_movies_state.dart';

@lazySingleton
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies _getTrendingMovies;
  final GetCachedTrendingMovies _getCachedTrendingMovies;
  final GetMoviesByGenre _getMoviesByGenre;

  TrendingMoviesBloc(
    this._getTrendingMovies,
    this._getCachedTrendingMovies,
    this._getMoviesByGenre,
  ) : super(const TrendingMoviesState.initial()) {
    on<LoadTrendingMovies>(_onLoad);
    on<RefreshTrendingMovies>(_onRefresh);
  }

  Future<void> _onLoad(
    LoadTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(const TrendingMoviesState.loading());

    // 1. Try Cache First (Sync if possible, but UseCases are usually async or sync)
    // GetCachedTrendingMovies is synchronous in previous implementation?
    // Let's check. Yes, it returns List<Movie>?.
    try {
      final cached = _getCachedTrendingMovies();
      if (cached != null && cached.isNotEmpty) {
        emit(TrendingMoviesState.loaded(trending: cached));
      }
    } catch (_) {
      // Ignore cache errors
    }

    // 2. Fetch All Data in Parallel
    final results = await Future.wait([
      _getTrendingMovies(TrendingParams(type: event.type, page: 1)),
      _getMoviesByGenre(genreId: '16', page: 1), // Index 1: Anime
      _getMoviesByGenre(genreId: '28', page: 1), // Index 2: Action
      _getMoviesByGenre(genreId: '27', page: 1), // Index 3: Horror
      _getMoviesByGenre(genreId: '10749', page: 1), // Index 4: Romance
    ]);

    final trendingResult = results[0]; // Either<Failure, List<Movie>>
    final animeResult = results[1];
    final actionResult = results[2];
    final horrorResult = results[3];
    final romanceResult = results[4];

    List<Movie> trendingMovies = [];
    Map<String, List<Movie>> categories = {};

    // Process Trending
    // We need to cast because Future.wait returns List<dynamic> or common ancestor
    // Actually results[0] is Either<Failure, List<Movie>>

    (trendingResult as dynamic).fold(
      (failure) {},
      (movies) => trendingMovies = movies,
    );

    // Process Categories
    (animeResult as dynamic).fold(
      (_) {},
      (movies) => categories['Top Anime'] = movies,
    );
    (actionResult as dynamic).fold(
      (_) {},
      (movies) => categories['Action Movies'] = movies,
    );
    (horrorResult as dynamic).fold(
      (_) {},
      (movies) => categories['Horror'] = movies,
    );
    (romanceResult as dynamic).fold(
      (_) {},
      (movies) => categories['Romance'] = movies,
    );

    if (trendingMovies.isEmpty && categories.isEmpty) {
      final isLoaded = state.maybeMap(loaded: (_) => true, orElse: () => false);

      if (!isLoaded) {
        // If we are not already showing data (from cache), show error
        // Assuming results[0] failure message is relevant
        String message = 'Failed to load content';
        (trendingResult as dynamic).fold((f) => message = f.message, (_) {});
        emit(TrendingMoviesState.error(message));
      }
    } else {
      // Merge with existing state if needed, or just emit new
      // If we emitted Cached data earlier, this will replace it with fresh data.
      emit(
        TrendingMoviesState.loaded(
          trending: trendingMovies.isNotEmpty
              ? trendingMovies
              : (state.mapOrNull(loaded: (s) => s.trending) ?? []),
          categories: categories,
        ),
      );
    }
  }

  Future<void> _onRefresh(
    RefreshTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    add(const TrendingMoviesEvent.load());
  }
}
