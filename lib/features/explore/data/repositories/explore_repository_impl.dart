import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/entities/filter_options.dart';
import '../../domain/entities/genre.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_remote_datasource.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource remoteDataSource;

  ExploreRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    try {
      final genres = await remoteDataSource.getGenres();
      return Right(genres.map((g) => g.toEntity()).toList());
    } catch (e) {
      return const Left(ServerFailure('Failed to load genres'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(
    String genreId, {
    int page = 1,
  }) async {
    try {
      final response = await remoteDataSource.getMoviesByGenre(
        genreId,
        page: page,
      );
      final movies = response.results.map((m) => m.toEntity()).toList();

      // Note: Client-side filtering by genre would go here if needed
      // For now, returning all results
      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByFilter(
    FilterOptions options, {
    int page = 1,
  }) async {
    try {
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
      switch (options.sortBy) {
        case SortBy.rating:
          movies.sort((a, b) {
            if (a.rating == null) return 1;
            if (b.rating == null) return -1;
            return b.rating!.compareTo(a.rating!);
          });
          break;
        case SortBy.title:
          movies.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortBy.releaseDate:
          movies.sort((a, b) {
            if (a.releaseDate == null) return 1;
            if (b.releaseDate == null) return -1;
            return b.releaseDate!.compareTo(a.releaseDate!);
          });
          break;
        case SortBy.popularity:
          // Already sorted by popularity from API
          break;
      }

      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) async {
    try {
      final response = await remoteDataSource.getPopularMovies(page: page);
      final movies = response.results.map((m) => m.toEntity()).toList();
      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await remoteDataSource.getPopularMovies(page: page);
      var movies = response.results.map((m) => m.toEntity()).toList();

      // Sort by rating
      movies.sort((a, b) {
        if (a.rating == null) return 1;
        if (b.rating == null) return -1;
        return b.rating!.compareTo(a.rating!);
      });

      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getRecentlyAdded({int page = 1}) async {
    try {
      final response = await remoteDataSource.getPopularMovies(page: page);
      var movies = response.results.map((m) => m.toEntity()).toList();

      // Sort by release date
      movies.sort((a, b) {
        if (a.releaseDate == null) return 1;
        if (b.releaseDate == null) return -1;
        return b.releaseDate!.compareTo(a.releaseDate!);
      });

      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return const ServerFailure('Server error');
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.unknown:
        if (error.error.toString().contains('SocketException')) {
          return const NetworkFailure('No internet connection');
        }
        return const NetworkFailure('Unexpected error');
      default:
        return const NetworkFailure('Network error');
    }
  }
}
