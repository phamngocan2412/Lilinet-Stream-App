import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';
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
  final CommentRepository _repository;

  StreamSubscription? _realtimeSubscription;

  CommentCubit(
    this._getComments,
    this._addComment,
    this._likeComment,
    this._getReplies,
    this._repository,
  ) : super(const CommentState.initial());

  String? _currentVideoId;

  Future<void> loadComments(String videoId) async {
    _currentVideoId = videoId;
    emit(const CommentState.loading());

    // Cancel existing subscription if any
    _realtimeSubscription?.cancel();

    // Subscribe to realtime updates
    _subscribeToRealtime(videoId);

    // Fetch comments and liked IDs in parallel
    final results = await Future.wait([
      _getComments(videoId),
      _repository.getLikedCommentIds(videoId),
    ]);

    if (isClosed) return;

    final commentsResult = results[0] as Either<Failure, List<Comment>>;
    final likedIdsResult = results[1] as Either<Failure, List<String>>;

    commentsResult.fold(
      (failure) => emit(CommentState.error(failure.message)),
      (comments) {
        // Get liked IDs (ignore error, just use empty set if failed)
        final likedIds = likedIdsResult.fold(
          (failure) => <String>{},
          (ids) => ids.toSet(),
        );

        // Default sort is Trending
        final sortedComments = _sortComments(
          comments,
          CommentSortType.trending,
        );
        emit(
          CommentState.loaded(
            comments: sortedComments,
            sortType: CommentSortType.trending,
            likedCommentIds: likedIds,
          ),
        );
      },
    );
  }

  void _subscribeToRealtime(String videoId) {
    _realtimeSubscription = _repository.getCommentStream(videoId).listen(
      (events) async {
        // When a change occurs, we simply reload the comments for now to ensure consistency.
        // A more optimized approach would be to parse the event and update the list locally.
        // Given we are using BLoC and immutable state, fetching fresh data is safer and easier.
        debugPrint('🔔 Realtime comment update received');

        // We do a "silent" reload - keeping the current state visible but updating data
        final results = await Future.wait([
          _getComments(videoId),
          _repository.getLikedCommentIds(videoId), // Refresh likes too
        ]);

        if (isClosed) return;

        final commentsResult = results[0] as Either<Failure, List<Comment>>;
        // We keep existing liked IDs unless we want to refresh them too

        state.mapOrNull(
          loaded: (loadedState) {
            commentsResult.fold(
              (l) => null, // Ignore errors on silent refresh
              (newComments) {
                final sorted = _sortComments(
                  newComments,
                  loadedState.sortType,
                );
                emit(loadedState.copyWith(comments: sorted));
              },
            );
          },
        );
      },
      onError: (error) {
        debugPrint('Realtime subscription error: $error');
      },
    );
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
          if (isClosed) return;
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

        if (isClosed) return;

        result.fold(
          (failure) {
            debugPrint('❌ Failed to add comment: ${failure.message}');
            emit(loadedState.copyWith(isAddingComment: false));
            // Emit error message without hardcoded label. UI will handle formatting if needed.
            emit(
              CommentState.loaded(
                comments: loadedState.comments,
                sortType: loadedState.sortType,
                errorMessage: failure.message,
              ),
            );
          },
          (newComment) async {
            debugPrint('✅ Comment added successfully: ${newComment.id}');
            // We rely on realtime subscription to update the list,
            // but we can manually reload to be sure or stop the loading indicator immediately.
            emit(loadedState.copyWith(isAddingComment: false));
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
        // Prevent multiple simultaneous operations
        if (currentState.likingInProgress.contains(commentId)) {
          return;
        }

        final isAlreadyLiked = currentState.likedCommentIds.contains(commentId);

        // Add to likingInProgress
        final newLikingInProgress = Set<String>.from(
          currentState.likingInProgress,
        )..add(commentId);

        emit(currentState.copyWith(likingInProgress: newLikingInProgress));

        // Optimistic update - toggle like state
        final updatedComments = currentState.comments.map((c) {
          if (c.id == commentId) {
            return c.copyWith(
              likes: isAlreadyLiked ? c.likes - 1 : c.likes + 1,
            );
          }
          return c;
        }).toList();

        // Toggle liked state and remove from inProgress
        final newLikedIds = Set<String>.from(currentState.likedCommentIds);
        if (isAlreadyLiked) {
          newLikedIds.remove(commentId);
        } else {
          newLikedIds.add(commentId);
        }
        final finalLikingInProgress = Set<String>.from(newLikingInProgress)
          ..remove(commentId);

        emit(
          currentState.copyWith(
            comments: updatedComments,
            likedCommentIds: newLikedIds,
            likingInProgress: finalLikingInProgress,
          ),
        );

        // Call backend - it handles toggle logic (like/unlike)
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

  @override
  Future<void> close() {
    _realtimeSubscription?.cancel();
    return super.close();
  }
}
