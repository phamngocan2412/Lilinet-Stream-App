import 'package:hive_ce/hive_ce.dart';
import 'package:injectable/injectable.dart';
import '../models/movie_model.dart';

/// Local data source for movie data with TTL (Time To Live) support
///
/// Cache entries expire after [defaultTtlDays] days (default: 7 days)
@lazySingleton
class MovieLocalDataSource {
  final Box<MovieListResponse> _movieCacheBox;
  final Box<MovieModel> _movieDetailsBox;
  final Box<DateTime> _cacheTimestampBox;

  /// Default TTL in days
  static const int defaultTtlDays = 7;

  MovieLocalDataSource(
    this._movieCacheBox,
    this._movieDetailsBox,
    this._cacheTimestampBox,
  );

  // Trending movies cache with TTL
  Future<void> cacheTrendingMovies(MovieListResponse response) async {
    await _movieCacheBox.put('trending_movies', response);
    await _cacheTimestampBox.put('trending_movies', DateTime.now());
  }

  MovieListResponse? getCachedTrendingMovies() {
    final cached = _movieCacheBox.get('trending_movies');
    if (cached == null) return null;

    // Check TTL
    final timestamp = _cacheTimestampBox.get('trending_movies');
    if (timestamp != null && _isExpired(timestamp)) {
      // Expired - clear and return null
      _movieCacheBox.delete('trending_movies');
      _cacheTimestampBox.delete('trending_movies');
      return null;
    }

    return cached;
  }

  // Movie details cache with TTL
  Future<void> cacheMovieDetails(String id, MovieModel movie) async {
    final key = 'movie_$id';
    await _movieDetailsBox.put(key, movie);
    await _cacheTimestampBox.put(key, DateTime.now());
  }

  MovieModel? getCachedMovieDetails(String id) {
    final key = 'movie_$id';
    final cached = _movieDetailsBox.get(key);
    if (cached == null) return null;

    // Check TTL
    final timestamp = _cacheTimestampBox.get(key);
    if (timestamp != null && _isExpired(timestamp)) {
      // Expired - clear and return null
      _movieDetailsBox.delete(key);
      _cacheTimestampBox.delete(key);
      return null;
    }

    return cached;
  }

  /// Check if a cache entry is expired
  bool _isExpired(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    return difference.inDays > defaultTtlDays;
  }

  /// Get remaining TTL for a key in hours
  int? getRemainingTtlHours(String key) {
    final timestamp = _cacheTimestampBox.get(key);
    if (timestamp == null) return null;

    if (_isExpired(timestamp)) return 0;

    final now = DateTime.now();
    final difference = now.difference(timestamp);
    final remainingHours = (defaultTtlDays * 24) - difference.inHours;
    return remainingHours > 0 ? remainingHours : 0;
  }

  /// Clear all expired cache entries
  Future<void> clearExpiredCache() async {
    final keysToDelete = <String>[];

    // Check trending movies
    final trendingTimestamp = _cacheTimestampBox.get('trending_movies');
    if (trendingTimestamp != null && _isExpired(trendingTimestamp)) {
      keysToDelete.add('trending_movies');
    }

    // Check movie details (iterate through timestamp box)
    for (final key in _cacheTimestampBox.keys) {
      final timestamp = _cacheTimestampBox.get(key);
      if (timestamp != null && _isExpired(timestamp)) {
        keysToDelete.add(key.toString());
      }
    }

    // Delete expired entries
    for (final key in keysToDelete) {
      _movieCacheBox.delete(key);
      _movieDetailsBox.delete(key);
      _cacheTimestampBox.delete(key);
    }
  }

  /// Clear all cache (force refresh)
  Future<void> clearAllCache() async {
    await _movieCacheBox.clear();
    await _movieDetailsBox.clear();
    await _cacheTimestampBox.clear();
  }
}
