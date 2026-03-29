import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl {
    // 1. Try build time environment
    String url = const String.fromEnvironment('API_BASE_URL');

    // 2. Try runtime .env
    if (url.isEmpty) {
      url = dotenv.env['API_BASE_URL'] ?? 'http://localhost:7030';
    }

    // 3. Platform specific fix for Android Emulator
    if (!kIsWeb && Platform.isAndroid) {
      if (url.contains('localhost') ||
          url.contains('127.0.0.1') ||
          url.contains('0.0.0.0')) {
        return url
            .replaceAll('localhost', '10.0.2.2')
            .replaceAll('127.0.0.1', '10.0.2.2')
            .replaceAll('0.0.0.0', '10.0.2.2');
      }
    }

    // 4. Fix 0.0.0.0 for other platforms (iOS/Web) to localhost
    if (url.contains('0.0.0.0')) {
      return url.replaceAll('0.0.0.0', 'localhost');
    }

    return url;
  }

  // TMDB
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String tmdbOriginalImage = '$tmdbImageBaseUrl/original';
  static const String tmdbW500Image = '$tmdbImageBaseUrl/w500';

  // Endpoints
  // Endpoints
  // Endpoints
  static const String trendingMovies = '/meta/tmdb/trending';
  static const String popularMovies = '/meta/tmdb/popular';
  static const String topRatedMovies = '/meta/tmdb/top-rated';
  static const String searchMovies = '/meta/tmdb';
  static const String movieInfo = '/meta/tmdb/info';

  // Dynamic Endpoints (Should be constructed with selected provider)
  // Updated to support both movies and anime paths
  static String getInfoEndpoint(String category, String provider) =>
      '/$category/$provider/info';
  static String getWatchEndpoint(String category, String provider) =>
      '/$category/$provider/watch';
  static String getServersEndpoint(String category, String provider) =>
      '/$category/$provider/servers';

  // Legacy (Keep for fallback if needed, defaults to goku)
  static const String flixhqInfo = '/movies/goku/info';
  static const String watch = '/movies/goku/watch';
  static const String servers = '/movies/goku/servers';

  // Timeouts
  static const int connectionTimeout = 60000;
  static const int receiveTimeout = 60000;
}
