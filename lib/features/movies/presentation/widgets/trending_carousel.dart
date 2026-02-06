import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../domain/entities/movie.dart';
import '../../../../core/widgets/cached_image.dart';

class TrendingCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieTap;
  final int? memCacheWidth;

  const TrendingCarousel({
    super.key,
    required this.movies,
    required this.onMovieTap,
    this.memCacheWidth,
  });

  @override
  State<TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<TrendingCarousel> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 500, // Immersive height
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return GestureDetector(
                onTap: () => widget.onMovieTap(movie),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Fullscreen Image
                    Hero(
                      tag: 'poster_${movie.id}',
                      child: AppCachedImage(
                        imageUrl: movie.poster ?? movie.cover ?? '',
                        fit: BoxFit.cover,
                        // Optimization: Skip LayoutBuilder overhead by providing cache size explicitly
                        memCacheWidth: widget.memCacheWidth,
                      ),
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black87,
                            Colors.black,
                          ],
                          stops: [0.0, 0.5, 0.8, 1.0],
                        ),
                      ),
                    ),
                    // Text Content
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black54,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  movie.type.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (movie.rating != null) ...[
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  movie.rating!.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (movie.releaseDate != null)
                                Text(
                                  movie.releaseDate!.split('-')[0],
                                  style: const TextStyle(color: Colors.white70),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (movie.description != null)
                            Text(
                              movie.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Page Indicator
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.movies.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Colors.white24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
