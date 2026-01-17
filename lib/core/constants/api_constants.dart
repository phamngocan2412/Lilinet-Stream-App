class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  // TMDB
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String tmdbOriginalImage = '$tmdbImageBaseUrl/original';
  static const String tmdbW500Image = '$tmdbImageBaseUrl/w500';

  // Endpoints
  static const String trendingMovies = '/meta/tmdb/trending';
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
