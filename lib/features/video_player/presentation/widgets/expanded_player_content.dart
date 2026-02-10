import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';
import '../bloc/video_player_state.dart';
import 'player_title_section.dart';
import 'player_info_section.dart';
import 'player_recommendations_section.dart';
import 'player_comments_section.dart';

const kOrangeColor = Color(0xFFC6A664);
const kGreenVIP = Color(0xFF43A047);
const kBlueVIP = Color(0xFF1E88E5);

class ExpandedPlayerContent extends StatelessWidget {
  final VideoPlayerState state;
  final VoidCallback onMinimize;
  final VoidCallback onDownload;

  const ExpandedPlayerContent({
    super.key,
    required this.state,
    required this.onMinimize,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StreamingCubit, StreamingState>(
      builder: (context, streamingState) {
        String? description = state.movie?.description;

        return LayoutBuilder(
          builder: (context, constraints) {
            final contentChildren = _buildContentChildren(
              context,
              streamingState,
              description,
            );

            if (constraints.maxHeight < 400) {
              return GestureDetector(
                // FIX: Absorb tap gestures in content area to prevent miniplayer
                // from minimizing when tapping on empty spaces in the content
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // Empty onTap to absorb the gesture without any action
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: contentChildren,
                  ),
                ),
              );
            }

            return GestureDetector(
              // FIX: Absorb tap gestures in content area to prevent miniplayer
              // from minimizing when tapping on empty spaces in the content
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Empty onTap to absorb the gesture without any action
                // This prevents the gesture from propagating to miniplayer
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        ...contentChildren,
                        const SizedBox(height: 24),
                        if (state.mediaId != null)
                          PlayerCommentsSection(
                            mediaId: state.mediaId!,
                          ),
                        if (state.mediaId == null)
                          const Text(
                            'Comments will appear once the video loads.',
                            style: TextStyle(color: Colors.white54),
                          ),
                        if (state.mediaId != null) const SizedBox(height: 24),
                        if (state.movie?.recommendations != null &&
                            state.movie!.recommendations!.isNotEmpty) ...[
                          PlayerRecommendationsSection(
                            recommendations: state.movie!.recommendations!,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ],
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
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PlayerTitleSection(
              title: state.title,
              episodeTitle: state.episodeTitle,
            ),
          ),
          IconButton(
            onPressed: onDownload,
            icon: const Icon(Icons.download_rounded),
            color: Colors.white,
            tooltip: 'Download',
          ),
        ],
      ),
      const SizedBox(height: 16),
      PlayerInfoSection(description: description),
    ];
  }
}
