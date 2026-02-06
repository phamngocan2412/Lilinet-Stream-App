import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../movies/data/datasources/movie_remote_datasource.dart';
import '../../../movies/data/models/movie_model.dart';
import '../models/genre_model.dart';

@lazySingleton
class ExploreRemoteDataSource {
  final MovieRemoteDataSource movieDataSource;

  ExploreRemoteDataSource(this.movieDataSource);

  // Genres from AppConstants
  Future<List<GenreModel>> getGenres() async {
    return AppConstants.genres.entries
        .map((e) => GenreModel(id: e.value, name: e.key))
        .toList();
  }

  // Use trending endpoint filtered by type
  Future<MovieListResponse> getMoviesByType(String type, {int page = 1}) {
    return movieDataSource.getTrendingMovies(page: page);
  }

  // Use search to filter by genre (since API doesn't support direct filtering)
  Future<MovieListResponse> getMoviesByGenre(
    String genreId, {
    int page = 1,
  }) async {
    // Find genre name from ID
    final genres = await getGenres();
    final genre = genres.firstWhere(
      (g) => g.id == genreId,
      orElse: () => const GenreModel(id: '', name: ''),
    );

    if (genre.name.isEmpty) {
      // Fallback to trending if genre not found
      return movieDataSource.getTrendingMovies(page: page);
    }

    // Search using genre name
    return movieDataSource.searchMovies(genre.name, page: page);
  }

  // Popular movies (using trending)
  Future<MovieListResponse> getPopularMovies({int page = 1}) {
    return movieDataSource.getPopularMovies(page: page);
  }

  // Top rated movies
  Future<MovieListResponse> getTopRatedMovies({int page = 1}) {
    return movieDataSource.getTopRatedMovies(page: page);
  }
}
