// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalCommentModelAdapter extends TypeAdapter<LocalCommentModel> {
  @override
  final typeId = 12;

  @override
  LocalCommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalCommentModel(
      localId: fields[0] as String,
      serverId: fields[1] as String?,
      videoId: fields[2] as String,
      content: fields[3] as String,
      createdAt: fields[4] as DateTime,
      isSynced: fields[5] == null ? false : fields[5] as bool,
      isGuest: fields[6] == null ? false : fields[6] as bool,
      tempUserName: fields[7] as String?,
      tempAvatarUrl: fields[8] as String?,
      userId: fields[9] as String?,
      likes: fields[10] == null ? 0 : (fields[10] as num).toInt(),
      dislikes: fields[11] == null ? 0 : (fields[11] as num).toInt(),
      repliesCount: fields[12] == null ? 0 : (fields[12] as num).toInt(),
      parentId: fields[13] as String?,
      likeTimestamps:
          fields[14] == null ? [] : (fields[14] as List).cast<DateTime>(),
      mediaType: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalCommentModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.localId)
      ..writeByte(1)
      ..write(obj.serverId)
      ..writeByte(2)
      ..write(obj.videoId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.isSynced)
      ..writeByte(6)
      ..write(obj.isGuest)
      ..writeByte(7)
      ..write(obj.tempUserName)
      ..writeByte(8)
      ..write(obj.tempAvatarUrl)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.likes)
      ..writeByte(11)
      ..write(obj.dislikes)
      ..writeByte(12)
      ..write(obj.repliesCount)
      ..writeByte(13)
      ..write(obj.parentId)
      ..writeByte(14)
      ..write(obj.likeTimestamps)
      ..writeByte(15)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalCommentModelImpl _$$LocalCommentModelImplFromJson(
  Map<String, dynamic> json,
) =>
    _$LocalCommentModelImpl(
      localId: json['localId'] as String,
      serverId: json['serverId'] as String?,
      videoId: json['videoId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
      isGuest: json['isGuest'] as bool? ?? false,
      tempUserName: json['tempUserName'] as String?,
      tempAvatarUrl: json['tempAvatarUrl'] as String?,
      userId: json['userId'] as String?,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      dislikes: (json['dislikes'] as num?)?.toInt() ?? 0,
      repliesCount: (json['repliesCount'] as num?)?.toInt() ?? 0,
      parentId: json['parentId'] as String?,
      likeTimestamps: (json['likeTimestamps'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      mediaType: json['mediaType'] as String?,
    );

Map<String, dynamic> _$$LocalCommentModelImplToJson(
  _$LocalCommentModelImpl instance,
) =>
    <String, dynamic>{
      'localId': instance.localId,
      'serverId': instance.serverId,
      'videoId': instance.videoId,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
      'isGuest': instance.isGuest,
      'tempUserName': instance.tempUserName,
      'tempAvatarUrl': instance.tempAvatarUrl,
      'userId': instance.userId,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'repliesCount': instance.repliesCount,
      'parentId': instance.parentId,
      'likeTimestamps':
          instance.likeTimestamps.map((e) => e.toIso8601String()).toList(),
      'mediaType': instance.mediaType,
    };
