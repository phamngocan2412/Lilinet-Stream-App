import 'package:injectable/injectable.dart';
import '../../../movies/data/datasources/movie_remote_datasource.dart';
import '../../../movies/data/models/movie_model.dart';
import '../models/genre_model.dart';

@lazySingleton
class ExploreRemoteDataSource {
  final MovieRemoteDataSource movieDataSource;

  ExploreRemoteDataSource(this.movieDataSource);

  // Hardcoded genres based on TMDB standard genres
  Future<List<GenreModel>> getGenres() async {
    return const [
      GenreModel(id: '28', name: 'Action'),
      GenreModel(id: '12', name: 'Adventure'),
      GenreModel(id: '16', name: 'Animation'),
      GenreModel(id: '35', name: 'Comedy'),
      GenreModel(id: '80', name: 'Crime'),
      GenreModel(id: '99', name: 'Documentary'),
      GenreModel(id: '18', name: 'Drama'),
      GenreModel(id: '10751', name: 'Family'),
      GenreModel(id: '14', name: 'Fantasy'),
      GenreModel(id: '36', name: 'History'),
      GenreModel(id: '27', name: 'Horror'),
      GenreModel(id: '10402', name: 'Music'),
      GenreModel(id: '9648', name: 'Mystery'),
      GenreModel(id: '10749', name: 'Romance'),
      GenreModel(id: '878', name: 'Science Fiction'),
      GenreModel(id: '10770', name: 'TV Movie'),
      GenreModel(id: '53', name: 'Thriller'),
      GenreModel(id: '10752', name: 'War'),
      GenreModel(id: '37', name: 'Western'),
    ];
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
    return movieDataSource.getTrendingMovies(page: page);
  }
}
