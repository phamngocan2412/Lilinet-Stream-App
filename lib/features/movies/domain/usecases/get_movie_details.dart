import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetMovieDetails {
  final MovieRepository _repository;

  GetMovieDetails(this._repository);

  Future<Either<Failure, Movie>> call(GetMovieDetailsParams params) async {
    return await _repository.getMovieDetails(
      params.id, // ID
      type: params.type,
      provider: params.provider,
      fastMode: params.fastMode,
    );
  }
}

class GetMovieDetailsParams extends Equatable {
  final String id;
  final String type; // Made type required as it was in the original call method
  final String? provider;
  final bool fastMode;

  const GetMovieDetailsParams({
    required this.id,
    required this.type,
    this.provider,
    this.fastMode = false,
  });

  @override
  List<Object?> get props => [id, type, provider, fastMode];
}
