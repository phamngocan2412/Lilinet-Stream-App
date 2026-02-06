import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call(Params params);
}

abstract class NoParamsUseCase<ResultType> {
  Future<Either<Failure, ResultType>> call();
}
