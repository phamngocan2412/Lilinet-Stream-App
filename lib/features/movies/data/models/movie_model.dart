import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';
import '../../../../core/utils/json_converters.dart';
import '../../domain/entities/movie.dart';
import 'episode_model.dart';
import 'season_model.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
@HiveType(typeId: 3)
abstract class MovieModel with _$MovieModel {
  const MovieModel._();

  const factory MovieModel({
    @HiveField(0) @AnyToStringConverter() required String id,
    @HiveField(1) required String title,
    @HiveField(2) @AnyToStringNullableConverter() String? poster,
    @HiveField(3) @AnyToStringNullableConverter() String? cover,
    @HiveField(4) @AnyToStringNullableConverter() String? description,
    @HiveField(5) @StringToDoubleConverter() double? rating,
    @HiveField(6) @AnyToStringNullableConverter() String? releaseDate,
    @HiveField(7) required String type,
    @HiveField(8) @AnyToStringNullableConverter() String? episodeId,
    @HiveField(9) @Default([]) List<String> genres,
    @HiveField(10) @StringToIntConverter() int? totalEpisodes,
    @HiveField(11) @AnyToStringNullableConverter() String? duration,
    @HiveField(12) List<EpisodeModel>? episodes,
    @HiveField(13) List<SeasonModel>? seasons,
    @HiveField(14) List<MovieModel>? recommendations,
    @HiveField(15) @AnyToStringNullableConverter() String? country,
    @HiveField(16) @AnyToStringNullableConverter() String? production,
    @HiveField(17) List<String>? casts,
    @HiveField(18) List<String>? tags,
    @HiveField(19) @AnyToStringNullableConverter() String? image,
    @HiveField(20) @AnyToStringNullableConverter() String? provider,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Movie toEntity() {
    // Flatten seasons into episodes if seasons exist
    final flattenedEpisodes = <EpisodeModel>[];
    if (episodes != null) {
      flattenedEpisodes.addAll(episodes!);
    } else if (seasons != null) {
      for (final season in seasons!) {
        flattenedEpisodes.addAll(season.episodes);
      }
    }

    return Movie(
      id: id,
      title: title,
      poster: poster ?? image,
      cover: cover ?? image,
      description: description,
      rating: rating,
      releaseDate: releaseDate,
      type: type,
      episodeId: episodeId,
      genres: genres,
      totalEpisodes: totalEpisodes,
      duration: duration,
      episodes: flattenedEpisodes.isNotEmpty
          ? flattenedEpisodes.map((e) => e.toEntity()).toList()
          : null,
      recommendations: recommendations?.map((m) => m.toEntity()).toList(),
      country: country,
      production: production,
      casts: casts,
      tags: tags,
      provider: provider,
    );
  }
}

@freezed
@HiveType(typeId: 4)
abstract class MovieListResponse with _$MovieListResponse {
  const factory MovieListResponse({
    @HiveField(0) @StringToIntConverterRequired() @Default(1) int currentPage,
    @HiveField(1) @Default(false) bool hasNextPage,
    @HiveField(2) required List<MovieModel> results,
  }) = _MovieListResponse;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
}
