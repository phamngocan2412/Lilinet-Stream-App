import 'package:injectable/injectable.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@lazySingleton
class GetCachedTrendingMovies {
  final MovieRepository _repository;

  GetCachedTrendingMovies(this._repository);

  List<Movie>? call() {
    return _repository.getCachedTrendingMovies();
  }
}
