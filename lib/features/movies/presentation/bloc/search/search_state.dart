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

  const SearchState({
    this.query = '',
    this.movies = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasMore = true,
  });

  SearchState copyWith({
    String? query,
    List<Movie>? movies,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
  }) {
    return SearchState(
      query: query ?? this.query,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
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
      ];
}
