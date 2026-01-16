import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/episode.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  final int selectedSeason;
  final List<Episode> filteredEpisodes;

  const MovieDetailsLoaded(
    this.movie, {
    this.selectedSeason = 1,
    this.filteredEpisodes = const [],
  });

  @override
  List<Object> get props => [movie, selectedSeason, filteredEpisodes];

  MovieDetailsLoaded copyWith({
    Movie? movie,
    int? selectedSeason,
    List<Episode>? filteredEpisodes,
  }) {
    return MovieDetailsLoaded(
      movie ?? this.movie,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      filteredEpisodes: filteredEpisodes ?? this.filteredEpisodes,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  const MovieDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
