import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/streaming_response.dart';
import '../../domain/entities/subtitle.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../datasources/movie_local_datasource.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies({
    String type = 'all',
    int page = 1,
  }) async {
    // 1. Try to load from Cache first (only for first page)
    if (page == 1) {
      try {
        final cached = _localDataSource.getCachedTrendingMovies();
        if (cached != null) {
          // Return cached data immediately if needed?
          // But Repository usually returns Future.
          // We can't return Stream here easily without changing domain.
          // For "Cache-First", we usually return the cached data if network fails OR
          // we use a Bloc that emits Cache then Network.
          // However, to keep it simple and safe:
          // We can return cached data if we have it, and let Bloc decide?
          // Actually, the request is "Load from Hive first -> Show UI -> Call API -> Update".
          // This requires the Bloc to handle "emit cached, then emit network".
          // BUT, Repository just returns one result.
          // So we should let the Bloc access the cache? No, that breaks Clean Arch.
          //
          // Better approach:
          // Return Cached data if available.
          // The Bloc will call "LoadTrendingMovies" which calls this.
          // If we return Cached, the Bloc emits Loaded.
          // Then we need a way to refresh.
          //
          // Wait, if I return cached data here, the Bloc will stop loading.
          // I need to trigger the network call too.
          //
          // Alternative: The Bloc calls a separate method for cache?
          // Or we use Stream<Either<Failure, List<Movie>>>?
          //
          // Simplest "Cache-First" implementation within current constraints:
          // 1. In Repository:
          //    - Check network.
          //    - If network success -> Save to cache -> Return data.
          //    - If network fail -> Return cache (offline mode).
          //
          // BUT the user wants "Show UI immediately".
          // So the UI needs the cached data *before* the network call finishes.
          //
          // So the Bloc should:
          // 1. Helper method `_loadCache()`
          // 2. Helper method `_loadNetwork()`
          //
          // So I need to expose `getCachedTrendingMovies` in the Repository interface?
          // Yes.
        }
      } catch (e) {
        // Ignore cache errors
      }
    }

    try {
      final response = await _remoteDataSource.getTrendingMovies(
        type: type,
        page: page,
      );
      // Save to cache (only first page)
      if (page == 1) {
        _localDataSource.cacheTrendingMovies(response);
      }
      final movies = response.results.map((m) => m.toEntity()).toList();
      return Right(movies);
    } on DioException catch (e) {
      // If network fails, try to return cache as fallback
      if (page == 1) {
        final cached = _localDataSource.getCachedTrendingMovies();
        if (cached != null) {
          return Right(cached.results.map((m) => m.toEntity()).toList());
        }
      }
      return Left(_handleDioError(e));
    } catch (e) {
      // If network fails, try to return cache as fallback
      if (page == 1) {
        final cached = _localDataSource.getCachedTrendingMovies();
        if (cached != null) {
          return Right(cached.results.map((m) => m.toEntity()).toList());
        }
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  // New method to expose cache explicitly for "Cache-First" UI
  @override
  List<Movie>? getCachedTrendingMovies() {
    final cached = _localDataSource.getCachedTrendingMovies();
    return cached?.results.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
    String query, {
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.searchMovies(query, page: page);
      final movies = response.results.map((m) => m.toEntity()).toList();
      return Right(movies);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Movie? getCachedMovieDetails(String id) {
    final cachedModel = _localDataSource.getCachedMovieDetails(id);
    return cachedModel?.toEntity();
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(
    String id,
    String type, {
    bool fastMode = false,
  }) async {
    try {
      // Fetch from API
      final model = await _remoteDataSource.getMovieDetails(
        id,
        type: type,
        fastMode: fastMode,
      );

      // Only cache if it's full data (not fast mode)
      if (!fastMode) {
        await _localDataSource.cacheMovieDetails(id, model);
      }

      return Right(model.toEntity());
    } on DioException catch (e) {
      // If network fails, return cached data if available
      final cachedModel = _localDataSource.getCachedMovieDetails(id);
      if (cachedModel != null) {
        return Right(cachedModel.toEntity());
      }
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamingResponse>> getStreamingLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'himovies', // Default provider
  }) async {
    try {
      final response = await _remoteDataSource.getStreamingLinks(
        episodeId: episodeId,
        mediaId: mediaId,
        server: server,
        provider: provider,
      );
      final links = response.sources.map((s) => s.toEntity()).toList();

      // Only parse English subtitle to save time
      final subtitles = <Subtitle>[];
      if (response.subtitles != null) {
        try {
          final englishSubModel = response.subtitles!.firstWhere(
            (s) => s.lang.toLowerCase().contains('english'),
          );
          subtitles.add(
            Subtitle(url: englishSubModel.url, lang: englishSubModel.lang),
          );
        } catch (_) {
          // No English subtitle found
        }
      }

      return Right(StreamingResponse(links: links, subtitles: subtitles));
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
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        // Backend wraps upstream 404 as 500 with specific message
        if (statusCode == 500 && data is Map) {
          final message = data['message']?.toString() ?? '';
          if (message == 'Request failed with status code 404' ||
              message.contains('Cannot read properties of undefined')) {
            return const ServerFailure(
              'This content is unavailable or corrupted.',
            );
          }
        }

        if (statusCode == 404) {
          return const ServerFailure('Resource not found');
        } else if (statusCode == 500) {
          return const ServerFailure('Server error');
        }
        return ServerFailure('Error: ${error.response?.statusMessage}');
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
