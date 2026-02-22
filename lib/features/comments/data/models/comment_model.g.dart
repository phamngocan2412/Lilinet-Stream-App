// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: json['id'] as String,
      videoId: json['videoId'] as String,
      userName: json['userName'] as String,
      avatarUrl: json['avatarUrl'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      dislikes: (json['dislikes'] as num?)?.toInt() ?? 0,
      repliesCount: (json['repliesCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      likeTimestamps:
          (json['likeTimestamps'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      parentId: json['parentId'] as String?,
      mediaType: json['mediaType'] as String?,
      isEdited: json['isEdited'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoId': instance.videoId,
      'userName': instance.userName,
      'avatarUrl': instance.avatarUrl,
      'content': instance.content,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'repliesCount': instance.repliesCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'likeTimestamps': instance.likeTimestamps
          .map((e) => e.toIso8601String())
          .toList(),
      'replies': instance.replies,
      'parentId': instance.parentId,
      'mediaType': instance.mediaType,
      'isEdited': instance.isEdited,
      'isDeleted': instance.isDeleted,
      'isPinned': instance.isPinned,
    };
