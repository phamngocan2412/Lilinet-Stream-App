import 'package:go_router/go_router.dart';
import '../features/main/presentation/pages/main_screen.dart';
import '../features/main/presentation/pages/scaffold_with_player.dart';
import '../features/movies/presentation/pages/movie_details_page.dart';
import '../features/movies/domain/entities/movie.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithPlayer(child: child, state: state);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const MainScreen(),
          ),
          GoRoute(
            path: '/movie/:id',
            name: 'movieDetails',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final type = state.uri.queryParameters['type'] ?? 'Movie';
              // Check if a Movie object was passed in 'extra'
              final moviePreview = state.extra is Movie
                  ? state.extra as Movie
                  : null;
              return MovieDetailsPage(
                movieId: id,
                mediaType: type,
                moviePreview: moviePreview,
              );
            },
          ),
        ],
      ),
    ],
  );
}
