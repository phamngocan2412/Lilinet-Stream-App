// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoriteButton extends StatelessWidget {
  final String movieId;
  final String? movieTitle;
  final String? moviePoster;
  final String? movieType;
  final double size;

  const FavoriteButton({
    super.key,
    required this.movieId,
    this.movieTitle,
    this.moviePoster,
    this.movieType,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocSelector<FavoritesBloc, FavoritesState, bool>(
          selector: (state) {
            if (state is FavoritesLoaded) {
              return state.isFavorite(movieId);
            }
            return false;
          },
          builder: (context, isFavorite) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Theme.of(context)
                            .colorScheme
                            .error // Red
                      : Theme.of(context).colorScheme.onSurface,
                  size: size,
                ),
                onPressed: () {
                  // ★★★ LAZY LOGIN LOGIC HERE ★★★
                  if (authState is! Authenticated) {
                    // User NOT logged in → Show login dialog
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AuthDialog(
                        onLoginSuccess: () {
                          // After login success, add to favorites automatically
                          context.read<FavoritesBloc>().add(
                            AddFavoriteEvent(
                              movieId: movieId,
                              movieTitle: movieTitle,
                              moviePoster: moviePoster,
                              movieType: movieType,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    // User IS logged in → Toggle favorite
                    if (isFavorite) {
                      context.read<FavoritesBloc>().add(
                        RemoveFavoriteEvent(movieId),
                      );
                    } else {
                      context.read<FavoritesBloc>().add(
                        AddFavoriteEvent(
                          movieId: movieId,
                          movieTitle: movieTitle,
                          moviePoster: moviePoster,
                          movieType: movieType,
                        ),
                      );
                    }
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
