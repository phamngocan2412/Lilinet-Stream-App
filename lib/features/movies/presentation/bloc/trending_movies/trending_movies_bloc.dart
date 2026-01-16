import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import '../../../domain/usecases/get_cached_trending_movies.dart'; // Added
import 'trending_movies_event.dart';
import 'trending_movies_state.dart';

@injectable
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies _getTrendingMovies;
  final GetCachedTrendingMovies _getCachedTrendingMovies; // Added

  TrendingMoviesBloc(this._getTrendingMovies, this._getCachedTrendingMovies)
      : super(TrendingMoviesInitial()) {
    on<LoadTrendingMovies>(_onLoadTrendingMovies);
    on<RefreshTrendingMovies>(_onRefreshTrendingMovies);
  }

  Future<void> _onLoadTrendingMovies(
    LoadTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    // 1. Emit Loading
    emit(TrendingMoviesLoading());

    // 2. Try Cache First
    final cachedMovies = _getCachedTrendingMovies();
    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      emit(TrendingMoviesLoaded(cachedMovies));
    }

    // 3. Then Fetch Network
    final result = await _getTrendingMovies(type: event.type, page: 1);

    result.fold(
      (failure) {
        // If we have cache, don't show error screen, just toast?
        // Or keep showing cache.
        if (state is! TrendingMoviesLoaded) {
          emit(TrendingMoviesError(failure.message));
        } else {
          // Ideally emit a "LoadedButNetworkError" state or similar,
          // but for now, just keep the cached data visible.
          // Or we can just log the error.
        }
      },
      (movies) => emit(TrendingMoviesLoaded(movies)),
    );
  }

  Future<void> _onRefreshTrendingMovies(
    RefreshTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    // Refresh usually skips cache reading and goes straight to network
    final result = await _getTrendingMovies(type: 'all', page: 1);

    result.fold(
      (failure) => emit(TrendingMoviesError(failure.message)),
      (movies) => emit(TrendingMoviesLoaded(movies)),
    );
  }
}
