import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetTrendingMovies {
  final MovieRepository _repository;

  GetTrendingMovies(this._repository);

  Future<Either<Failure, List<Movie>>> call({
    String type = 'all',
    int page = 1,
  }) async {
    return await _repository.getTrendingMovies(type: type, page: page);
  }
}
