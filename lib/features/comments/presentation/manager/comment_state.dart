import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/comment.dart';

part 'comment_state.freezed.dart';

enum CommentSortType { newest, trending }

@freezed
class CommentState with _$CommentState {
  const factory CommentState.initial() = _Initial;
  const factory CommentState.loading() = _Loading;
  const factory CommentState.loaded({
    required List<Comment> comments,
    required CommentSortType sortType,
    @Default({}) Map<String, List<Comment>> expandedReplies,
    @Default(false) bool isAddingComment,
    String? errorMessage,
    @Default({}) Set<String> likedCommentIds,
    @Default({}) Set<String> likingInProgress,
  }) = _Loaded;
  const factory CommentState.error(String message) = _Error;
}
