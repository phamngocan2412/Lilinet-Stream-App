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

MovieListResponse _parseMovieList(Map<String, dynamic> json) {
  return MovieListResponse.fromJson(json);
}

@lazySingleton
class MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSource(this._dio);

  Future<MovieListResponse> getTrendingMovies({int page = 1}) async {
    debugPrint('Fetching trending via TMDB... Page: $page');
    debugPrint(
      'Requesting URL: ${ApiConstants.trendingMovies} with params: page=$page',
    );

    final response = await _dio.get(
      ApiConstants.trendingMovies,
      queryParameters: {'page': page},
    );

    // Null safety check
    if (response.data == null) {
      throw Exception(
        'TMDB trending API returned null data. Status: ${response.statusCode}, Data: ${response.data}',
      );
    }

    return await compute(
      _parseMovieList,
      response.data as Map<String, dynamic>,
    );
  }

  Future<MovieListResponse> searchMovies(String query, {int page = 1}) async {
    debugPrint('Searching for: $query via TMDB');

    final encodedQuery = Uri.encodeComponent(query);
    final response = await _dio.get(
      '${ApiConstants.searchMovies}/$encodedQuery',
      queryParameters: {'page': page},
    );

    // Null safety check
    if (response.data == null) {
      throw Exception('TMDB search API returned null data');
    }

    return await compute(
      _parseMovieList,
      response.data as Map<String, dynamic>,
    );
  }

  Future<MovieModel> getMovieDetails(
    String id, {
    String? provider,
    String? type,
  }) async {
    debugPrint('Getting details for ID: $id via TMDB (Type: $type)');

    final queryParams = <String, dynamic>{};
    if (provider != null) {
      queryParams['provider'] = provider;
    }
    if (type != null) {
      queryParams['type'] = type;
    }

    final response = await _dio.get(
      '${ApiConstants.movieInfo}/$id',
      queryParameters: queryParams,
    );

    if (response.data == null) {
      throw Exception('API returned null data');
    }

    final model = await compute(
      _parseMovieModel,
      response.data as Map<String, dynamic>,
    );

    return model.copyWith(provider: provider ?? 'animekai');
  }

  Future<StreamingResponseModel> getStreamingLinks({
    required String episodeId,
    required String mediaId,
    String? server,
    String provider = 'animekai', // Default to animekai
  }) async {
    // Determine category based on provider known list
    final animeProviders = [
      'animekai',
      'gogoanime',
      'animesaturn',
      'animeunity',
    ];
    final isAnime = animeProviders.contains(provider.toLowerCase());
    final category = isAnime ? 'anime' : 'movies';

    // Anime providers use path param: /watch/:episodeId
    // Movie providers use query param: /watch?episodeId=xxx&mediaId=xxx
    if (isAnime) {
      final response = await _dio.get(
        '/$category/$provider/watch/${Uri.encodeComponent(episodeId)}',
        queryParameters: {if (server != null) 'server': server},
      );
      return StreamingResponseModel.fromJson(response.data);
    } else {
      final response = await _dio.get(
        ApiConstants.getWatchEndpoint(category, provider),
        queryParameters: {
          'episodeId': episodeId,
          'mediaId': mediaId,
          'server': server,
        },
      );
      return StreamingResponseModel.fromJson(response.data);
    }
  }
}
