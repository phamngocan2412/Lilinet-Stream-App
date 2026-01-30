import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/comment_repository.dart';

@injectable
class LikeComment implements UseCase<void, String> {
  final CommentRepository _repository;

  LikeComment(this._repository);

  @override
  Future<Either<Failure, void>> call(String commentId) async {
    return await _repository.likeComment(commentId);
  }
}
