// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final typeId = 3;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      id: fields[0] as String,
      title: fields[1] as String,
      poster: fields[2] as String?,
      cover: fields[3] as String?,
      description: fields[4] as String?,
      rating: (fields[5] as num?)?.toDouble(),
      releaseDate: fields[6] as String?,
      type: fields[7] as String,
      episodeId: fields[8] as String?,
      genres: fields[9] == null ? [] : (fields[9] as List).cast<String>(),
      totalEpisodes: (fields[10] as num?)?.toInt(),
      duration: fields[11] as String?,
      episodes: (fields[12] as List?)?.cast<EpisodeModel>(),
      seasons: (fields[13] as List?)?.cast<SeasonModel>(),
      recommendations: (fields[14] as List?)?.cast<MovieModel>(),
      country: fields[15] as String?,
      production: fields[16] as String?,
      casts: (fields[17] as List?)?.cast<String>(),
      tags: (fields[18] as List?)?.cast<String>(),
      image: fields[19] as String?,
      provider: fields[20] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.poster)
      ..writeByte(3)
      ..write(obj.cover)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.releaseDate)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.episodeId)
      ..writeByte(9)
      ..write(obj.genres)
      ..writeByte(10)
      ..write(obj.totalEpisodes)
      ..writeByte(11)
      ..write(obj.duration)
      ..writeByte(12)
      ..write(obj.episodes)
      ..writeByte(13)
      ..write(obj.seasons)
      ..writeByte(14)
      ..write(obj.recommendations)
      ..writeByte(15)
      ..write(obj.country)
      ..writeByte(16)
      ..write(obj.production)
      ..writeByte(17)
      ..write(obj.casts)
      ..writeByte(18)
      ..write(obj.tags)
      ..writeByte(19)
      ..write(obj.image)
      ..writeByte(20)
      ..write(obj.provider);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MovieListResponseAdapter extends TypeAdapter<MovieListResponse> {
  @override
  final typeId = 4;

  @override
  MovieListResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieListResponse(
      currentPage: fields[0] == null ? 1 : (fields[0] as num).toInt(),
      hasNextPage: fields[1] == null ? false : fields[1] as bool,
      results: (fields[2] as List).cast<MovieModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieListResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentPage)
      ..writeByte(1)
      ..write(obj.hasNextPage)
      ..writeByte(2)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => _MovieModel(
      id: const AnyToStringConverter().fromJson(json['id']),
      title: json['title'] as String,
      poster: const AnyToStringNullableConverter().fromJson(json['poster']),
      cover: const AnyToStringNullableConverter().fromJson(json['cover']),
      description:
          const AnyToStringNullableConverter().fromJson(json['description']),
      rating: const StringToDoubleConverter().fromJson(json['rating']),
      releaseDate:
          const AnyToStringNullableConverter().fromJson(json['releaseDate']),
      type: json['type'] as String,
      episodeId:
          const AnyToStringNullableConverter().fromJson(json['episodeId']),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalEpisodes:
          const StringToIntConverter().fromJson(json['totalEpisodes']),
      duration: const AnyToStringNullableConverter().fromJson(json['duration']),
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: const AnyToStringNullableConverter().fromJson(json['country']),
      production:
          const AnyToStringNullableConverter().fromJson(json['production']),
      casts:
          (json['casts'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      image: const AnyToStringNullableConverter().fromJson(json['image']),
      provider: const AnyToStringNullableConverter().fromJson(json['provider']),
    );

Map<String, dynamic> _$MovieModelToJson(_MovieModel instance) =>
    <String, dynamic>{
      'id': const AnyToStringConverter().toJson(instance.id),
      'title': instance.title,
      'poster': const AnyToStringNullableConverter().toJson(instance.poster),
      'cover': const AnyToStringNullableConverter().toJson(instance.cover),
      'description':
          const AnyToStringNullableConverter().toJson(instance.description),
      'rating': const StringToDoubleConverter().toJson(instance.rating),
      'releaseDate':
          const AnyToStringNullableConverter().toJson(instance.releaseDate),
      'type': instance.type,
      'episodeId':
          const AnyToStringNullableConverter().toJson(instance.episodeId),
      'genres': instance.genres,
      'totalEpisodes':
          const StringToIntConverter().toJson(instance.totalEpisodes),
      'duration':
          const AnyToStringNullableConverter().toJson(instance.duration),
      'episodes': instance.episodes,
      'seasons': instance.seasons,
      'recommendations': instance.recommendations,
      'country': const AnyToStringNullableConverter().toJson(instance.country),
      'production':
          const AnyToStringNullableConverter().toJson(instance.production),
      'casts': instance.casts,
      'tags': instance.tags,
      'image': const AnyToStringNullableConverter().toJson(instance.image),
      'provider':
          const AnyToStringNullableConverter().toJson(instance.provider),
    };

_MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    _MovieListResponse(
      currentPage: json['currentPage'] == null
          ? 1
          : const StringToIntConverterRequired().fromJson(json['currentPage']),
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieListResponseToJson(_MovieListResponse instance) =>
    <String, dynamic>{
      'currentPage':
          const StringToIntConverterRequired().toJson(instance.currentPage),
      'hasNextPage': instance.hasNextPage,
      'results': instance.results,
    };
