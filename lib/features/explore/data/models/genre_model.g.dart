// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenreModelAdapter extends TypeAdapter<GenreModel> {
  @override
  final typeId = 7;

  @override
  GenreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenreModel(
      id: fields[0] as String,
      name: fields[1] as String,
      icon: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GenreModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => _GenreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$GenreModelToJson(_GenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
    };
