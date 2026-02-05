import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'local_comment_model.freezed.dart';
part 'local_comment_model.g.dart';

@freezed
@HiveType(typeId: 12)
abstract class LocalCommentModel with _$LocalCommentModel {
  const LocalCommentModel._();

  const factory LocalCommentModel({
    @HiveField(0) required String localId,
    @HiveField(1) String? serverId,
    @HiveField(2) required String videoId,
    @HiveField(3) required String content,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) @Default(false) bool isSynced,
    @HiveField(6) @Default(false) bool isGuest,
    @HiveField(7) String? tempUserName,
    @HiveField(8) String? tempAvatarUrl,
    @HiveField(9) String? userId,
    @HiveField(10) @Default(0) int likes,
    @HiveField(11) @Default(0) int dislikes,
    @HiveField(12) @Default(0) int repliesCount,
    @HiveField(13) String? parentId,
    @HiveField(14) @Default([]) List<DateTime> likeTimestamps,
    @HiveField(15) String? mediaType, // 'Movie' or 'TV Series' for navigation
  }) = _LocalCommentModel;

  factory LocalCommentModel.fromJson(Map<String, dynamic> json) =>
      _$LocalCommentModelFromJson(json);

  bool get isPending => !isSynced;

  String get displayName => isGuest
      ? (tempUserName ?? 'Guest_${localId.substring(0, 6)}')
      : (tempUserName ?? 'User');

  String get displayAvatar =>
      tempAvatarUrl ??
      'https://ui-avatars.com/api/?name=${displayName.replaceAll(' ', '+')}&background=random';

  LocalCommentModel markAsSynced(String serverCommentId) {
    return copyWith(serverId: serverCommentId, isSynced: true);
  }

  LocalCommentModel markAsPending() {
    return copyWith(isSynced: false);
  }
}
