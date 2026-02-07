import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/movie.dart';

class MovieInfoSection extends StatelessWidget {
  final Movie movie;
  final bool isLoading;

  const MovieInfoSection({
    super.key,
    required this.movie,
    required this.isLoading,
  });

  static const Map<String, String> _genreMap = {
    'Action': '28',
    'Adventure': '12',
    'Animation': '16',
    'Comedy': '35',
    'Crime': '80',
    'Documentary': '99',
    'Drama': '18',
    'Family': '10751',
    'Fantasy': '14',
    'History': '36',
    'Horror': '27',
    'Music': '10402',
    'Mystery': '9648',
    'Romance': '10749',
    'Sci-Fi': '878',
    'Science Fiction': '878',
    'TV Movie': '10770',
    'Thriller': '53',
    'War': '10752',
    'Western': '37',
    'Anime': '16',
  };

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              const SkeletonTextWidget()
            else if (movie.description != null) ...[
              Text(
                movie.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.8),
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 24),
            ],
            if (!isLoading)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: movie.genres.map((genre) {
                  final genreId = _genreMap[genre];
                  final isClickable = genreId != null;

                  return ActionChip(
                    label: Text(genre),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    onPressed: isClickable
                        ? () {
                            context.push('/genre/$genreId?name=$genre');
                          }
                        : null,
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
            if (!isLoading)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3,
                children: [
                  if (movie.rating != null)
                    InfoItemWidget(
                      label: 'Rating',
                      value: '${movie.rating!.toStringAsFixed(1)}/10',
                      icon: Icons.star_rounded,
                      iconColor: Colors.amber,
                    ),
                  if (movie.country != null)
                    InfoItemWidget(
                      label: 'Country',
                      value: movie.country!,
                      icon: Icons.public,
                      iconColor: Colors.blueAccent,
                    ),
                  if (movie.production != null)
                    InfoItemWidget(
                      label: 'Production',
                      value: movie.production!,
                      icon: Icons.business,
                      iconColor: Colors.purpleAccent,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SkeletonTextWidget extends StatelessWidget {
  const SkeletonTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 16,
          width: 300,
          color: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 250,
          color: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 8),
        Container(
          height: 16,
          width: 280,
          color: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ],
    );
  }
}

class InfoItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const InfoItemWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
