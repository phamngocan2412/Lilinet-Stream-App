// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'folder_selection_dialog.dart';

class FavoriteButton extends StatefulWidget {
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
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: Removed redundant BlocBuilder<AuthBloc, AuthState> wrapper.
    // The button doesn't change appearance based on auth state, only behavior.
    // Auth state is now checked lazily in onPressed.
    return BlocSelector<FavoritesBloc, FavoritesState, bool>(
      selector: (state) {
        if (state is FavoritesLoaded) {
          return state.isFavorite(widget.movieId);
        }
        return false;
      },
      builder: (context, isFavorite) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite
                  ? Theme.of(context).colorScheme.error // Red
                  : Theme.of(context).colorScheme.onSurface,
              size: widget.size,
            ),
            tooltip: isFavorite
                ? AppLocalizations.of(context)!.removeFromFavorites
                : AppLocalizations.of(context)!.addToFavorites,
            onPressed: () {
              _debouncer.run(() {
                if (!mounted) return;
                final authState = context.read<AuthBloc>().state;
                // ★★★ LAZY LOGIN LOGIC HERE ★★★
                if (authState is! Authenticated) {
                  // User NOT logged in → Show login dialog
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AuthDialog(
                      onLoginSuccess: () {
                        // After login success, prompt for folder then add
                        if (mounted) _showFolderSelectionAndAdd(context);
                      },
                    ),
                  );
                } else {
                  // User IS logged in
                  if (isFavorite) {
                    context.read<FavoritesBloc>().add(
                          RemoveFavoriteEvent(movieId: widget.movieId),
                        );
                  } else {
                    _showFolderSelectionAndAdd(context);
                  }
                }
              });
            },
          ),
        );
      },
    );
  }

  void _showFolderSelectionAndAdd(BuildContext context) {
    // Get existing folders from state to pass to dialog
    final state = context.read<FavoritesBloc>().state;
    List<String> folders = ['Default'];
    if (state is FavoritesLoaded) {
      final uniqueFolders = state.favorites.map((f) => f.folder).toSet();
      folders = uniqueFolders.toList()..sort();
      if (!folders.contains('Default')) folders.insert(0, 'Default');
    }

    showDialog(
      context: context,
      builder: (context) => FolderSelectionDialog(
        existingFolders: folders,
        onFolderSelected: (folder) {
          context.read<FavoritesBloc>().add(
                AddFavoriteEvent(
                  movieId: widget.movieId,
                  movieTitle: widget.movieTitle,
                  moviePoster: widget.moviePoster,
                  movieType: widget.movieType,
                  folder: folder,
                ),
              );
        },
      ),
    );
  }
}
