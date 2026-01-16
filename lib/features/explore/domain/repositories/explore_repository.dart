import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../movies/domain/entities/movie.dart';
import '../entities/genre.dart';
import '../entities/filter_options.dart';

abstract class ExploreRepository {
  Future<Either<Failure, List<Genre>>> getGenres();
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(
    String genreId, {
    int page = 1,
  });
  Future<Either<Failure, List<Movie>>> getMoviesByFilter(
    FilterOptions options, {
    int page = 1,
  });
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1});
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1});
  Future<Either<Failure, List<Movie>>> getRecentlyAdded({int page = 1});
}
