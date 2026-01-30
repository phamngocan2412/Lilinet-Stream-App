import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';
import '../bloc/video_player_state.dart';
import 'package:lilinet_app/features/settings/domain/entities/app_settings.dart';
import '../../../comments/presentation/widgets/collapsed_comment_view.dart';

const kOrangeColor = Color(0xFFC6A664);
const kGreenVIP = Color(0xFF43A047);
const kBlueVIP = Color(0xFF1E88E5);

class ExpandedPlayerContent extends StatelessWidget {
  final VideoPlayerState state;
  final String currentServer;
  final VideoQuality defaultQuality;
  final Function(String) onServerSelected;
  final Function(
    String url,
    String? subUrl,
    String? subLang,
    Map<String, String>? headers,
  )
  onQualitySelected;
  final VoidCallback onMinimize;

  const ExpandedPlayerContent({
    super.key,
    required this.state,
    required this.currentServer,
    required this.defaultQuality,
    required this.onServerSelected,
    required this.onQualitySelected,
    required this.onMinimize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StreamingCubit, StreamingState>(
      builder: (context, streamingState) {
        String? description;
        final movie = state.movie;
        if (movie != null) {
          description = movie.description;
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Build the scrollable content
            final contentChildren = _buildContentChildren(
              context,
              streamingState,
              description,
            );

            // If height is too small, make entire content scrollable
            if (constraints.maxHeight < 400) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contentChildren,
                ),
              );
            }

            // Normal layout with split sections
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onMinimize,
              child: Column(
                children: [
                  // Top Section: Details & Controls (Scrollable)
                  Expanded(
                    flex: 4,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: contentChildren,
                    ),
                  ),

                  const Divider(height: 1, color: Colors.white24),

                  // Bottom Section: Collapsed Comment Preview (Tap to expand full sheet)
                  Expanded(
                    flex: 6,
                    child: CollapsedCommentView(
                      videoId: state.mediaId ?? 'unknown',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildContentChildren(
    BuildContext context,
    StreamingState streamingState,
    String? description,
  ) {
    return [
      // Title
      Text(
        '${state.title}${state.episodeTitle != null ? " - ${state.episodeTitle}" : ""}',
        style: const TextStyle(
          color: kOrangeColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),

      // Server Selector
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Text('Server', style: TextStyle(color: Colors.grey)),
            const SizedBox(width: 8),
            _buildVipButton(
              'VidCloud',
              kGreenVIP,
              currentServer == 'vidcloud',
              () => onServerSelected('vidcloud'),
            ),
            const SizedBox(width: 8),
            _buildVipButton(
              'UpCloud',
              kBlueVIP,
              currentServer == 'upcloud',
              () => onServerSelected('upcloud'),
            ),
            const SizedBox(width: 8),
            _buildVipButton(
              'VidStream',
              kOrangeColor,
              currentServer == 'vidstream',
              () => onServerSelected('vidstream'),
            ),
            const SizedBox(width: 8),
            _buildVipButton(
              'MixDrop',
              const Color(0xFF8E24AA),
              currentServer == 'mixdrop',
              () => onServerSelected('mixdrop'),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),

      // Quality Selector
      if (streamingState is StreamingLoaded &&
          streamingState.links.isNotEmpty) ...[
        Builder(
          builder: (context) {
            final uniqueLinks = <String, dynamic>{};
            for (var link in streamingState.links) {
              if (!uniqueLinks.containsKey(link.quality)) {
                uniqueLinks[link.quality] = link;
              }
            }
            if (uniqueLinks.length <= 1) {
              return const SizedBox.shrink();
            }

            return Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const Center(
                    child: Text(
                      "Quality: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ...uniqueLinks.entries.map((entry) {
                    final link = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kOrangeColor),
                          foregroundColor: kOrangeColor,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          String? subUrl;
                          String? subLang;
                          if (streamingState.subtitles != null &&
                              streamingState.subtitles!.isNotEmpty) {
                            try {
                              final englishSub = streamingState.subtitles!
                                  .firstWhere(
                                    (s) => s.lang.toLowerCase().contains(
                                      'english',
                                    ),
                                  );
                              subUrl = englishSub.url;
                              subLang = englishSub.lang;
                            } catch (_) {}
                          }
                          onQualitySelected(
                            link.url,
                            subUrl,
                            subLang,
                            link.headers,
                          );
                        },
                        child: Text(entry.key.toUpperCase()),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ],

      // Description
      if (description != null) ...[
        Text(
          description,
          style: const TextStyle(color: Colors.grey),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
      ],
    ];
  }

  Widget _buildVipButton(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? Border.all(color: Colors.white, width: 1)
              : Border.all(color: Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
