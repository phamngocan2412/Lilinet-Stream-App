import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/comment.dart';
import '../repositories/comment_repository.dart';

@injectable
class GetComments implements UseCase<List<Comment>, String> {
  final CommentRepository _repository;

  GetComments(this._repository);

  @override
  Future<Either<Failure, List<Comment>>> call(String videoId) async {
    return await _repository.getComments(videoId);
  }
}
