import 'package:equatable/equatable.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/entities/genre.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class GenresLoaded extends ExploreState {
  final List<Genre> genres;

  const GenresLoaded(this.genres);

  @override
  List<Object?> get props => [genres];
}

class MoviesLoaded extends ExploreState {
  final List<Movie> movies;
  final String category;
  final int currentPage;
  final bool hasMore;

  const MoviesLoaded({
    required this.movies,
    required this.category,
    this.currentPage = 1,
    this.hasMore = true,
  });

  MoviesLoaded copyWith({
    List<Movie>? movies,
    String? category,
    int? currentPage,
    bool? hasMore,
  }) {
    return MoviesLoaded(
      movies: movies ?? this.movies,
      category: category ?? this.category,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [movies, category, currentPage, hasMore];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object?> get props => [message];
}
