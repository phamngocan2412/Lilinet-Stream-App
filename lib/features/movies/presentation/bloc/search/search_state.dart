import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

class SearchState extends Equatable {
  final String query;
  final List<Movie> movies;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final int currentPage;
  final bool hasMore;
  final String activeFilter; // 'All', 'TV Series', 'Movie'

  const SearchState({
    this.query = '',
    this.movies = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.activeFilter = 'All',
  });

  SearchState copyWith({
    String? query,
    List<Movie>? movies,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    String? activeFilter,
  }) {
    return SearchState(
      query: query ?? this.query,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  List<Object> get props => [
        query,
        movies,
        isLoading,
        hasError,
        errorMessage,
        currentPage,
        hasMore,
        activeFilter,
      ];
}
