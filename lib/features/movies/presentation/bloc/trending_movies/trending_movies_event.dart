import 'package:equatable/equatable.dart';

abstract class TrendingMoviesEvent extends Equatable {
  const TrendingMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadTrendingMovies extends TrendingMoviesEvent {
  final String type;

  const LoadTrendingMovies({this.type = 'tv'});

  @override
  List<Object> get props => [type];
}

class RefreshTrendingMovies extends TrendingMoviesEvent {
  const RefreshTrendingMovies();
}
