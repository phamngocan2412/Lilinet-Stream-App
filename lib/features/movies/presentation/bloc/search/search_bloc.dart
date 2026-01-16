import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/usecases/search_movies.dart';
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
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(state.copyWith(
      query: event.query,
      isLoading: true,
      currentPage: 1,
      movies: [], // Clear previous results
    ));

    final result = await _searchMovies(event.query, page: 1);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: failure.message,
      )),
      (movies) => emit(state.copyWith(
        isLoading: false,
        movies: movies,
        hasError: false,
        hasMore: movies.length >= 20,
      )),
    );
  }

  Future<void> _onSearchLoadMore(
    SearchLoadMore event,
    Emitter<SearchState> emit,
  ) async {
    if (!state.hasMore || state.isLoading) return;

    final nextPage = state.currentPage + 1;
    emit(state.copyWith(isLoading: true));

    final result = await _searchMovies(state.query, page: nextPage);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: failure.message,
      )),
      (movies) => emit(state.copyWith(
        isLoading: false,
        movies: [...state.movies, ...movies],
        currentPage: nextPage,
        hasMore: movies.length >= 20,
      )),
    );
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
