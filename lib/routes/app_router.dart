import 'package:go_router/go_router.dart';
import '../features/main/presentation/pages/main_screen.dart';
import '../features/main/presentation/pages/scaffold_with_player.dart';
import '../features/movies/presentation/pages/movie_details_page.dart';
import '../features/movies/domain/entities/movie.dart';
import '../features/movies/presentation/pages/search_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/explore/presentation/pages/genre_movies_page.dart';
import '../features/downloads/presentation/pages/downloads_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithPlayer(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const MainScreen(),
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/downloads',
            name: 'downloads',
            builder: (context, state) => const DownloadsPage(),
          ),
          GoRoute(
            path: '/genre/:id',
            name: 'genreMovies',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final name = state.uri.queryParameters['name'] ?? 'Movies';
              return GenreMoviesPage(genreId: id, genreName: name);
            },
          ),
          GoRoute(
            path: '/movie/:id',
            name: 'movieDetails',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final type = state.uri.queryParameters['type'] ?? 'TV Series';
              final episodeId = state.uri.queryParameters['episode'];
              final timestampStr = state.uri.queryParameters['time'];
              final timestamp = timestampStr != null
                  ? int.tryParse(timestampStr)
                  : null;

              // Check if a Movie object was passed in 'extra'
              final moviePreview = state.extra is Movie
                  ? state.extra as Movie
                  : null;
              return MovieDetailsPage(
                movieId: id,
                mediaType: type,
                moviePreview: moviePreview,
                initialEpisodeId: episodeId,
                initialTimestamp: timestamp,
              );
            },
          ),
        ],
      ),
    ],
  );
}
