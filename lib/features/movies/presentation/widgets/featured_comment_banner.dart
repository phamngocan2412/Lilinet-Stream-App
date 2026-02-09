import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../injection_container.dart';

class FeaturedCommentBanner extends StatelessWidget {
  const FeaturedCommentBanner({super.key});

  // Simulated API call - In real app, this goes to Repository/UseCase
  Future<Map<String, dynamic>?> _fetchFeaturedComment() async {
    try {
      final dio = getIt<Dio>();

      // Calculate start of today (00:00:00)
      final now = DateTime.now();
      final startOfDay = DateTime(
        now.year,
        now.month,
        now.day,
      ).toIso8601String();

      // Example API call
      // In real backend, you'd handle the '>= startOfDay' logic on the server
      // GET /comments/featured?since=2023-10-27T00:00:00
      try {
        final response = await dio.get(
          '/comments/featured-today',
          queryParameters: {'since': startOfDay},
        );

        if (response.statusCode == 200 && response.data != null) {
          final data = response.data;
          if (data['exists'] == true && data['comment'] != null) {
            return data['comment'];
          }
        }
      } catch (_) {
        // Fallback for DEMO/TESTING if API fails
        return {
          'user_name': 'AnimeFan123',
          'movie_name': 'One Piece',
          'episode_number': '1071',
          'movie_id': '209867', // Use a real ID if possible
          'episode_id': '1',
          'content': 'Gear 5 animation is absolutely legendary! 🔥',
          'movie_type': 'TV Series',
        };
      }
      return null;
    } catch (e) {
      // Fail silently (hide banner) on error
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _fetchFeaturedComment(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        final comment = snapshot.data!;
        final l10n = AppLocalizations.of(context)!;

        final userName = comment['user_name'] ?? l10n.someone;
        final movieName = comment['movie_name'] ?? l10n.unknownMovie;
        final episode = comment['episode_number'] ?? '1';
        final content = comment['content'] ?? '';
        final movieId = comment['movie_id'];
        // final episodeId = comment['episode_id'];
        final movieType = comment['movie_type'] ?? 'tv'; // Default for nav

        return GestureDetector(
          onTap: () {
            if (movieId != null) {
              // Normalize type for API
              final typeParam =
                  movieType.toString().toLowerCase().contains('tv') ||
                          movieType.toString().toLowerCase().contains('series')
                      ? 'tv'
                      : 'movie';

              // Navigate to player/details
              // If you have a direct player route:
              // context.push('/player/$movieId/$episodeId');

              // Or navigate to Details page first
              context.push('/movie/$movieId?type=$typeParam');
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.tertiaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_chat_unread_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: l10n.justCommentedOn),
                            TextSpan(
                              text: movieName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (episode != null) ...[
                              const TextSpan(text: ' - '),
                              TextSpan(
                                text: l10n.episodeNumber(episode.toString()),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '"$content"',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.8),
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white54),
              ],
            ),
          ),
        );
      },
    );
  }
}
