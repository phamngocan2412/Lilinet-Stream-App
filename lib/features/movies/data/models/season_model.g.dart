// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeasonModelAdapter extends TypeAdapter<SeasonModel> {
  @override
  final typeId = 6;

  @override
  SeasonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeasonModel(
      season: (fields[0] as num).toInt(),
      episodes:
          fields[1] == null ? [] : (fields[1] as List).cast<EpisodeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SeasonModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.season)
      ..writeByte(1)
      ..write(obj.episodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeasonModelImpl _$$SeasonModelImplFromJson(Map<String, dynamic> json) =>
    _$SeasonModelImpl(
      season: const StringToIntConverterRequired().fromJson(json['season']),
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SeasonModelImplToJson(_$SeasonModelImpl instance) =>
    <String, dynamic>{
      'season': const StringToIntConverterRequired().toJson(instance.season),
      'episodes': instance.episodes,
    };
