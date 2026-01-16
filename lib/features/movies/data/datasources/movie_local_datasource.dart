import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/movie_model.dart';

@lazySingleton
class MovieLocalDataSource {
  final Box<MovieListResponse> _movieCacheBox;
  final Box<MovieModel> _movieDetailsBox;

  MovieLocalDataSource(this._movieCacheBox, this._movieDetailsBox);

  // Trending movies cache
  Future<void> cacheTrendingMovies(MovieListResponse response) async {
    await _movieCacheBox.put('trending_movies', response);
  }

  MovieListResponse? getCachedTrendingMovies() {
    return _movieCacheBox.get('trending_movies');
  }

  // Movie details cache
  Future<void> cacheMovieDetails(String id, MovieModel movie) async {
    await _movieDetailsBox.put('movie_$id', movie);
  }

  MovieModel? getCachedMovieDetails(String id) {
    return _movieDetailsBox.get('movie_$id');
  }

  // Clear old cache (optional, call periodically)
  Future<void> clearOldCache() async {
    await _movieCacheBox.clear();
    await _movieDetailsBox.clear();
  }
}
