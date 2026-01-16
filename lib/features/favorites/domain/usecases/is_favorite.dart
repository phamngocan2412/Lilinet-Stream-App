import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class IsFavorite {
  final FavoritesRepository repository;

  IsFavorite(this.repository);

  Future<Either<Failure, bool>> call(String movieId) async {
    return await repository.isFavorite(movieId);
  }
}
