import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import '../../../domain/usecases/get_cached_trending_movies.dart';
import '../../../../explore/domain/usecases/get_movies_by_genre.dart'; // Import
import '../../../../movies/domain/entities/movie.dart'; // Import Movie
import 'trending_movies_event.dart';
import 'trending_movies_state.dart';

@injectable
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies _getTrendingMovies;
  final GetCachedTrendingMovies _getCachedTrendingMovies;
  final GetMoviesByGenre _getMoviesByGenre; // Add this

  TrendingMoviesBloc(
    this._getTrendingMovies,
    this._getCachedTrendingMovies,
    this._getMoviesByGenre, // Add this
  ) : super(TrendingMoviesInitial()) {
    on<LoadTrendingMovies>(_onLoadTrendingMovies);
    on<RefreshTrendingMovies>(_onRefreshTrendingMovies);
  }

  Future<void> _onLoadTrendingMovies(
    LoadTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(TrendingMoviesLoading());

    // 1. Try Cache First (Only for trending for now, or expand cache later)
    final cachedMovies = _getCachedTrendingMovies();
    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      emit(TrendingMoviesLoaded(trending: cachedMovies));
    }

    // 2. Fetch All Data in Parallel
    // We fetch Trending + 4 Categories
    final results = await Future.wait([
      _getTrendingMovies(type: event.type, page: 1), // Index 0: Trending
      _getMoviesByGenre(genreId: '16', page: 1), // Index 1: Anime
      _getMoviesByGenre(genreId: '28', page: 1), // Index 2: Action
      _getMoviesByGenre(genreId: '27', page: 1), // Index 3: Horror
      _getMoviesByGenre(genreId: '10749', page: 1), // Index 4: Romance
    ]);

    final trendingResult = results[0];
    final animeResult = results[1];
    final actionResult = results[2];
    final horrorResult = results[3];
    final romanceResult = results[4];

    List<Movie> trendingMovies = [];
    Map<String, List<Movie>> categories = {};

    // Process Trending
    trendingResult.fold((failure) {
      // If trending fails and we have no cache, that's an issue.
      // But if we have cache, we might survive.
    }, (movies) => trendingMovies = movies);

    // Process Categories (If one fails, we just don't show it)
    animeResult.fold((_) {}, (movies) => categories['Top Anime'] = movies);
    actionResult.fold((_) {}, (movies) => categories['Action Movies'] = movies);
    horrorResult.fold((_) {}, (movies) => categories['Horror'] = movies);
    romanceResult.fold((_) {}, (movies) => categories['Romance'] = movies);

    if (trendingMovies.isEmpty && categories.isEmpty) {
      if (state is! TrendingMoviesLoaded) {
        emit(const TrendingMoviesError('Failed to load content'));
      }
    } else {
      emit(
        TrendingMoviesLoaded(
          trending: trendingMovies.isNotEmpty
              ? trendingMovies
              : (state is TrendingMoviesLoaded
                    ? (state as TrendingMoviesLoaded).trending
                    : []),
          categories: categories,
        ),
      );
    }
  }

  Future<void> _onRefreshTrendingMovies(
    RefreshTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    // Re-trigger load
    add(const LoadTrendingMovies());
  }
}
