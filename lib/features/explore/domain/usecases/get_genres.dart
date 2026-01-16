import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/genre.dart';
import '../repositories/explore_repository.dart';

@lazySingleton
class GetGenres {
  final ExploreRepository repository;

  GetGenres(this.repository);

  Future<Either<Failure, List<Genre>>> call() async {
    return await repository.getGenres();
  }
}
