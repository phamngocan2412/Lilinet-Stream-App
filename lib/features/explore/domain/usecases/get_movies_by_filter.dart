import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../movies/domain/entities/movie.dart';
import '../entities/filter_options.dart';
import '../repositories/explore_repository.dart';

@lazySingleton
class GetMoviesByFilter {
  final ExploreRepository repository;

  GetMoviesByFilter(this.repository);

  Future<Either<Failure, List<Movie>>> call({
    required FilterOptions options,
    int page = 1,
  }) async {
    return await repository.getMoviesByFilter(options, page: page);
  }
}
