import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';
import '../../../../explore/domain/entities/filter_options.dart';

class SearchState extends Equatable {
  final String query;
  final List<Movie> movies; // Filtered/Sorted movies
  final List<Movie> rawMovies; // Original API results
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final int currentPage;
  final bool hasMore;
  final String
  activeFilter; // 'All', 'TV Series', 'Movie' (Legacy simple filter)
  final FilterOptions filterOptions;

  const SearchState({
    this.query = '',
    this.movies = const [],
    this.rawMovies = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.activeFilter = 'All',
    this.filterOptions = const FilterOptions(),
  });

  SearchState copyWith({
    String? query,
    List<Movie>? movies,
    List<Movie>? rawMovies,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    String? activeFilter,
    FilterOptions? filterOptions,
  }) {
    return SearchState(
      query: query ?? this.query,
      movies: movies ?? this.movies,
      rawMovies: rawMovies ?? this.rawMovies,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      activeFilter: activeFilter ?? this.activeFilter,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }

  @override
  List<Object> get props => [
    query,
    movies,
    rawMovies,
    isLoading,
    hasError,
    errorMessage,
    currentPage,
    hasMore,
    activeFilter,
    filterOptions,
  ];
}
