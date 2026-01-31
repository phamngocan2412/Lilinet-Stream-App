import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/errors/failures.dart';
import 'package:lilinet_app/features/movies/data/datasources/movie_local_datasource.dart';
import 'package:lilinet_app/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:lilinet_app/features/movies/data/models/movie_model.dart';
import 'package:lilinet_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockMovieLocalDataSource extends Mock implements MovieLocalDataSource {}

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('getTrendingMovies', () {
    final tMovieModelList = [
      const MovieModel(
        id: '1',
        title: 'Test Movie',
        image: 'https://example.com/image.jpg',
        type: 'movie',
      ),
    ];

    final tMovieListResponse = MovieListResponse(results: tMovieModelList);

    test('should return List<Movie> when remote call is successful', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getTrendingMovies(page: 1),
      ).thenAnswer((_) async => tMovieListResponse);
      when(
        () => mockLocalDataSource.cacheTrendingMovies(any()),
      ).thenAnswer((_) async => {});

      // act
      final result = await repository.getTrendingMovies();

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected Right, got Left'), (movies) {
        expect(movies.length, 1);
        expect(movies.first.id, '1');
        expect(movies.first.title, 'Test Movie');
      });
      verify(() => mockRemoteDataSource.getTrendingMovies(page: 1)).called(1);
    });

    test(
      'should cache data locally when remote call is successful and page is 1',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTrendingMovies(page: 1),
        ).thenAnswer((_) async => tMovieListResponse);
        when(
          () => mockLocalDataSource.cacheTrendingMovies(any()),
        ).thenAnswer((_) async => {});

        // act
        await repository.getTrendingMovies(page: 1);

        // assert
        verify(
          () => mockLocalDataSource.cacheTrendingMovies(tMovieListResponse),
        ).called(1);
      },
    );

    test('should NOT cache data when page is not 1', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getTrendingMovies(page: 2),
      ).thenAnswer((_) async => tMovieListResponse);

      // act
      await repository.getTrendingMovies(page: 2);

      // assert
      verifyNever(() => mockLocalDataSource.cacheTrendingMovies(any()));
    });

    test(
      'should return Failure when remote call throws DioException (timeout)',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTrendingMovies(page: 1)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // act
        final result = await repository.getTrendingMovies();

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail('Expected Left, got Right'),
        );
      },
    );

    test(
      'should return Failure when remote call throws DioException (404)',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTrendingMovies(page: 1)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          ),
        );

        // act
        final result = await repository.getTrendingMovies();

        // assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<Failure>());
        }, (_) => fail('Expected Left, got Right'));
      },
    );

    test(
      'should return Failure when remote call throws generic Exception',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTrendingMovies(page: 1),
        ).thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.getTrendingMovies();

        // assert
        expect(result.isLeft(), true);
      },
    );
  });

  group('getMovieDetails', () {
    const tMovieId = 'movie-123';
    final tMovieModel = const MovieModel(
      id: tMovieId,
      title: 'Test Movie',
      image: 'https://example.com/image.jpg',
      type: 'movie',
    );

    test('should return Movie when remote call is successful', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getMovieDetails(tMovieId),
      ).thenAnswer((_) async => tMovieModel);
      when(
        () => mockLocalDataSource.cacheMovieDetails(any(), any()),
      ).thenAnswer((_) async => {});

      // act
      final result = await repository.getMovieDetails(tMovieId);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected Right, got Left'), (movie) {
        expect(movie.id, tMovieId);
        expect(movie.title, 'Test Movie');
      });
      verify(() => mockRemoteDataSource.getMovieDetails(tMovieId)).called(1);
    });

    test(
      'should cache movie details when remote call is successful (not fastMode)',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getMovieDetails(tMovieId),
        ).thenAnswer((_) async => tMovieModel);
        when(
          () => mockLocalDataSource.cacheMovieDetails(any(), any()),
        ).thenAnswer((_) async => {});

        // act
        await repository.getMovieDetails(tMovieId, fastMode: false);

        // assert
        verify(
          () => mockLocalDataSource.cacheMovieDetails(tMovieId, tMovieModel),
        ).called(1);
      },
    );

    test('should NOT cache movie details when fastMode is true', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getMovieDetails(tMovieId),
      ).thenAnswer((_) async => tMovieModel);

      // act
      await repository.getMovieDetails(tMovieId, fastMode: true);

      // assert
      verifyNever(() => mockLocalDataSource.cacheMovieDetails(any(), any()));
    });

    test(
      'should return cached Movie when remote call fails and cache exists',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getMovieDetails(tMovieId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );
        when(
          () => mockLocalDataSource.getCachedMovieDetails(tMovieId),
        ).thenReturn(tMovieModel);

        // act
        final result = await repository.getMovieDetails(tMovieId);

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected Right, got Left'), (movie) {
          expect(movie.id, tMovieId);
        });
        verify(
          () => mockLocalDataSource.getCachedMovieDetails(tMovieId),
        ).called(1);
      },
    );

    test(
      'should return Failure when remote call fails and NO cache exists',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getMovieDetails(tMovieId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );
        when(
          () => mockLocalDataSource.getCachedMovieDetails(tMovieId),
        ).thenReturn(null);

        // act
        final result = await repository.getMovieDetails(tMovieId);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail('Expected Left, got Right'),
        );
      },
    );

    test(
      'should pass provider and type parameters to remote datasource',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getMovieDetails(
            tMovieId,
            provider: 'goku',
            type: 'movie',
          ),
        ).thenAnswer((_) async => tMovieModel);
        when(
          () => mockLocalDataSource.cacheMovieDetails(any(), any()),
        ).thenAnswer((_) async => {});

        // act
        await repository.getMovieDetails(
          tMovieId,
          provider: 'goku',
          type: 'movie',
        );

        // assert
        verify(
          () => mockRemoteDataSource.getMovieDetails(
            tMovieId,
            provider: 'goku',
            type: 'movie',
          ),
        ).called(1);
      },
    );
  });

  group('searchMovies', () {
    const tQuery = 'inception';
    final tMovieModelList = [
      const MovieModel(
        id: '1',
        title: 'Inception',
        image: 'https://example.com/inception.jpg',
        type: 'movie',
      ),
    ];

    final tMovieListResponse = MovieListResponse(results: tMovieModelList);

    test('should return List<Movie> when search is successful', () async {
      // arrange
      when(
        () => mockRemoteDataSource.searchMovies(tQuery, page: 1),
      ).thenAnswer((_) async => tMovieListResponse);

      // act
      final result = await repository.searchMovies(tQuery);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected Right, got Left'), (movies) {
        expect(movies.length, 1);
        expect(movies.first.title, 'Inception');
      });
    });

    test('should return Failure when search throws DioException', () async {
      // arrange
      when(() => mockRemoteDataSource.searchMovies(tQuery, page: 1)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      // act
      final result = await repository.searchMovies(tQuery);

      // assert
      expect(result.isLeft(), true);
    });
  });

  group('getCachedTrendingMovies', () {
    test('should return cached movies when cache exists', () {
      // arrange
      final tMovieModelList = [
        const MovieModel(
          id: '1',
          title: 'Cached Movie',
          image: 'https://example.com/image.jpg',
          type: 'movie',
        ),
      ];
      final tCachedResponse = MovieListResponse(results: tMovieModelList);
      when(
        () => mockLocalDataSource.getCachedTrendingMovies(),
      ).thenReturn(tCachedResponse);

      // act
      final result = repository.getCachedTrendingMovies();

      // assert
      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.title, 'Cached Movie');
    });

    test('should return null when cache is empty', () {
      // arrange
      when(
        () => mockLocalDataSource.getCachedTrendingMovies(),
      ).thenReturn(null);

      // act
      final result = repository.getCachedTrendingMovies();

      // assert
      expect(result, isNull);
    });
  });

  group('getCachedMovieDetails', () {
    const tMovieId = 'movie-123';

    test('should return cached movie when cache exists', () {
      // arrange
      final tMovieModel = const MovieModel(
        id: tMovieId,
        title: 'Cached Movie',
        image: 'https://example.com/image.jpg',
        type: 'movie',
      );
      when(
        () => mockLocalDataSource.getCachedMovieDetails(tMovieId),
      ).thenReturn(tMovieModel);

      // act
      final result = repository.getCachedMovieDetails(tMovieId);

      // assert
      expect(result, isNotNull);
      expect(result!.id, tMovieId);
      expect(result.title, 'Cached Movie');
    });

    test('should return null when cache is empty', () {
      // arrange
      when(
        () => mockLocalDataSource.getCachedMovieDetails(tMovieId),
      ).thenReturn(null);

      // act
      final result = repository.getCachedMovieDetails(tMovieId);

      // assert
      expect(result, isNull);
    });
  });
}
