import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritesView();
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is Authenticated) {
            // Add a small delay to ensure auth state is propagated and available
            // to the favorites repository (Supabase client)
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.read<FavoritesBloc>().add(LoadFavorites());
              }
            });
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated ||
                authState is AuthInitial ||
                authState is AuthError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sign in to view your favorites',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AuthDialog(),
                        );
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Sign In'),
                    ),
                  ],
                ),
              );
            }

            return BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const Center(child: LoadingIndicator());
                }

                if (state is FavoritesError) {
                  return Center(
                    child: AppErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<FavoritesBloc>().add(LoadFavorites());
                      },
                    ),
                  );
                }

                if (state is FavoritesLoaded) {
                  if (state.favorites.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.favorite_border,
                      message: 'No favorites yet\nStart adding movies!',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<FavoritesBloc>().add(LoadFavorites());
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        final favorite = state.favorites[index];

                        // Convert Favorite to Movie for MovieCard
                        final movie = Movie(
                          id: favorite.movieId,
                          title: favorite.movieTitle ?? 'Unknown',
                          poster: favorite.moviePoster,
                          type: favorite.movieType ?? 'Movie',
                        );

                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            context.push(
                              '/movie/${movie.id}?type=${movie.type}',
                              extra: movie,
                            );
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
