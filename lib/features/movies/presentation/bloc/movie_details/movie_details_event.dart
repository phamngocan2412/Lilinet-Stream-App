import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetails extends MovieDetailsEvent {
  final String id;
  final String type;

  const LoadMovieDetails({required this.id, required this.type});

  @override
  List<Object> get props => [id, type];
}

class SetMovieDetails extends MovieDetailsEvent {
  final Movie movie;

  const SetMovieDetails(this.movie);

  @override
  List<Object> get props => [movie];
}

class SelectSeason extends MovieDetailsEvent {
  final int seasonNumber;

  const SelectSeason(this.seasonNumber);

  @override
  List<Object> get props => [seasonNumber];
}
