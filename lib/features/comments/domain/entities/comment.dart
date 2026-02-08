import 'dart:math';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  const Comment._();

  const factory Comment({
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
    @Default([]) List<DateTime> likeTimestamps, // For calculating recent likes
    @Default([]) List<Comment> replies,
    String? parentId,
    String? mediaType, // 'Movie' or 'TV Series' for navigation
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,
    @Default(false) bool isPinned,
  }) = _Comment;

  /// Trending score is calculated in the Domain layer as it is business logic.
  /// UI-facing formatting like "timeAgo" should be handled in the Presentation layer.
  double get trendingScore {
    final now = DateTime.now();
    final hoursSinceCreated = now.difference(createdAt).inHours;

    // Calculate recent likes (last 3 hours)
    final recentLikesCount = likeTimestamps.where((t) {
      return now.difference(t).inHours <= 3;
    }).length;

    final score = (likes * 1.5) +
        (repliesCount * 2.5) +
        (recentLikesCount * 3) -
        (log(hoursSinceCreated + 1) * 2);

    return score;
  }
}
