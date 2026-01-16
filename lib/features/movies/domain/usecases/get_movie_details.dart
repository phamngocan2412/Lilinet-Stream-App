import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetMovieDetails {
  final MovieRepository _repository;

  GetMovieDetails(this._repository);

  Future<Either<Failure, Movie>> call(
    String id,
    String type, {
    bool fastMode = false,
  }) async {
    return await _repository.getMovieDetails(id, type, fastMode: fastMode);
  }
}
