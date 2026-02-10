import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../movies/domain/entities/movie.dart';

class PlayerRecommendationsSection extends StatefulWidget {
  final List<Movie> recommendations;

  const PlayerRecommendationsSection({
    super.key,
    required this.recommendations,
  });

  @override
  State<PlayerRecommendationsSection> createState() =>
      _PlayerRecommendationsSectionState();
}

class _PlayerRecommendationsSectionState
    extends State<PlayerRecommendationsSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final recommendations = widget.recommendations;

    if (recommendations.isEmpty) return const SizedBox.shrink();

    // Calculate optimal cache width for performance
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final itemWidth = (screenWidth - 32 - 12) / 2;
    final memCacheWidth = (itemWidth * devicePixelRatio).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You May Also Like',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
