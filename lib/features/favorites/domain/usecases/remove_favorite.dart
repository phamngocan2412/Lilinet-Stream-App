import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> call(String movieId) async {
    return await repository.removeFavorite(movieId);
  }
}
