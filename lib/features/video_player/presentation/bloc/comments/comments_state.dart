import 'package:equatable/equatable.dart';
import '../../widgets/comment_section.dart'; // Import CommentModel

/// DEPRECATED: Use [CommentState] from features/comments/ instead.
///
/// These states are part of the mock comment system.
@Deprecated('Use CommentState from features/comments/ instead.')
abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {
  final String videoId;
  const CommentsLoading(this.videoId);
}

class CommentsLoaded extends CommentsState {
  final String videoId;
  final List<CommentModel> comments;

  const CommentsLoaded(this.videoId, this.comments);

  @override
  List<Object> get props => [videoId, comments];
}

class CommentsError extends CommentsState {
  final String message;
  const CommentsError(this.message);
}
