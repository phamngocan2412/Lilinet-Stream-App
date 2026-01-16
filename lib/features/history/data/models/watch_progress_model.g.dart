// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchProgressModelAdapter extends TypeAdapter<WatchProgressModel> {
  @override
  final typeId = 2;

  @override
  WatchProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchProgressModel(
      mediaId: fields[0] as String,
      title: fields[1] as String,
      posterUrl: fields[2] as String?,
      episodeId: fields[3] as String?,
      episodeTitle: fields[4] as String?,
      positionSeconds: (fields[5] as num).toInt(),
      durationSeconds: (fields[6] as num).toInt(),
      lastUpdated: fields[7] as DateTime,
      isFinished: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WatchProgressModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.mediaId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterUrl)
      ..writeByte(3)
      ..write(obj.episodeId)
      ..writeByte(4)
      ..write(obj.episodeTitle)
      ..writeByte(5)
      ..write(obj.positionSeconds)
      ..writeByte(6)
      ..write(obj.durationSeconds)
      ..writeByte(7)
      ..write(obj.lastUpdated)
      ..writeByte(8)
      ..write(obj.isFinished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
