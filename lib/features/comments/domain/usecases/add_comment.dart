import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/comment.dart';
import '../repositories/comment_repository.dart';

part 'add_comment.freezed.dart';

@freezed
abstract class AddCommentParams with _$AddCommentParams {
  const factory AddCommentParams({
    required String videoId,
    required String content,
    String? parentId,
  }) = _AddCommentParams;
}

@injectable
class AddComment implements UseCase<Comment, AddCommentParams> {
  final CommentRepository _repository;

  AddComment(this._repository);

  @override
  Future<Either<Failure, Comment>> call(AddCommentParams params) async {
    return await _repository.addComment(
      videoId: params.videoId,
      content: params.content,
      parentId: params.parentId,
    );
  }
}
