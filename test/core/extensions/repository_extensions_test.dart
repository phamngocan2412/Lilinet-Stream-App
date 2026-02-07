import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/errors/failures.dart';
import 'package:lilinet_app/core/extensions/repository_extensions.dart';
import 'package:dio/dio.dart';

// Create a dummy repository class since safeCall is an extension on Object
class TestRepository {}

void main() {
  late TestRepository repository;

  setUp(() {
    repository = TestRepository();
  });

  group('safeCall', () {
    test(
        'should catch generic exception and return generic failure without sensitive details',
        () async {
      // Setup: A function that throws a sensitive exception
      const sensitiveMessage =
          'Database connection failed: user=admin password=secret';

      final result = await repository.safeCall(() async {
        throw Exception(sensitiveMessage);
      });

      result.fold(
        (failure) {
          // Expect failure to be a ServerFailure
          expect(failure, isA<ServerFailure>());
          final serverFailure = failure as ServerFailure;

          // Verify that sensitive details are NOT leaked
          expect(serverFailure.message, isNot(contains(sensitiveMessage)));
          expect(serverFailure.message,
              equals('An unexpected error occurred. Please try again later.'));
        },
        (_) => fail('Should return Left(Failure)'),
      );
    });

    test(
        'should catch DioException and return generic failure without leaking URL',
        () async {
      const sensitiveUrl = 'https://api.example.com/users/123/token=SECRET';

      final result = await repository.safeCall(() async {
        throw DioException(
          requestOptions: RequestOptions(path: sensitiveUrl),
          message: 'Http status error [404] uri: $sensitiveUrl',
          type: DioExceptionType.unknown,
        );
      });

      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          final serverFailure = failure as ServerFailure;

          // Verify that URL is NOT leaked
          expect(serverFailure.message, isNot(contains(sensitiveUrl)));
          expect(serverFailure.message,
              equals('An unexpected network error occurred.'));
        },
        (_) => fail('Should return Left(Failure)'),
      );
    });
  });
}
