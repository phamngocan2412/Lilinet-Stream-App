
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lilinet_app/core/widgets/cached_image.dart';

void main() {
  testWidgets('AppCachedImage uses LayoutBuilder to calculate memCacheWidth',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';
    const double containerWidth = 200.0;
    const double devicePixelRatio = 3.0;

    // We use MediaQuery to simulate device pixel ratio
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(devicePixelRatio: devicePixelRatio),
        child: const MaterialApp(
          home: Center(
            child: SizedBox(
              width: containerWidth,
              height: 300,
              child: AppCachedImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                // We pass width: null to trigger LayoutBuilder usage (or explicitly check behavior)
                // AppCachedImage signature: width and height are optional.
              ),
            ),
          ),
        ),
      ),
    );

    // Find CachedNetworkImage
    final cachedImageFinder = find.byType(CachedNetworkImage);
    expect(cachedImageFinder, findsOneWidget);

    final CachedNetworkImage cachedImage =
        tester.widget(cachedImageFinder) as CachedNetworkImage;

    // Expected calculation: containerWidth * devicePixelRatio
    // 200 * 3.0 = 600
    final expectedCacheWidth = (containerWidth * devicePixelRatio).toInt();

    expect(cachedImage.memCacheWidth, equals(expectedCacheWidth));
  });

  testWidgets('AppCachedImage uses provided width if available',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';
    const double explicitWidth = 150.0;
    const double devicePixelRatio = 2.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(devicePixelRatio: devicePixelRatio),
        child: const MaterialApp(
          home: Center(
            child: AppCachedImage(
              imageUrl: imageUrl,
              width: explicitWidth,
            ),
          ),
        ),
      ),
    );

    final cachedImageFinder = find.byType(CachedNetworkImage);
    final CachedNetworkImage cachedImage =
        tester.widget(cachedImageFinder) as CachedNetworkImage;

    // Expected: explicitWidth * devicePixelRatio
    // 150 * 2.0 = 300
    final expectedCacheWidth = (explicitWidth * devicePixelRatio).toInt();

    expect(cachedImage.memCacheWidth, equals(expectedCacheWidth));
  });

  testWidgets('AppCachedImage falls back to default if unbounded',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';
    const double devicePixelRatio = 2.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(devicePixelRatio: devicePixelRatio),
        child: const MaterialApp(
          home: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppCachedImage(
                  imageUrl: imageUrl,
                  // No width, unbounded horizontal constraint from Row + SingleChildScrollView
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final cachedImageFinder = find.byType(CachedNetworkImage);
    final CachedNetworkImage cachedImage =
        tester.widget(cachedImageFinder) as CachedNetworkImage;

    // Expected: 700 (fallback)
    expect(cachedImage.memCacheWidth, equals(700));
  });

  testWidgets('AppCachedImage skips LayoutBuilder when memCacheWidth is provided',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: AppCachedImage(
          imageUrl: imageUrl,
          memCacheWidth: 200,
        ),
      ),
    );

    // Should NOT find LayoutBuilder
    expect(find.byType(LayoutBuilder), findsNothing);
    // Should find CachedNetworkImage
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('AppCachedImage skips LayoutBuilder when width is finite',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: AppCachedImage(
          imageUrl: imageUrl,
          width: 100,
        ),
      ),
    );

    expect(find.byType(LayoutBuilder), findsNothing);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('AppCachedImage uses LayoutBuilder when dimensions are missing',
      (WidgetTester tester) async {
    const imageUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: AppCachedImage(
          imageUrl: imageUrl,
          // No width, no memCacheWidth
        ),
      ),
    );

    expect(find.byType(LayoutBuilder), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
