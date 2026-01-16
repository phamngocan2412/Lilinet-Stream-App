import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import for compute
import 'package:injectable/injectable.dart';
import '../models/movie_model.dart';
import '../models/streaming_link_model.dart';
import '../../../../core/constants/api_constants.dart';

// Top-level function for compute
MovieModel _parseMovieModel(Map<String, dynamic> json) {
  return MovieModel.fromJson(json);
}

@lazySingleton
class MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSource(this._dio);

  Future<MovieListResponse> getTrendingMovies({
    String type = 'all',
    String timePeriod = 'week',
    int page = 1,
  }) async {
    final response = await _dio.get(
      ApiConstants.trendingMovies,
      queryParameters: {'type': type, 'timePeriod': timePeriod, 'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieListResponse> searchMovies(String query, {int page = 1}) async {
    final encodedQuery = Uri.encodeComponent(query);
    final response = await _dio.get(
      '${ApiConstants.searchMovies}/$encodedQuery',
      queryParameters: {'page': page},
    );
    return MovieListResponse.fromJson(response.data);
  }

  Future<MovieModel> getMovieDetails(
    String id, {
    required String type,
    bool fastMode = false,
  }) async {
    // Extract numeric TMDB ID if the ID contains provider path
    // e.g., "tv/watch-jujutsu-kaisen-66956" -> "66956"
    final cleanId = _extractTmdbId(id);

    final queryParams = {'type': type};
    if (fastMode) {
      queryParams['fast'] = 'true';
    } else {
      // Use Goku for faster scraping (user preference)
      queryParams['provider'] = 'goku';
    }

    final response = await _dio.get(
      '${ApiConstants.movieInfo}/$cleanId',
      queryParameters: queryParams,
    );

    // Use compute to parse JSON in background isolate
    // Casting response.data to Map<String, dynamic> is needed
    return await compute(
      _parseMovieModel,
      response.data as Map<String, dynamic>,
    );
  }

  /// Extracts numeric TMDB ID from provider ID or returns the ID as-is
  /// Examples:
  /// - "tv/watch-jujutsu-kaisen-66956" -> "66956"
  /// - "movie/watch-the-matrix-603" -> "603"
  /// - "watch-jujutsu-kaisen-95479" -> "95479"
  /// - "95479" -> "95479"
  String _extractTmdbId(String id) {
    // Check if ID contains hyphens (provider ID pattern)
    if (id.contains('-')) {
      // Extract the numeric part after the last hyphen
      final parts = id.split('-');
      if (parts.isNotEmpty) {
        final lastPart = parts.last;
        // Check if it's numeric
        if (int.tryParse(lastPart) != null) {
          return lastPart;
        }
      }
    }
    // Return as-is if it's already numeric or doesn't match expected pattern
    return id;
  }

  Future<StreamingResponseModel> getStreamingLinks({
    required String episodeId,
    required String mediaId,
    String? server,
  }) async {
    final response = await _dio.get(
      ApiConstants.watch,
      queryParameters: {
        'episodeId': episodeId,
        'mediaId': mediaId,
        'server': server,
      },
    );
    return StreamingResponseModel.fromJson(response.data);
  }
}
