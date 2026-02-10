import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../explore/domain/utils/movie_sorter.dart';
import '../../../domain/usecases/search_movies.dart';
import '../../../../explore/domain/entities/filter_options.dart';
import '../../../domain/entities/movie.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(const SearchState()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<SearchLoadMore>(_onSearchLoadMore);
    on<SearchCleared>(_onSearchCleared);
    on<SearchFilterChanged>(_onSearchFilterChanged);
    on<SearchOptionsChanged>(_onSearchOptionsChanged);
  }

  @override
  Future<void> close() {
    // Ensure all resources are disposed
    return super.close();
  }

  void _onSearchFilterChanged(
    SearchFilterChanged event,
    Emitter<SearchState> emit,
  ) {
    // Legacy filter: update MediaType in filterOptions
    MediaType mediaType;
    switch (event.filter) {
      case 'TV Series':
        mediaType = MediaType.tvSeries;
        break;
      case 'Movie':
        mediaType = MediaType.movie;
        break;
      default:
        mediaType = MediaType.all;
    }

    final newOptions = state.filterOptions.copyWith(mediaType: mediaType);
    final filtered = _applyFilters(state.rawMovies, newOptions);

    emit(state.copyWith(
      activeFilter: event.filter,
      filterOptions: newOptions,
      movies: filtered,
    ));
  }

  void _onSearchOptionsChanged(
    SearchOptionsChanged event,
    Emitter<SearchState> emit,
  ) {
    // Update activeFilter string based on mediaType for UI consistency
    String activeFilter = 'All';
    if (event.options.mediaType == MediaType.tvSeries) {
      activeFilter = 'TV Series';
    }
    if (event.options.mediaType == MediaType.movie) {
      activeFilter = 'Movie';
    }

    final filtered = _applyFilters(state.rawMovies, event.options);

    emit(state.copyWith(
      filterOptions: event.options,
      activeFilter: activeFilter,
      movies: filtered,
    ));
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(
      state.copyWith(
        query: event.query,
        isLoading: true,
        currentPage: 1,
        movies: [],
        rawMovies: [],
      ),
    );

    final result = await _searchMovies(event.query, page: 1);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.message,
        ),
      ),
      (movies) {
        final filtered = _applyFilters(movies, state.filterOptions);
        emit(
          state.copyWith(
            isLoading: false,
            rawMovies: movies,
            movies: filtered,
            hasError: false,
            hasMore: movies.length >= 20,
          ),
        );
      },
    );
  }

  Future<void> _onSearchLoadMore(
    SearchLoadMore event,
    Emitter<SearchState> emit,
  ) async {
    if (!state.hasMore || state.isLoading) return;

    // Memory Optimization: Limit total results to ~400 items (20 pages)
    if (state.rawMovies.length >= 400) {
      emit(state.copyWith(hasMore: false));
      return;
    }

    final nextPage = state.currentPage + 1;
    emit(state.copyWith(isLoading: true));

    final result = await _searchMovies(state.query, page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.message,
        ),
      ),
      (newMovies) {
        final allRaw = [...state.rawMovies, ...newMovies];
        final filtered = _applyFilters(allRaw, state.filterOptions);

        emit(
          state.copyWith(
            isLoading: false,
            rawMovies: allRaw,
            movies: filtered,
            currentPage: nextPage,
            hasMore: newMovies.length >= 20,
          ),
        );
      },
    );
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }

  List<Movie> _applyFilters(List<Movie> movies, FilterOptions options) {
    Iterable<Movie> result = movies;

    // 1. Media Type
    if (options.mediaType != MediaType.all) {
      result = result.where((m) {
        final type = m.type.toLowerCase();
        if (options.mediaType == MediaType.movie) {
          return type == 'movie';
        } else {
          return type.contains('tv') || type.contains('series');
        }
      });
    }

    // 2. Min Rating
    if (options.minRating != null && options.minRating! > 0) {
      result = result.where((m) => (m.rating ?? 0) >= options.minRating!);
    }

    // Convert to list only once at the end
    var filteredList = result.toList();

    // 3. Sorting (in-place)
    if (filteredList.isNotEmpty) {
      MovieSorter.sort(filteredList, options.sortBy);
    }

    return filteredList;
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
