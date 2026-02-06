import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lilinet_app/core/errors/failures.dart';
import 'package:lilinet_app/features/movies/domain/entities/movie.dart';
import 'package:lilinet_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:lilinet_app/features/movies/domain/usecases/get_trending_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetTrendingMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetTrendingMovies(mockRepository);
  });

  group('GetTrendingMovies', () {
    final tMovies = [
      const Movie(
        id: '1',
        title: 'Test Movie 1',
        rating: 8.5,
        poster: 'https://example.com/poster1.jpg',
        cover: 'https://example.com/backdrop1.jpg',
        description: 'Test description 1',
        genres: ['Action', 'Drama'],
        releaseDate: '2024-01-01',
        duration: '120 min',
        type: 'Movie',
        casts: [],
        recommendations: [],
      ),
      const Movie(
        id: '2',
        title: 'Test Movie 2',
        rating: 7.5,
        poster: 'https://example.com/poster2.jpg',
        cover: 'https://example.com/backdrop2.jpg',
        description: 'Test description 2',
        genres: ['Comedy'],
        releaseDate: '2024-02-01',
        duration: '90 min',
        type: 'Movie',
        casts: [],
        recommendations: [],
      ),
    ];

    final tParams = const TrendingParams(type: 'all', page: 1);

    test('should get trending movies from repository', () async {
      // Arrange
      when(
        () => mockRepository.getTrendingMovies(
          type: any(named: 'type'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => Right(tMovies));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, Right(tMovies));
      verify(
        () => mockRepository.getTrendingMovies(type: 'all', page: 1),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should get trending movies with different type', () async {
      // Arrange
      const movieParams = TrendingParams(type: 'movie', page: 1);
      when(
        () => mockRepository.getTrendingMovies(
          type: any(named: 'type'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => Right(tMovies));

      // Act
      final result = await useCase(movieParams);

      // Assert
      expect(result, Right(tMovies));
      verify(
        () => mockRepository.getTrendingMovies(type: 'movie', page: 1),
      ).called(1);
    });

    test('should get trending movies with different page', () async {
      // Arrange
      const pageParams = TrendingParams(type: 'all', page: 2);
      when(
        () => mockRepository.getTrendingMovies(
          type: any(named: 'type'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => Right(tMovies));

      // Act
      final result = await useCase(pageParams);

      // Assert
      expect(result, Right(tMovies));
      verify(
        () => mockRepository.getTrendingMovies(type: 'all', page: 2),
      ).called(1);
    });

    test('should return Failure when repository fails', () async {
      // Arrange
      const failure = Failure.server('Server error');
      when(
        () => mockRepository.getTrendingMovies(
          type: any(named: 'type'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, const Left(failure));
      verify(
        () => mockRepository.getTrendingMovies(type: 'all', page: 1),
      ).called(1);
    });

    test('should use default values when not provided', () async {
      // Arrange
      final defaultParams = const TrendingParams();
      when(
        () => mockRepository.getTrendingMovies(
          type: any(named: 'type'),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async => Right(tMovies));

      // Act
      await useCase(defaultParams);

      // Assert
      verify(
        () => mockRepository.getTrendingMovies(type: 'all', page: 1),
      ).called(1);
    });
  });
}
