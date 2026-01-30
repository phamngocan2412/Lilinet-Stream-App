import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/repository_extensions.dart';
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
    // Try to load from Cache first (only for first page) - Optional optimization
    if (page == 1) {
      final cached = _localDataSource.getCachedTrendingMovies();
      if (cached != null && cached.results.isNotEmpty) {
        // We can choose to return cache immediately here if we want "Offline First"
        // But the pattern requested is "Cache then Network" or "Network with Cache Fallback"
        // The safeCall below handles the network.

        // If we want to background refresh, we would return cache here and trigger network.
        // But Repository returns Future<Either>. It can only return ONCE.

        // Strategy: The Repository is just a data provider.
        // The safeCall will handle the network request.
        // We just ensure we cache the RESULT of safeCall.
      }
    }

    return safeCall(() async {
      final response = await _remoteDataSource.getTrendingMovies(page: page);
      final movies = response.results.map((m) => m.toEntity()).toList();

      if (page == 1) {
        _localDataSource.cacheTrendingMovies(response);
      }

      return movies;
    });
  }

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
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Movie? getCachedMovieDetails(String id) {
    final cachedModel = _localDataSource.getCachedMovieDetails(id);
    return cachedModel?.toEntity();
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(
    String id, {
    String? provider,
    String? type,
    bool fastMode = false,
  }) async {
    try {
      // Fetch from API
      final movieModel = await _remoteDataSource.getMovieDetails(
        id,
        provider: provider,
        type: type,
      );

      // Only cache if it's full data (not fast mode)
      if (!fastMode) {
        await _localDataSource.cacheMovieDetails(id, movieModel);
      }

      return Right(movieModel.toEntity());
    } on DioException catch (e) {
      // If network fails, return cached data if available
      final cachedModel = _localDataSource.getCachedMovieDetails(id);
      if (cachedModel != null) {
        return Right(cachedModel.toEntity());
      }
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamingResponse>> getStreamingLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai', // Default provider
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
      return Left(Failure.server(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        // Backend wraps upstream 404 as 500 with specific message
        if (statusCode == 500 && data is Map) {
          final message = data['message']?.toString() ?? '';
          if (message == 'Request failed with status code 404' ||
              message.contains('Cannot read properties of undefined')) {
            return const Failure.server(
              'This content is unavailable or corrupted.',
            );
          }
        }

        if (statusCode == 404) {
          return const Failure.server('Resource not found');
        } else if (statusCode == 500) {
          return const Failure.server('Server error');
        }
        return Failure.server('Error: ${error.response?.statusMessage}');
      case DioExceptionType.cancel:
        return const Failure.network('Request cancelled');
      case DioExceptionType.unknown:
        if (error.error.toString().contains('SocketException')) {
          return const Failure.network('No internet connection');
        }
        return const Failure.network('Unexpected error');
      default:
        return const Failure.network('Network error');
    }
  }
}
