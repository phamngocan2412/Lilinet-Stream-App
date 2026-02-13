import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../movies/presentation/bloc/streaming/streaming_cubit.dart';
import '../../../movies/presentation/bloc/streaming/streaming_state.dart';
import '../bloc/video_player_state.dart';
import 'player_title_section.dart';
import 'player_info_section.dart';
import 'player_recommendations_section.dart';
import 'player_comments_section.dart';
import '../../../comments/presentation/manager/comment_cubit.dart';

const kOrangeColor = Color(0xFFC6A664);
const kGreenVIP = Color(0xFF43A047);
const kBlueVIP = Color(0xFF1E88E5);

class ExpandedPlayerContent extends StatefulWidget {
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
  State<ExpandedPlayerContent> createState() => _ExpandedPlayerContentState();
}

class _ExpandedPlayerContentState extends State<ExpandedPlayerContent> {
  CommentCubit? _commentCubit;

  @override
  void initState() {
    super.initState();
    _initCubit();
  }

  void _initCubit() {
    if (widget.state.mediaId != null) {
      final mediaId = widget.state.mediaId;
      if (mediaId == null) return;

      final commentCubit = GetIt.I<CommentCubit>();
      commentCubit.loadComments(mediaId);
      _commentCubit = commentCubit;
    }
  }

  @override
  void didUpdateWidget(ExpandedPlayerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.mediaId != oldWidget.state.mediaId) {
      _commentCubit?.close();
      _commentCubit = null;
      _initCubit();
    }
  }

  @override
  void dispose() {
    _commentCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildScrollView();
    if (_commentCubit != null) {
      content = BlocProvider.value(value: _commentCubit!, child: content);
    }
    return content;
  }

  Widget _buildScrollView() {
    return BlocBuilder<StreamingCubit, StreamingState>(
      builder: (context, streamingState) {
        String? description = widget.state.movie?.description;

        return LayoutBuilder(
          builder: (context, constraints) {
            final contentChildren = _buildContentChildren(
              context,
              streamingState,
              description,
            );

            return GestureDetector(
              // FIX: Absorb tap gestures in content area to prevent miniplayer
              // from minimizing when tapping on empty spaces in the content
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Empty onTap to absorb the gesture without any action
                // This prevents the gesture from propagating to miniplayer
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(contentChildren),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  if (widget.state.mediaId != null) ...[
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: PlayerCommentsHeaderSliver(),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: PlayerCommentsListSliver(),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ] else
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Comments will appear once the video loads.',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                  if (widget.state.movie?.recommendations != null &&
                      widget.state.movie!.recommendations!.isNotEmpty) ...[
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: PlayerRecommendationsSection(
                          recommendations: widget.state.movie!.recommendations!,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  ],
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
              title: widget.state.title,
              episodeTitle: widget.state.episodeTitle,
            ),
          ),
          IconButton(
            onPressed: widget.onDownload,
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
