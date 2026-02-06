import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/favorite.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Favorite>>> getFavorites({int page = 1, int limit = 20});

  Future<Either<Failure, Favorite>> addFavorite({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
    String folder = 'Default',
  });

  Future<Either<Failure, void>> removeFavorite(String movieId);

  Future<Either<Failure, bool>> isFavorite(String movieId);
}
