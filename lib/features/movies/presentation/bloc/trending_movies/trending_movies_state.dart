import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object> get props => [];
}

class TrendingMoviesInitial extends TrendingMoviesState {}

class TrendingMoviesLoading extends TrendingMoviesState {}

class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;

  const TrendingMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  const TrendingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
