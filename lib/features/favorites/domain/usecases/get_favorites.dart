import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Favorite>>> call({int page = 1, int limit = 20}) async {
    return await repository.getFavorites(page: page, limit: limit);
  }
}
