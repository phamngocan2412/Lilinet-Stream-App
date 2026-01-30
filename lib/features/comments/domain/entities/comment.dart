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

  // Computed Properties

  /// Calculates the trending score based on the YouTube-like algorithm:
  /// Score = (likes * 1.5) + (replies * 2.5) + (recentLikes * 3) - log(hoursSinceCreated + 1) * 2
  double get trendingScore {
    final now = DateTime.now();
    final hoursSinceCreated = now.difference(createdAt).inHours;

    // Calculate recent likes (last 3 hours)
    final recentLikesCount = likeTimestamps.where((t) {
      return now.difference(t).inHours <= 3;
    }).length;

    final score =
        (likes * 1.5) +
        (repliesCount * 2.5) +
        (recentLikesCount * 3) -
        (log(hoursSinceCreated + 1) * 2);

    return score;
  }

  /// Returns a human-readable time ago string.
  String get timeAgo {
    final duration = DateTime.now().difference(createdAt);
    if (duration.inDays > 7) {
      return '${(duration.inDays / 7).floor()} tuần trước';
    } else if (duration.inDays > 0) {
      return '${duration.inDays} ngày trước';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} giờ trước';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  /// Returns display text with edited indicator
  String get displayTimeAgo {
    final timeStr = timeAgo;
    if (isEdited && updatedAt != null) {
      return '$timeStr (đã chỉnh sửa)';
    }
    return timeStr;
  }
}
