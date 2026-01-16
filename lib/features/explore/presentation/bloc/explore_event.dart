import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

class LoadGenres extends ExploreEvent {}

class LoadMoviesByGenre extends ExploreEvent {
  final String genreId;
  final String genreName;
  final int page;

  const LoadMoviesByGenre({
    required this.genreId,
    required this.genreName,
    this.page = 1,
  });

  @override
  List<Object?> get props => [genreId, genreName, page];
}

class LoadPopularMovies extends ExploreEvent {
  final int page;

  const LoadPopularMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadTopRatedMovies extends ExploreEvent {
  final int page;

  const LoadTopRatedMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadRecentlyAdded extends ExploreEvent {
  final int page;

  const LoadRecentlyAdded({this.page = 1});

  @override
  List<Object?> get props => [page];
}
