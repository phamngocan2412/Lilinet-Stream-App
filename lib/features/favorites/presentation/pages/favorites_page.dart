import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/app_state_widgets.dart';
import '../../../movies/presentation/widgets/movie_card.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';
import '../../../explore/presentation/widgets/category_chip.dart';
import '../../domain/entities/favorite.dart';
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
                context.read<FavoritesBloc>().add(const LoadFavorites());
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
                  return const AppLoadingState();
                }

                if (state is FavoritesError) {
                  return AppErrorState(
                    message: state.message,
                    onRetry: () {
                      context.read<FavoritesBloc>().add(const LoadFavorites());
                    },
                  );
                }

                if (state is FavoritesLoaded) {
                  if (state.favorites.isEmpty) {
                    return const AppEmptyState(
                      icon: Icons.favorite_border,
                      message: 'No favorites yet\nStart adding movies!',
                    );
                  }

                  return _FavoritesContentView(favorites: state.favorites);
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

class _FavoritesContentView extends StatefulWidget {
  final List<Favorite> favorites;

  const _FavoritesContentView({required this.favorites});

  @override
  State<_FavoritesContentView> createState() => _FavoritesContentViewState();
}

class _FavoritesContentViewState extends State<_FavoritesContentView> {
  String _selectedFolder = 'All';
  late List<String> _folders;
  late List<Favorite> _filteredFavorites;

  @override
  void initState() {
    super.initState();
    _computeDerivedState();
  }

  @override
  void didUpdateWidget(covariant _FavoritesContentView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.favorites, oldWidget.favorites)) {
      _computeDerivedState();
    }
  }

  void _computeDerivedState() {
    _folders = {
      'All',
      ...widget.favorites.map((f) => f.folder).toSet().toList()..sort(),
    }.toList();

    _filterFavorites();
  }

  void _filterFavorites() {
    _filteredFavorites = _selectedFolder == 'All'
        ? widget.favorites
        : widget.favorites.where((f) => f.folder == _selectedFolder).toList();
  }

  void _onFolderSelected(String folder) {
    if (_selectedFolder != folder) {
      setState(() {
        _selectedFolder = folder;
        _filterFavorites();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: Calculate optimal cache width for grid items to avoid LayoutBuilder overhead
    // and reduce memory usage.
    // (Screen Width - Padding) / Columns * Pixel Density
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final memCacheWidth = ((screenWidth - 32) / 2 * devicePixelRatio).ceil();

    return Column(
      children: [
        // Folder Filter List
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _folders.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final folder = _folders[index];
              return CategoryChip(
                label: folder,
                isSelected: folder == _selectedFolder,
                onTap: () => _onFolderSelected(folder),
              );
            },
          ),
        ),

        // Favorites Grid
        Expanded(
          child: _filteredFavorites.isEmpty
              ? const AppEmptyState(
                  icon: Icons.folder_off_outlined,
                  message: 'No items in this folder',
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoritesBloc>().add(const LoadFavorites());
                  },
                  child: ListenableBuilder(
                    listenable: getIt<MiniplayerHeightNotifier>(),
                    builder: (context, _) {
                      final miniplayerHeight =
                          getIt<MiniplayerHeightNotifier>().height;

                      return GridView.builder(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: miniplayerHeight + 16,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: _filteredFavorites.length,
                        itemBuilder: (context, index) {
                          final favorite = _filteredFavorites[index];

                          // Convert Favorite to Movie for MovieCard
                          final movie = Movie(
                            id: favorite.movieId,
                            title: favorite.movieTitle ?? 'Unknown',
                            poster: favorite.moviePoster,
                            type: favorite.movieType ?? 'Movie',
                          );

                          return MovieCard(
                            movie: movie,
                            memCacheWidth: memCacheWidth,
                            onTap: () {
                              context.push(
                                '/movie/${movie.id}?type=${movie.type}',
                                extra: movie,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
