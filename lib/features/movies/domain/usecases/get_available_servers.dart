import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetAvailableServers {
  final MovieRepository _repository;

  GetAvailableServers(this._repository);

  Future<Either<Failure, List<String>>> call({
    required String episodeId,
    required String mediaId,
    String provider = 'flixhq',
  }) async {
    return await _repository.getAvailableServers(
      episodeId: episodeId,
      mediaId: mediaId,
      provider: provider,
    );
  }
}
