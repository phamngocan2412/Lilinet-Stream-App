import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/favorite.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Favorite>>> getFavorites();

  Future<Either<Failure, Favorite>> addFavorite({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
  });

  Future<Either<Failure, void>> removeFavorite(String movieId);

  Future<Either<Failure, bool>> isFavorite(String movieId);
}
