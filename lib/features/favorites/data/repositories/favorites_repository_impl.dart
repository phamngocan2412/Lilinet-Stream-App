import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_supabase_datasource.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesSupabaseDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites({int page = 1, int limit = 20}) async {
    try {
      final favorites = await dataSource.getFavorites(page: page, limit: limit);
      return Right(favorites.map((f) => f.toEntity()).toList());
    } catch (e) {
      return Left(Failure.server('Failed to get favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Favorite>> addFavorite({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
    String folder = 'Default',
  }) async {
    try {
      final favorite = await dataSource.addFavorite(
        movieId: movieId,
        movieTitle: movieTitle,
        moviePoster: moviePoster,
        movieType: movieType,
        folder: folder,
      );
      return Right(favorite.toEntity());
    } catch (e) {
      return Left(Failure.server('Failed to add favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String movieId) async {
    try {
      await dataSource.removeFavorite(movieId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server('Failed to remove favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String movieId) async {
    try {
      final result = await dataSource.isFavorite(movieId);
      return Right(result);
    } catch (e) {
      return Left(Failure.server('Failed to check favorite: ${e.toString()}'));
    }
  }
}
