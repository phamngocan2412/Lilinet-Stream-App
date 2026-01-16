import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final String movieId;
  final String? movieTitle;
  final String? moviePoster;
  final String? movieType;

  const AddFavoriteEvent({
    required this.movieId,
    this.movieTitle,
    this.moviePoster,
    this.movieType,
  });

  @override
  List<Object?> get props => [movieId, movieTitle, moviePoster, movieType];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final String movieId;

  const RemoveFavoriteEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class ClearFavorites extends FavoritesEvent {
  @override
  List<Object?> get props => [];
}

class CheckFavoriteStatus extends FavoritesEvent {
  final String movieId;

  const CheckFavoriteStatus(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
