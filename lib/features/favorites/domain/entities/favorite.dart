import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;
  final String userId;
  final String movieId;
  final String? movieTitle;
  final String? moviePoster;
  final String? movieType;
  final DateTime createdAt;

  const Favorite({
    required this.id,
    required this.userId,
    required this.movieId,
    this.movieTitle,
    this.moviePoster,
    this.movieType,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        movieId,
        movieTitle,
        moviePoster,
        movieType,
        createdAt,
      ];
}
