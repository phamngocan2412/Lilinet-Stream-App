import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/loading_indicator.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final mediaQuery = MediaQuery.of(context);

    return SliverAppBar(
      expandedHeight: 450,
      pinned: true,
      backgroundColor: colorScheme.surface,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
            tooltip: AppLocalizations.of(context)!.back,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: movie.poster ?? movie.cover ?? '',
              fit: BoxFit.cover,
              memCacheWidth:
                  (mediaQuery.size.width * mediaQuery.devicePixelRatio).toInt(),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colorScheme.surface.withValues(alpha: 0.5),
                    colorScheme.surface,
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
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: colorScheme.surface.withValues(alpha: 0.8),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isLoading)
                    const LoadingIndicator(size: 30)
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (movie.releaseDate != null) ...[
                          Text(
                            movie.releaseDate!.split('-').first,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  )
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '•',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  )
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.3),
                                ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (movie.duration != null) ...[
                          Text(
                            movie.duration!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  )
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '•',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  )
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.3),
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
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (movie.type.toLowerCase().contains('tv') ||
                                    movie.type.toLowerCase().contains('series'))
                                ? 'TV'
                                : 'HD',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
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
                      child: Semantics(
                        label: 'Play ${movie.title} now',
                        button: true,
                        child: FilledButton.icon(
                          onPressed: onPlayPressed,
                          icon: const Icon(Icons.play_arrow_rounded, size: 28),
                          label: Text(
                            'Play Now',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
