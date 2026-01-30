import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/comment.dart';
import '../../domain/usecases/add_comment.dart';
import '../../domain/usecases/get_comments.dart';
import '../../domain/usecases/get_replies.dart';
import '../../domain/usecases/like_comment.dart';
import 'comment_state.dart';

@injectable
class CommentCubit extends Cubit<CommentState> {
  final GetComments _getComments;
  final AddComment _addComment;
  final LikeComment _likeComment;
  final GetReplies _getReplies;

  CommentCubit(
    this._getComments,
    this._addComment,
    this._likeComment,
    this._getReplies,
  ) : super(const CommentState.initial());

  String? _currentVideoId;

  Future<void> loadComments(String videoId) async {
    _currentVideoId = videoId;
    emit(const CommentState.loading());

    final result = await _getComments(videoId);

    result.fold((failure) => emit(CommentState.error(failure.message)), (
      comments,
    ) {
      // Default sort is Trending
      final sortedComments = _sortComments(comments, CommentSortType.trending);
      emit(
        CommentState.loaded(
          comments: sortedComments,
          sortType: CommentSortType.trending,
        ),
      );
    });
  }

  void changeSortType(CommentSortType type) {
    state.mapOrNull(
      loaded: (state) {
        final sorted = _sortComments(state.comments, type);
        emit(state.copyWith(comments: sorted, sortType: type));
      },
    );
  }

  Future<void> toggleReplies(String commentId) async {
    state.mapOrNull(
      loaded: (currentState) async {
        final expanded = Map<String, List<Comment>>.from(
          currentState.expandedReplies,
        );

        if (expanded.containsKey(commentId)) {
          expanded.remove(commentId);
          emit(currentState.copyWith(expandedReplies: expanded));
        } else {
          // Load replies if not cached? Or just toggle visiblity if they are nested?
          // The entity has `replies` list, but mostly root comments don't have enough cache.
          // The requirement says "Expand/collapse replies with animation" & "Load replies using UseCase".

          // Check if logic handles loading
          final result = await _getReplies(commentId);
          result.fold(
            (l) {}, // Handle error silently or show snackbar (need cleaner way)
            (replies) {
              expanded[commentId] = replies;
              emit(currentState.copyWith(expandedReplies: expanded));
            },
          );
        }
      },
    );
  }

  Future<void> addComment(String content, {String? parentId}) async {
    debugPrint('📝 Adding comment: $content, parentId: $parentId');

    if (_currentVideoId == null) {
      debugPrint('❌ Cannot add comment: _currentVideoId is null');
      return;
    }

    await state.maybeMap(
      loaded: (loadedState) async {
        emit(loadedState.copyWith(isAddingComment: true));
        debugPrint('⏳ Emitting loading state');

        final result = await _addComment(
          AddCommentParams(
            videoId: _currentVideoId!,
            content: content,
            parentId: parentId,
          ),
        );

        result.fold(
          (failure) {
            debugPrint('❌ Failed to add comment: ${failure.message}');
            emit(loadedState.copyWith(isAddingComment: false));
            // Emit error as a separate state that preserves comments
            emit(
              CommentState.loaded(
                comments: loadedState.comments,
                sortType: loadedState.sortType,
                errorMessage: 'Không thể gửi bình luận: ${failure.message}',
              ),
            );
          },
          (newComment) async {
            debugPrint('✅ Comment added successfully: ${newComment.id}');

            // Reload comments from server to ensure we have the latest data
            debugPrint('🔄 Reloading comments to refresh list...');
            await loadComments(_currentVideoId!);
          },
        );
      },
      orElse: () async {
        debugPrint('⚠️ State is not loaded, reloading comments first...');
        await loadComments(_currentVideoId!);
      },
    );
  }

  Future<void> likeComment(String commentId) async {
    state.mapOrNull(
      loaded: (currentState) {
        // Prevent multiple likes
        if (currentState.likedCommentIds.contains(commentId)) {
          return;
        }
        if (currentState.likingInProgress.contains(commentId)) {
          return;
        }

        // Add to likingInProgress
        final newLikingInProgress = Set<String>.from(
          currentState.likingInProgress,
        )..add(commentId);

        emit(currentState.copyWith(likingInProgress: newLikingInProgress));

        // Optimistic update
        final updatedComments = currentState.comments.map((c) {
          if (c.id == commentId) {
            return c.copyWith(likes: c.likes + 1);
          }
          return c;
        }).toList();

        // Add to liked and remove from inProgress
        final newLikedIds = Set<String>.from(currentState.likedCommentIds)
          ..add(commentId);
        final finalLikingInProgress = Set<String>.from(newLikingInProgress)
          ..remove(commentId);

        emit(
          currentState.copyWith(
            comments: updatedComments,
            likedCommentIds: newLikedIds,
            likingInProgress: finalLikingInProgress,
          ),
        );

        _likeComment(commentId);
      },
    );
  }

  List<Comment> _sortComments(List<Comment> comments, CommentSortType type) {
    // Return a new list to avoid mutating original if needed
    final sorted = List<Comment>.from(comments);
    switch (type) {
      case CommentSortType.newest:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case CommentSortType.trending:
        sorted.sort((a, b) => b.trendingScore.compareTo(a.trendingScore));
        break;
    }
    return sorted;
  }
}
