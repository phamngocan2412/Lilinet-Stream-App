import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
