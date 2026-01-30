import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class SearchMovies {
  final MovieRepository _repository;

  SearchMovies(this._repository);

  Future<Either<Failure, List<Movie>>> call(
    String query, {
    int page = 1,
  }) async {
    if (query.isEmpty) {
      return const Left(Failure.server('Query cannot be empty'));
    }
    return await _repository.searchMovies(query, page: page);
  }
}
