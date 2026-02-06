import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class AddFavorite {
  final FavoritesRepository repository;

  AddFavorite(this.repository);

  Future<Either<Failure, Favorite>> call({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
    String folder = 'Default',
  }) async {
    return await repository.addFavorite(
      movieId: movieId,
      movieTitle: movieTitle,
      moviePoster: moviePoster,
      movieType: movieType,
      folder: folder,
    );
  }
}
