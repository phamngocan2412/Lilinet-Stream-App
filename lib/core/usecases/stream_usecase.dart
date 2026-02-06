import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class StreamUseCase<ResultType, Params> {
  Stream<Either<Failure, ResultType>> call(Params params);
}
