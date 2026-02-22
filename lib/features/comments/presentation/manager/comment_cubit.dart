import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  Timer? _realtimeDebounceTimer;
  static const _realtimeDebounceDuration = Duration(milliseconds: 500);

  CommentCubit(
    this._getComments,
    this._addComment,
    this._likeComment,
    this._getReplies,
    this._repository,
  ) : super(const CommentState.initial());

  @override
  Future<void> close() {
    _realtimeSubscription?.cancel();
    _realtimeDebounceTimer?.cancel();
    return super.close();
  }

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

        // Filter out replies - only show root comments (parentId is null)
        final rootComments = comments.where((c) => c.parentId == null).toList();

        // Default sort is Trending
        final sortedComments = _sortComments(
          rootComments,
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

  /// Silent refresh comments without canceling subscription
  /// Use this after addComment to sync with server while keeping realtime alive
  Future<void> _silentRefresh() async {
    final videoId = _currentVideoId;
    if (videoId == null) return;

    // Cancel any pending debounce timer
    _realtimeDebounceTimer?.cancel();

    state.mapOrNull(
      loaded: (currentState) async {
        debugPrint('🔄 Silent refresh...');
        final results = await Future.wait([
          _getComments(videoId),
          _repository.getLikedCommentIds(videoId),
        ]);

        if (isClosed) return;

        final commentsResult = results[0] as Either<Failure, List<Comment>>;
        final likedIdsResult = results[1] as Either<Failure, List<String>>;

        final likedIds = likedIdsResult.fold(
          (failure) => currentState.likedCommentIds,
          (ids) => ids.toSet(),
        );

        commentsResult.fold(
          (l) {}, // Silent fail - keep existing comments
          (newComments) {
            // Filter out replies - only show root comments (parentId is null)
            final rootComments =
                newComments.where((c) => c.parentId == null).toList();
            final sorted = _sortComments(rootComments, currentState.sortType);

            // Only emit if the comments are actually different
            if (_commentsChanged(currentState.comments, sorted)) {
              emit(
                currentState.copyWith(
                  comments: sorted,
                  likedCommentIds: likedIds,
                ),
              );
            }
          },
        );
      },
    );
  }

  void _subscribeToRealtime(String videoId) {
    _realtimeSubscription = _repository.getCommentStream(videoId).listen(
      (events) async {
        debugPrint('🔔 Realtime comment update received, debouncing...');

        // Cancel existing debounce timer
        _realtimeDebounceTimer?.cancel();

        // Debounce to prevent too many refreshes
        _realtimeDebounceTimer = Timer(_realtimeDebounceDuration, () async {
          debugPrint('🔔 Executing debounced refresh...');

          // Only refresh if we still have the same videoId
          if (_currentVideoId != videoId) return;

          final results = await Future.wait([
            _getComments(videoId),
            _repository.getLikedCommentIds(videoId),
          ]);

          if (isClosed) return;

          final commentsResult = results[0] as Either<Failure, List<Comment>>;

          state.mapOrNull(
            loaded: (loadedState) {
              commentsResult.fold((l) => null, (newComments) {
                // Filter out replies - only show root comments (parentId is null)
                final rootComments =
                    newComments.where((c) => c.parentId == null).toList();
                final sorted = _sortComments(
                  rootComments,
                  loadedState.sortType,
                );
                // Only emit if the comments are actually different
                if (_commentsChanged(loadedState.comments, sorted)) {
                  emit(loadedState.copyWith(comments: sorted));
                }
              });
            },
          );
        });
      },
      onError: (error) {
        debugPrint('Realtime subscription error: $error');
      },
    );
  }

  bool _commentsChanged(List<Comment> old, List<Comment> newComments) {
    if (old.length != newComments.length) return true;
    for (int i = 0; i < old.length; i++) {
      if (old[i].id != newComments[i].id) return true;
    }
    return false;
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

        // --- Optimistic Insert ---
        final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
        final user = _getCurrentUser();
        final optimisticComment = Comment(
          id: tempId,
          videoId: _currentVideoId!,
          userName: user['userName']!,
          avatarUrl: user['avatarUrl']!,
          content: content,
          createdAt: DateTime.now(),
          parentId: parentId,
          isSending: true,
        );

        if (parentId != null) {
          // Optimistic reply: add to parent's replies
          final updatedComments = loadedState.comments.map((comment) {
            if (comment.id == parentId) {
              return comment.copyWith(
                replies: [...comment.replies, optimisticComment],
                repliesCount: comment.repliesCount + 1,
              );
            }
            return comment;
          }).toList();

          final updatedExpandedReplies = Map<String, List<Comment>>.from(
            loadedState.expandedReplies,
          );
          if (updatedExpandedReplies.containsKey(parentId)) {
            updatedExpandedReplies[parentId] = [
              ...updatedExpandedReplies[parentId]!,
              optimisticComment,
            ];
          }
          emit(
            loadedState.copyWith(
              comments: updatedComments,
              expandedReplies: updatedExpandedReplies,
            ),
          );
        } else {
          // Optimistic root comment: prepend to list
          emit(
            loadedState.copyWith(
              comments: [optimisticComment, ...loadedState.comments],
            ),
          );
        }
        debugPrint('⚡ Optimistic comment shown: $tempId');

        // --- Real API call ---
        final result = await _addComment(
          AddCommentParams(
            videoId: _currentVideoId!,
            content: content,
            parentId: parentId,
          ),
        );

        if (isClosed) return;

        // Get the current state after the optimistic emit
        final currentState = state.maybeMap(
          loaded: (s) => s,
          orElse: () => null,
        );
        if (currentState == null) return;

        result.fold(
          (failure) {
            debugPrint('❌ Failed to add comment: ${failure.message}');
            // Remove optimistic comment on failure
            final cleaned = _removeCommentById(currentState.comments, tempId);
            final cleanedReplies = Map<String, List<Comment>>.from(
              currentState.expandedReplies,
            );
            cleanedReplies.forEach((key, replies) {
              cleanedReplies[key] =
                  replies.where((r) => r.id != tempId).toList();
            });
            emit(
              currentState.copyWith(
                comments: cleaned,
                expandedReplies: cleanedReplies,
                isAddingComment: false,
                errorMessage: failure.message,
              ),
            );
          },
          (newComment) async {
            debugPrint('✅ Comment added successfully: ${newComment.id}');
            // Replace optimistic comment with real one
            final replaced = _replaceComment(
              currentState.comments,
              tempId,
              newComment,
            );
            final replacedReplies = Map<String, List<Comment>>.from(
              currentState.expandedReplies,
            );
            replacedReplies.forEach((key, replies) {
              replacedReplies[key] =
                  replies.map((r) => r.id == tempId ? newComment : r).toList();
            });
            emit(
              currentState.copyWith(
                comments: replaced,
                expandedReplies: replacedReplies,
                isAddingComment: false,
              ),
            );
            _silentRefresh();
          },
        );
      },
      orElse: () async {
        debugPrint('⚠️ State is not loaded, reloading comments first...');
        await loadComments(_currentVideoId!);
      },
    );
  }

  /// Returns current user info for optimistic comment creation.
  Map<String, String> _getCurrentUser() {
    try {
      // Import would create circular dependency, use dynamic access
      final supabase = (Supabase.instance.client).auth.currentUser;
      final name = supabase?.userMetadata?['display_name'] as String? ??
          supabase?.userMetadata?['name'] as String? ??
          supabase?.email?.split('@').first ??
          'Anonymous';
      final avatar = supabase?.userMetadata?['avatar_url'] as String? ??
          'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}';
      return {'userName': name, 'avatarUrl': avatar};
    } catch (_) {
      return {
        'userName': 'Anonymous',
        'avatarUrl': 'https://ui-avatars.com/api/?name=Anonymous',
      };
    }
  }

  /// Removes a comment by ID from the list (including nested replies).
  List<Comment> _removeCommentById(List<Comment> comments, String id) {
    return comments.where((c) {
      if (c.id == id) return false;
      return true;
    }).map((c) {
      if (c.replies.any((r) => r.id == id)) {
        return c.copyWith(
          replies: c.replies.where((r) => r.id != id).toList(),
          repliesCount: (c.repliesCount - 1).clamp(0, c.repliesCount),
        );
      }
      return c;
    }).toList();
  }

  /// Replaces a temp comment with the real server comment.
  List<Comment> _replaceComment(
    List<Comment> comments,
    String tempId,
    Comment replacement,
  ) {
    return comments.map((c) {
      if (c.id == tempId) return replacement;
      if (c.replies.any((r) => r.id == tempId)) {
        return c.copyWith(
          replies:
              c.replies.map((r) => r.id == tempId ? replacement : r).toList(),
        );
      }
      return c;
    }).toList();
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
}
