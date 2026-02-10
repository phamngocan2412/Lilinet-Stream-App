import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'package:lilinet_app/features/movies/domain/entities/movie.dart';
import 'package:lilinet_app/features/movies/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:lilinet_app/features/movies/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:lilinet_app/features/movies/presentation/bloc/trending_movies/trending_movies_state.dart';
import 'package:lilinet_app/features/movies/presentation/pages/home_page.dart';
import 'package:lilinet_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:lilinet_app/features/comments/presentation/widgets/home_trending_section.dart';
import 'package:lilinet_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:lilinet_app/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:lilinet_app/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:lilinet_app/core/services/miniplayer_height_notifier.dart';
import 'package:mocktail/mocktail.dart';

class MockTrendingMoviesBloc
    extends MockBloc<TrendingMoviesEvent, TrendingMoviesState>
    implements TrendingMoviesBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

// HomeTrendingCubit is a Cubit, so generic is <HomeTrendingState>
// And it doesn't take events.
class MockHomeTrendingCubit extends MockCubit<HomeTrendingState>
    implements HomeTrendingCubit {}

void main() {
  late MockTrendingMoviesBloc mockBloc;
  late MockFavoritesBloc mockFavoritesBloc;
  late MockHomeTrendingCubit mockHomeTrendingCubit;

  setUp(() {
    mockBloc = MockTrendingMoviesBloc();
    mockFavoritesBloc = MockFavoritesBloc();
    mockHomeTrendingCubit = MockHomeTrendingCubit();

    // Setup GetIt
    GetIt.instance
        .registerFactory<HomeTrendingCubit>(() => mockHomeTrendingCubit);

    // Stub HomeTrendingCubit
    when(() => mockHomeTrendingCubit.state).thenReturn(HomeTrendingInitial());
    when(() => mockHomeTrendingCubit.stream)
        .thenAnswer((_) => Stream.value(HomeTrendingInitial()));
    when(() => mockHomeTrendingCubit.loadTrendingComments())
        .thenAnswer((_) async {});

    // Stub FavoritesBloc
    when(() => mockFavoritesBloc.state)
        .thenReturn(const FavoritesState.initial());
    when(() => mockFavoritesBloc.stream)
        .thenAnswer((_) => Stream.value(const FavoritesState.initial()));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('HomePage category MovieCards have optimized memCacheWidth',
      (tester) async {
    // Arrange
    final movie = const Movie(
      id: '1',
      title: 'Anime 1',
      type: 'tv',
      poster: 'poster.jpg',
    );

    final loadedState = TrendingMoviesState.loaded(
      trending: [],
      categories: {
        'Top Anime': [movie]
      },
    );

    when(() => mockBloc.state).thenReturn(loadedState);
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(loadedState));

    // Ensure screen is large enough
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TrendingMoviesBloc>.value(value: mockBloc),
            BlocProvider<FavoritesBloc>.value(value: mockFavoritesBloc),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Act
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Assert
    expect(find.text('TOP ANIME'), findsOneWidget);

    final movieCardFinder = find.byType(MovieCard);
    expect(movieCardFinder, findsOneWidget);

    final movieCard = tester.widget<MovieCard>(movieCardFinder.first);

    final dpr = tester.view.devicePixelRatio;
    final expectedWidth = (130 * dpr).toInt();

    // This expectation should fail before the fix (it will be null)
    expect(movieCard.memCacheWidth, expectedWidth,
        reason: 'memCacheWidth should be optimized for 130 logical width');

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
