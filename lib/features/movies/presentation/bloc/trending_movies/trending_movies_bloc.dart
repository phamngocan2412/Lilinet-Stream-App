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

    // 1. Try Cache First
    try {
      final cached = _getCachedTrendingMovies();
      if (cached != null && cached.isNotEmpty) {
        emit(TrendingMoviesState.loaded(trending: cached));
      }
    } catch (_) {
      // Ignore cache errors
    }

    // 2. Load Trending First (Most Important)
    final trendingResult = await _getTrendingMovies(
      TrendingParams(type: event.type, page: 1),
    );

    List<Movie> trendingMovies = [];
    trendingResult.fold(
      (failure) {},
      (movies) => trendingMovies = movies,
    );

    // Show trending immediately
    if (trendingMovies.isNotEmpty) {
      emit(TrendingMoviesState.loaded(trending: trendingMovies));
    }

    // 3. Load Categories Staggered (don't block UI)
    Map<String, List<Movie>> categories = {};

    // Load categories in parallel but emit updates gradually
    await Future.wait([
      _loadCategory('Top Anime', '16', categories),
      _loadCategory('Action Movies', '28', categories),
      _loadCategory('Horror', '27', categories),
      _loadCategory('Romance', '10749', categories),
    ]);

    if (trendingMovies.isEmpty && categories.isEmpty) {
      final isLoaded = state.maybeMap(loaded: (_) => true, orElse: () => false);

      if (!isLoaded) {
        String message = 'Failed to load content';
        trendingResult.fold((f) => message = f.message, (_) {});
        emit(TrendingMoviesState.error(message));
      }
    } else {
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

  Future<void> _loadCategory(
    String name,
    String genreId,
    Map<String, List<Movie>> categories,
  ) async {
    final result = await _getMoviesByGenre(genreId: genreId, page: 1);
    result.fold(
      (_) {},
      (movies) => categories[name] = movies,
    );
  }

  Future<void> _onRefresh(
    RefreshTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    add(const TrendingMoviesEvent.load());
  }
}
