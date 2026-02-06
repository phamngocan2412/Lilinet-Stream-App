import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/comment.dart';

abstract class CommentRepository {
  // Get comments (merges server + local)
  Future<Either<Failure, List<Comment>>> getComments(String videoId);

  // Add comment (requires authentication)
  Future<Either<Failure, Comment>> addComment({
    required String videoId,
    required String content,
    String? parentId,
    String? userId,
  });

  Future<Either<Failure, void>> likeComment(String commentId);
  Future<Either<Failure, void>> dislikeComment(String commentId);
  Future<Either<Failure, List<Comment>>> getReplies(String commentId);
  Future<Either<Failure, List<String>>> getLikedCommentIds(String videoId);

  // Guest/Pending comment management
  Future<Either<Failure, List<Comment>>> getPendingComments();
  Future<Either<Failure, List<Comment>>> getGuestComments();
  Future<Either<Failure, void>> syncPendingComments();
  Future<Either<Failure, int>> syncGuestComments(
    String userId,
    String userName,
    String avatarUrl,
  );
  Future<Either<Failure, void>> clearGuestComments();

  // Get trending comments from all videos
  Future<Either<Failure, List<Comment>>> getTrendingComments({int limit = 5});

  // Real-time updates
  Stream<List<Map<String, dynamic>>> getCommentStream(String videoId);
}
