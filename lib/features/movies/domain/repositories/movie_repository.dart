import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie.dart';
import '../entities/streaming_response.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getTrendingMovies({
    String type = 'all',
    int page = 1,
  });

  List<Movie>? getCachedTrendingMovies();

  Future<Either<Failure, List<Movie>>> searchMovies(
    String query, {
    int page = 1,
  });

  Future<Either<Failure, Movie>> getMovieDetails(
    String id, {
    String? provider,
    String? type,
    bool fastMode = false,
  });

  // Get cached movie details (instant, no network)
  Movie? getCachedMovieDetails(String id);

  Future<Either<Failure, StreamingResponse>> getStreamingLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai',
  });

  /// Get available servers for a specific episode
  Future<Either<Failure, List<String>>> getAvailableServers({
    required String episodeId,
    required String mediaId,
    String provider = 'flixhq',
  });
}
