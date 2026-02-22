import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../domain/entities/comment.dart';
import '../../presentation/manager/comment_cubit.dart';
import '../../presentation/manager/comment_state.dart';
import 'comment_bottom_sheet.dart';

class CollapsedCommentView extends StatelessWidget {
  final String videoId;

  const CollapsedCommentView({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<CommentCubit>()..loadComments(videoId),
      child: _CollapsedCommentViewContent(videoId: videoId),
    );
  }
}

class _CollapsedCommentViewContent extends StatelessWidget {
  final String videoId;

  const _CollapsedCommentViewContent({required this.videoId});

  void _openCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // Show above miniplayer
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentBottomSheet(videoId: videoId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildCompactCard(context, null, 0),
          loading: () => _buildCompactCard(context, null, 0),
          error: (msg) => _buildCompactCard(context, null, 0),
          loaded: (
            comments,
            sortType,
            expandedReplies,
            isAdding,
            likedCommentIds,
            likingInProgress,
            errorMessage,
          ) {
            final count = comments.length;
            final topComment = comments.isNotEmpty ? comments.first : null;
            return _buildCompactCard(context, topComment, count);
          },
        );
      },
    );
  }

  Widget _buildCompactCard(BuildContext context, Comment? comment, int count) {
    return GestureDetector(
      onTap: () => _openCommentSheet(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            // Icon
            Icon(
              Icons.chat_bubble_outline,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),

            // Comment count
            Text(
              '$count',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 12),

            // Preview text
            Expanded(
              child: comment != null
                  ? _buildCompactPreview(comment)
                  : Text(
                      AppLocalizations.of(context)!.tapToViewComments,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ),

            // Arrow icon
            Icon(
              Icons.keyboard_arrow_right,
              size: 20,
              color: Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactPreview(Comment comment) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: const TextStyle(fontSize: 13, height: 1.3),
        children: [
          TextSpan(
            text: '${comment.userName}: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: comment.content,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
