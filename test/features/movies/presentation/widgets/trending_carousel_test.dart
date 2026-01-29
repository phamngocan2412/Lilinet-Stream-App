import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/widgets/cached_image.dart';
import 'package:lilinet_app/features/movies/domain/entities/movie.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/trending_carousel.dart';

void main() {
  testWidgets('TrendingCarousel passes memCacheWidth to AppCachedImage',
      (WidgetTester tester) async {
    // Arrange
    final movies = [
      const Movie(
        id: '1',
        title: 'Test Movie',
        type: 'movie',
        poster: 'https://example.com/poster.jpg',
        cover: 'https://example.com/cover.jpg',
        description: 'Test Description',
        genres: ['Action'],
      ),
    ];
    const memCacheWidth = 500;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrendingCarousel(
            movies: movies,
            onMovieTap: (_) {},
            memCacheWidth: memCacheWidth,
          ),
        ),
      ),
    );

    // Assert
    final appCachedImageFinder = find.byType(AppCachedImage);
    expect(appCachedImageFinder, findsOneWidget);

    final appCachedImage = tester.widget<AppCachedImage>(appCachedImageFinder);
    expect(appCachedImage.memCacheWidth, memCacheWidth);
  });
}
