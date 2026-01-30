import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

part 'get_trending_movies.freezed.dart';

@freezed
abstract class TrendingParams with _$TrendingParams {
  const factory TrendingParams({
    @Default('all') String type,
    @Default(1) int page,
  }) = _TrendingParams;
}

@injectable
class GetTrendingMovies implements UseCase<List<Movie>, TrendingParams> {
  final MovieRepository _repository;

  GetTrendingMovies(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> call(TrendingParams params) async {
    return await _repository.getTrendingMovies(
      type: params.type,
      page: params.page,
    );
  }
}
