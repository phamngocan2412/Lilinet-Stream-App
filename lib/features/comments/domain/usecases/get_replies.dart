import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/comment.dart';
import '../repositories/comment_repository.dart';

@injectable
class GetReplies implements UseCase<List<Comment>, String> {
  final CommentRepository _repository;

  GetReplies(this._repository);

  @override
  Future<Either<Failure, List<Comment>>> call(String commentId) async {
    return await _repository.getReplies(commentId);
  }
}
