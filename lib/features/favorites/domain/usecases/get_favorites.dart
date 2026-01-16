import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/favorite.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Favorite>>> call() async {
    return await repository.getFavorites();
  }
}
