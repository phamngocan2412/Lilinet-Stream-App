import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../movies/domain/entities/movie.dart';
import '../repositories/explore_repository.dart';

@lazySingleton
class GetMoviesByGenre {
  final ExploreRepository repository;

  GetMoviesByGenre(this.repository);

  Future<Either<Failure, List<Movie>>> call({
    required String genreId,
    int page = 1,
  }) async {
    return await repository.getMoviesByGenre(genreId, page: page);
  }
}
