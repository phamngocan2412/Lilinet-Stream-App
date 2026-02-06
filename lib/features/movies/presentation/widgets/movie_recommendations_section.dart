import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/movie.dart';

class MovieRecommendationsSection extends StatelessWidget {
  final List<Movie> recommendations;
  final bool showRecommendations;

  const MovieRecommendationsSection({
    super.key,
    required this.recommendations,
    required this.showRecommendations,
  });

  @override
  Widget build(BuildContext context) {
    if (!showRecommendations || recommendations.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final itemWidth = (screenWidth - 32 - 12) / 2;
    final memCacheWidth = (itemWidth * devicePixelRatio).toInt();

    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'You May Also Like',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = recommendations[index];
              return GestureDetector(
                onTap: () {
                  if (item.id.isEmpty) return;
                  context.push(
                    '/movie/${item.id}?type=${item.type}',
                    extra: item,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AppCachedImage(
                          imageUrl: item.poster ?? item.cover ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          memCacheWidth: memCacheWidth,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: recommendations.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}
