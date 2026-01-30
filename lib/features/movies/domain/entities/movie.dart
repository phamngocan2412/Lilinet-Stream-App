import 'package:freezed_annotation/freezed_annotation.dart';
import 'episode.dart';

part 'movie.freezed.dart';

@freezed
abstract class Movie with _$Movie {
  const factory Movie({
    required String id,
    required String title,
    String? poster,
    String? cover,
    String? description,
    double? rating,
    String? releaseDate,
    required String type, // 'Movie' or 'TV Series'
    String? episodeId,
    @Default([]) List<String> genres,
    int? totalEpisodes,
    String? duration,
    List<Episode>? episodes,
    List<Movie>? recommendations,
    String? country,
    String? production,
    List<String>? casts,
    List<String>? tags,
    String? provider,
  }) = _Movie;
}
