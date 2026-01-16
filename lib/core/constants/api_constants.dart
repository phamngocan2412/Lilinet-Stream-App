class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://novel-liline.onrender.com',
  );

  // TMDB
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String tmdbOriginalImage = '$tmdbImageBaseUrl/original';
  static const String tmdbW500Image = '$tmdbImageBaseUrl/w500';

  // Endpoints
  static const String trendingMovies = '/meta/tmdb/trending';
  static const String searchMovies = '/meta/tmdb';
  static const String movieInfo = '/meta/tmdb/info';
  static const String flixhqInfo = '/movies/goku/info'; // Changed to goku
  static const String watch = '/movies/goku/watch'; // Changed to goku
  static const String servers = '/movies/goku/servers'; // Changed to goku

  // Timeouts
  static const int connectionTimeout = 60000;
  static const int receiveTimeout = 60000;
}
