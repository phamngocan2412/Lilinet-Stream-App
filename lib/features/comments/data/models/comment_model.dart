import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/comment.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    required String id,
    required String videoId,
    required String userName,
    required String avatarUrl,
    required String content,
    @Default(0) int likes,
    @Default(0) int dislikes,
    @Default(0) int repliesCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default([]) List<DateTime> likeTimestamps,
    @Default([]) List<CommentModel> replies,
    String? parentId,
    String? mediaType,
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,
    @Default(false) bool isPinned,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Comment toEntity() {
    return Comment(
      id: id,
      videoId: videoId,
      userName: userName,
      avatarUrl: avatarUrl,
      content: content,
      likes: likes,
      dislikes: dislikes,
      repliesCount: repliesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      likeTimestamps: likeTimestamps,
      replies: replies.map((e) => e.toEntity()).toList(),
      parentId: parentId,
      mediaType: mediaType,
      isEdited: isEdited,
      isDeleted: isDeleted,
      isPinned: isPinned,
    );
  }
}
