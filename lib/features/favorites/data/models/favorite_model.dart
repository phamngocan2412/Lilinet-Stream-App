import '../../domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel({
    required super.id,
    required super.userId,
    required super.movieId,
    super.movieTitle,
    super.moviePoster,
    super.movieType,
    required super.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'].toString(),
      userId: json['user_id'] as String,
      movieId: json['movie_id'] as String,
      movieTitle: json['movie_title'] as String?,
      moviePoster: json['movie_poster'] as String?,
      movieType: json['movie_type'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'movie_title': movieTitle,
      'movie_poster': moviePoster,
      'movie_type': movieType,
    };
  }

  Favorite toEntity() {
    return Favorite(
      id: id,
      userId: userId,
      movieId: movieId,
      movieTitle: movieTitle,
      moviePoster: moviePoster,
      movieType: movieType,
      createdAt: createdAt,
    );
  }
}
