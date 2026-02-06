// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeModelAdapter extends TypeAdapter<EpisodeModel> {
  @override
  final typeId = 5;

  @override
  EpisodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      number: (fields[3] as num).toInt(),
      season: (fields[4] as num?)?.toInt(),
      image: fields[5] as String?,
      url: fields[6] as String?,
      releaseDate: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, EpisodeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.season)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodeModelImpl _$$EpisodeModelImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeModelImpl(
      id: const AnyToStringConverter().fromJson(json['id']),
      title: json['title'] as String,
      description:
          const AnyToStringNullableConverter().fromJson(json['description']),
      number: const StringToIntConverterRequired().fromJson(json['episode']),
      season: const StringToIntConverter().fromJson(json['season']),
      image: const EpisodeImageConverter().fromJson(json['image']),
      url: const AnyToStringNullableConverter().fromJson(json['url']),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$$EpisodeModelImplToJson(_$EpisodeModelImpl instance) =>
    <String, dynamic>{
      'id': const AnyToStringConverter().toJson(instance.id),
      'title': instance.title,
      'description':
          const AnyToStringNullableConverter().toJson(instance.description),
      'episode': const StringToIntConverterRequired().toJson(instance.number),
      'season': const StringToIntConverter().toJson(instance.season),
      'image': const EpisodeImageConverter().toJson(instance.image),
      'url': const AnyToStringNullableConverter().toJson(instance.url),
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };
