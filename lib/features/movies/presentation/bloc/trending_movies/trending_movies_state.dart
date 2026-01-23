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
  final List<Movie> trending;
  final Map<String, List<Movie>> categories;

  const TrendingMoviesLoaded({
    required this.trending,
    this.categories = const {},
  });

  @override
  List<Object> get props => [trending, categories];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  const TrendingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
