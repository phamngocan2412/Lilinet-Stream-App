import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/streaming_response.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetStreamingLinks {
  final MovieRepository _repository;

  GetStreamingLinks(this._repository);

  Future<Either<Failure, StreamingResponse>> call({
    required String episodeId,
    required String mediaId,
    String? server,
  }) async {
    return await _repository.getStreamingLinks(
      episodeId: episodeId,
      mediaId: mediaId,
      server: server,
    );
  }
}
