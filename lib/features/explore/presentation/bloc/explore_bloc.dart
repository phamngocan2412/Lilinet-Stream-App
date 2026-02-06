import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lilinet_app/core/errors/failures.dart';
import 'package:lilinet_app/features/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_genres.dart';
import '../../domain/usecases/get_movies_by_genre.dart';
import '../../domain/repositories/explore_repository.dart';
import 'explore_event.dart';
import 'explore_state.dart';

@lazySingleton
class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetGenres getGenres;
  final GetMoviesByGenre getMoviesByGenre;
  final ExploreRepository repository;

  // Memory Optimization: Limit total results to ~400 items (20 pages)
  static const int _maxMoviesCount = 400;

  ExploreBloc({
    required this.getGenres,
    required this.getMoviesByGenre,
    required this.repository,
  }) : super(const ExploreInitial()) {
    on<LoadGenres>(_onLoadGenres);
    on<LoadMoviesByGenre>(_onLoadMoviesByGenre);
    on<LoadPopularMovies>(_onLoadPopularMovies);
    on<LoadTopRatedMovies>(_onLoadTopRatedMovies);
    on<LoadRecentlyAdded>(_onLoadRecentlyAdded);
  }

  @override
  Future<void> close() {
    // Ensure all resources are disposed
    return super.close();
  }

  Future<void> _onLoadGenres(
    LoadGenres event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreState.loading());
    final result = await getGenres();
    result.fold(
      (failure) => emit(ExploreState.error(message: failure.message)),
      (genres) => emit(ExploreState.genresLoaded(genres: genres)),
    );
  }

  Future<void> _onLoadMoviesByGenre(
    LoadMoviesByGenre event,
    Emitter<ExploreState> emit,
  ) async {
    await _loadMovies(
      emit,
      page: event.page,
      category: event.genreName,
      loader: () => getMoviesByGenre(genreId: event.genreId, page: event.page),
    );
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<ExploreState> emit,
  ) async {
    await _loadMovies(
      emit,
      page: event.page,
      category: 'Popular',
      loader: () => repository.getPopularMovies(page: event.page),
    );
  }

  Future<void> _onLoadTopRatedMovies(
    LoadTopRatedMovies event,
    Emitter<ExploreState> emit,
  ) async {
    await _loadMovies(
      emit,
      page: event.page,
      category: 'Top Rated',
      loader: () => repository.getTopRatedMovies(page: event.page),
    );
  }

  Future<void> _onLoadRecentlyAdded(
    LoadRecentlyAdded event,
    Emitter<ExploreState> emit,
  ) async {
    await _loadMovies(
      emit,
      page: event.page,
      category: 'Recently Added',
      loader: () => repository.getRecentlyAdded(page: event.page),
    );
  }

  Future<void> _loadMovies(
    Emitter<ExploreState> emit, {
    required int page,
    required String category,
    required Future<Either<Failure, List<Movie>>> Function() loader,
  }) async {
    if (page == 1) {
      emit(const ExploreState.loading());
    } else {
      // Check for memory limit
      final currentState = state.mapOrNull(moviesLoaded: (s) => s);
      if (currentState != null && currentState.movies.length >= _maxMoviesCount) {
        emit(currentState.copyWithMore(hasMore: false));
        return;
      }
    }

    final result = await loader();

    result.fold(
      (failure) => emit(ExploreState.error(message: failure.message)),
      (movies) {
        final currentState = state.mapOrNull(moviesLoaded: (s) => s);

        // If it's a new category/page 1, just emit the new list
        if (page == 1 || currentState == null) {
          emit(
            ExploreState.moviesLoaded(
              movies: movies,
              category: category,
              currentPage: page,
              hasMore: movies.isNotEmpty,
            ),
          );
        } else {
          // It's a load more, append
          emit(
            currentState.copyWithMore(
              movies: [...currentState.movies, ...movies],
              currentPage: page,
              hasMore: movies.isNotEmpty,
            ),
          );
        }
      },
    );
  }
}
