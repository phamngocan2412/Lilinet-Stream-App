import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/repository_extensions.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';
import '../datasources/comment_remote_datasource.dart';
import '../datasources/local_comment_datasource.dart';
import '../models/local_comment_model.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource _remoteDataSource;
  final LocalCommentDataSource _localDataSource;

  CommentRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Comment>>> getComments(String videoId) {
    return safeCall(() async {
      // 1. Get server comments
      final serverComments = await _remoteDataSource.getComments(videoId);

      // 2. Get local comments for this video
      final localComments = await _localDataSource.getCommentsForVideo(videoId);

      // 3. Merge: prioritize local pending comments
      final mergedComments = <Comment>[];

      // Add server comments first
      for (final serverComment in serverComments) {
        mergedComments.add(serverComment.toEntity());
      }

      // Add local pending comments
      for (final localComment in localComments) {
        if (!localComment.isSynced) {
          mergedComments.add(_localCommentToEntity(localComment));
        }
      }

      // Sort by trending score (or createdAt if needed)
      mergedComments.sort((a, b) => b.trendingScore.compareTo(a.trendingScore));

      return mergedComments;
    });
  }

  @override
  Future<Either<Failure, Comment>> addComment({
    required String videoId,
    required String content,
    String? parentId,
    String? userId, // No longer used - Supabase handles auth internally
  }) {
    return safeCall(() async {
      // Note: Authentication is handled in SupabaseCommentDataSource
      // which checks _supabase.auth.currentUser

      // Try to sync to server first
      try {
        final serverComment = await _remoteDataSource.addComment(
          videoId: videoId,
          content: content,
          parentId: parentId,
        );
        return serverComment.toEntity();
      } catch (e) {
        // If network fails, save as pending locally
        final localComment = LocalCommentModel(
          localId: LocalCommentDataSourceImpl.generateLocalId(),
          videoId: videoId,
          content: content,
          createdAt: DateTime.now(),
          isSynced: false,
          isGuest: false,
          tempUserName: null,
          tempAvatarUrl: null,
          userId: userId,
          parentId: parentId,
        );

        await _localDataSource.saveComment(localComment);
        return _localCommentToEntity(localComment);
      }
    });
  }

  @override
  Future<Either<Failure, void>> likeComment(String commentId) {
    return safeCall(() async {
      await _remoteDataSource.likeComment(commentId);
    });
  }

  @override
  Future<Either<Failure, void>> dislikeComment(String commentId) {
    return safeCall(() async {
      await _remoteDataSource.dislikeComment(commentId);
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getReplies(String commentId) {
    return safeCall(() async {
      final models = await _remoteDataSource.getReplies(commentId);
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getPendingComments() {
    return safeCall(() async {
      final pending = await _localDataSource.getAllPendingComments();
      return pending.map((c) => _localCommentToEntity(c)).toList();
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getGuestComments() {
    return safeCall(() async {
      final guests = await _localDataSource.getAllGuestComments();
      return guests.map((c) => _localCommentToEntity(c)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> syncPendingComments() {
    return safeCall(() async {
      final pending = await _localDataSource.getAllPendingComments();

      for (final comment in pending) {
        try {
          final serverComment = await _remoteDataSource.addComment(
            videoId: comment.videoId,
            content: comment.content,
            parentId: comment.parentId,
          );

          await _localDataSource.markAsSynced(
            comment.localId,
            serverComment.id,
          );
        } catch (e) {
          // Continue with next comment if one fails
          continue;
        }
      }
    });
  }

  @override
  Future<Either<Failure, int>> syncGuestComments(
    String userId,
    String userName,
    String avatarUrl,
  ) {
    return safeCall(() async {
      final guests = await _localDataSource.getAllGuestComments();
      int syncedCount = 0;

      for (final comment in guests) {
        try {
          final serverComment = await _remoteDataSource.addComment(
            videoId: comment.videoId,
            content: comment.content,
            parentId: comment.parentId,
          );

          await _localDataSource.markAsSynced(
            comment.localId,
            serverComment.id,
          );
          syncedCount++;
        } catch (e) {
          // Continue with next comment if one fails
          continue;
        }
      }

      return syncedCount;
    });
  }

  @override
  Future<Either<Failure, void>> clearGuestComments() {
    return safeCall(() async {
      final guests = await _localDataSource.getAllGuestComments();
      for (final comment in guests) {
        await _localDataSource.deleteComment(comment.localId);
      }
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getTrendingComments({int limit = 5}) {
    return safeCall(() async {
      final trending = await _remoteDataSource.getTrendingComments(
        limit: limit,
      );
      return trending.map((m) => m.toEntity()).toList();
    });
  }

  // Helper to convert LocalCommentModel to Comment entity
  Comment _localCommentToEntity(LocalCommentModel local) {
    return Comment(
      id: local.localId,
      videoId: local.videoId,
      userName: local.displayName,
      avatarUrl: local.displayAvatar,
      content: local.content,
      likes: local.likes,
      dislikes: local.dislikes,
      repliesCount: local.repliesCount,
      createdAt: local.createdAt,
      likeTimestamps: local.likeTimestamps,
      replies: [],
      parentId: local.parentId,
      mediaType: local.mediaType,
    );
  }
}
