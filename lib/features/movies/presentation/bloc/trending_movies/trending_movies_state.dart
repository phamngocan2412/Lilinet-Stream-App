import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/movie.dart';

part 'trending_movies_state.freezed.dart';

@freezed
class TrendingMoviesState with _$TrendingMoviesState {
  const factory TrendingMoviesState.initial() = _Initial;

  const factory TrendingMoviesState.loading() = _Loading;

  const factory TrendingMoviesState.loaded({
    required List<Movie> trending,
    @Default({}) Map<String, List<Movie>> categories,
  }) = _Loaded;

  const factory TrendingMoviesState.error(String message) = _Error;
}
