import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/repository_extensions.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/entities/filter_options.dart';
import '../../domain/entities/genre.dart';
import '../../domain/repositories/explore_repository.dart';
import '../../domain/utils/movie_sorter.dart';
import '../datasources/explore_remote_datasource.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource remoteDataSource;

  ExploreRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    return safeCall(() async {
      final genres = await remoteDataSource.getGenres();
      return genres.map((g) => g.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(
    String genreId, {
    int page = 1,
  }) async {
    return safeCall(() async {
      final response = await remoteDataSource.getMoviesByGenre(
        genreId,
        page: page,
      );
      return response.results.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByFilter(
    FilterOptions options, {
    int page = 1,
  }) async {
    return safeCall(() async {
      String type = 'tv';
      if (options.mediaType == MediaType.movie) {
        type = 'movie';
      } else if (options.mediaType == MediaType.tvSeries) {
        type = 'tv';
      }

      final response = await remoteDataSource.getMoviesByType(type, page: page);
      var movies = response.results.map((m) => m.toEntity()).toList();

      // Client-side filtering
      if (options.minRating != null) {
        movies = movies
            .where((m) => m.rating != null && m.rating! >= options.minRating!)
            .toList();
      }

      if (options.yearFrom != null || options.yearTo != null) {
        movies = movies.where((m) {
          if (m.releaseDate == null) return false;
          final year = int.tryParse(m.releaseDate!.split('-').first);
          if (year == null) return false;

          if (options.yearFrom != null && year < options.yearFrom!) {
            return false;
          }
          if (options.yearTo != null && year > options.yearTo!) {
            return false;
          }
          return true;
        }).toList();
      }

      // Sorting
      MovieSorter.sort(movies, options.sortBy);

      return movies;
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) async {
    return safeCall(() async {
      final response = await remoteDataSource.getPopularMovies(page: page);
      return response.results.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) async {
    return safeCall(() async {
      final response = await remoteDataSource.getTopRatedMovies(page: page);
      return response.results.map((m) => m.toEntity()).toList();
    });
  }

  /// We use popular movies sorted by release date for "Recently Added"
  /// as a reasonable approximation until a dedicated endpoint exists.
  @override
  Future<Either<Failure, List<Movie>>> getRecentlyAdded({int page = 1}) async {
    return safeCall(() async {
      final response = await remoteDataSource.getPopularMovies(page: page);
      var movies = response.results.map((m) => m.toEntity()).toList();

      // Sort by release date
      MovieSorter.sort(movies, SortBy.releaseDate);

      return movies;
    });
  }
}
