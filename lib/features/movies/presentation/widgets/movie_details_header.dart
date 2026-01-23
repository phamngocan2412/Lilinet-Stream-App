import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/movie.dart';

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;
  final bool isLoading;
  final VoidCallback? onPlayPressed;

  const MovieDetailsHeader({
    super.key,
    required this.movie,
    required this.isLoading,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 450,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'poster_${movie.id}',
              child: AppCachedImage(
                imageUrl: movie.poster ?? movie.cover ?? '',
                fit: BoxFit.cover,
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    Theme.of(context).colorScheme.surface,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            // Content Overlay
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: 1.0,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withOpacity(0.8),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isLoading)
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (movie.releaseDate != null) ...[
                          Text(
                            movie.releaseDate!.split('-').first,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '•',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (movie.duration != null) ...[
                          Text(
                            movie.duration!,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '•',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            movie.type == 'TV Series' ? 'TV' : 'HD',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  if (!isLoading)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: onPlayPressed,
                        icon: const Icon(Icons.play_arrow_rounded, size: 28),
                        label: const Text(
                          'Play Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
