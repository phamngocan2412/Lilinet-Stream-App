import 'package:flutter/material.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/utils/time_formatter.dart';
import '../../domain/entities/comment.dart';
import '../../../../core/widgets/cached_image.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onReply;
  final VoidCallback onToggleReplies;
  final bool isRepliesExpanded;
  final bool isLiked;
  final bool isReply;
  final void Function(String commentId)? onReplyLike;
  final void Function(String commentId, String userName)? onReplyReply;
  final VoidCallback? onLoadMoreReplies;
  final Set<String> likedReplyIds;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onDislike,
    required this.onReply,
    required this.onToggleReplies,
    this.isRepliesExpanded = false,
    this.isLiked = false,
    this.isReply = false,
    this.onReplyLike,
    this.onReplyReply,
    this.onLoadMoreReplies,
    this.likedReplyIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _CommentContent(
        comment: comment,
        onLike: onLike,
        onDislike: onDislike,
        onReply: onReply,
        onToggleReplies: onToggleReplies,
        isRepliesExpanded: isRepliesExpanded,
        isLiked: isLiked,
        isReply: isReply,
        onReplyLike: onReplyLike,
        onReplyReply: onReplyReply,
        onLoadMoreReplies: onLoadMoreReplies,
        likedReplyIds: likedReplyIds,
      ),
    );
  }
}

class _CommentContent extends StatefulWidget {
  final Comment comment;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onReply;
  final VoidCallback onToggleReplies;
  final bool isRepliesExpanded;
  final bool isLiked;
  final bool isReply;
  final void Function(String commentId)? onReplyLike;
  final void Function(String commentId, String userName)? onReplyReply;
  final VoidCallback? onLoadMoreReplies;
  final Set<String> likedReplyIds;

  const _CommentContent({
    required this.comment,
    required this.onLike,
    required this.onDislike,
    required this.onReply,
    required this.onToggleReplies,
    required this.isRepliesExpanded,
    required this.isLiked,
    required this.isReply,
    this.onReplyLike,
    this.onReplyReply,
    this.onLoadMoreReplies,
    this.likedReplyIds = const {},
  });

  @override
  State<_CommentContent> createState() => _CommentContentState();
}

class _CommentContentState extends State<_CommentContent> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isReply ? 12 : 16,
        vertical: widget.isReply ? 6 : 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar - smaller for replies
          _Avatar(
            imageUrl: widget.comment.avatarUrl.isNotEmpty
                ? widget.comment.avatarUrl
                : null,
            radius: widget.isReply ? 14 : 16,
          ),
          const SizedBox(width: 10),

          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Comment Container with background
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row - Name, Time
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.comment.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: widget.isReply ? 12 : 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '• ${TimeFormatter.formatDisplayTimeAgo(
                              context: context,
                              createdAt: widget.comment.createdAt,
                              isEdited: widget.comment.isEdited,
                              updatedAt: widget.comment.updatedAt,
                            )}',
                            style: TextStyle(
                              fontSize: widget.isReply ? 10 : 11,
                              color: theme.hintColor,
                            ),
                          ),
                          if (widget.comment.isPinned) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.push_pin,
                              size: 10,
                              color: colorScheme.primary,
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Comment Text
                      _CommentText(
                        content: widget.comment.content,
                        showFull: _showFullText,
                        onToggle: () =>
                            setState(() => _showFullText = !_showFullText),
                        fontSize: widget.isReply ? 12 : 13,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // Action Buttons Row
                _ActionButtons(
                  likes: widget.comment.likes,
                  repliesCount: widget.comment.repliesCount,
                  onLike: widget.onLike,
                  onReply: widget.onReply,
                  onToggleReplies: widget.comment.repliesCount > 0
                      ? widget.onToggleReplies
                      : null,
                  isRepliesExpanded: widget.isRepliesExpanded,
                  isLiked: widget.isLiked,
                  isReply: widget.isReply,
                ),

                // Replies Section - nested and indented
                if (widget.isRepliesExpanded &&
                    widget.comment.replies.isNotEmpty)
                  _RepliesSection(
                    replies: widget.comment.replies,
                    repliesCount: widget.comment.repliesCount,
                    onReplyLike: widget.onReplyLike,
                    onReplyReply: widget.onReplyReply,
                    onLoadMoreReplies: widget.onLoadMoreReplies,
                    likedReplyIds: widget.likedReplyIds,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const _Avatar({this.imageUrl, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final iconColor = Theme.of(context).colorScheme.onSurfaceVariant;

    // If no avatar URL, show default icon immediately
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: bgColor,
        child: Icon(
          Icons.person,
          size: radius,
          color: iconColor,
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      child: ClipOval(
        child: AppCachedImage(
          imageUrl: imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          memCacheWidth: (radius * 2 * 2).toInt(), // 2x for retina
          placeholder: Container(
            color: bgColor,
            child: Icon(
              Icons.person,
              size: radius,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentText extends StatelessWidget {
  final String content;
  final bool showFull;
  final VoidCallback onToggle;
  final double fontSize;

  const _CommentText({
    required this.content,
    required this.showFull,
    required this.onToggle,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (content.length <= 120) {
      return Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.3,
          color: theme.textTheme.bodyMedium?.color,
        ),
      );
    }

    return GestureDetector(
      onTap: onToggle,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: fontSize,
            height: 1.3,
            color: theme.textTheme.bodyMedium?.color,
          ),
          children: [
            TextSpan(
              text: showFull ? content : '${content.substring(0, 120)}... ',
            ),
            TextSpan(
              text: showFull ? l10n.collapse : l10n.seeMore,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: fontSize - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final int likes;
  final int repliesCount;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final VoidCallback? onToggleReplies;
  final bool isRepliesExpanded;
  final bool isLiked;
  final bool isReply;

  const _ActionButtons({
    required this.likes,
    required this.repliesCount,
    required this.onLike,
    required this.onReply,
    this.onToggleReplies,
    required this.isRepliesExpanded,
    required this.isLiked,
    required this.isReply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        // Like Button
        InkWell(
          onTap: onLike,
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: isReply ? 16 : 18,
                    color:
                        isLiked ? theme.colorScheme.primary : theme.hintColor,
                  ),
                  if (likes > 0) ...[
                    const SizedBox(width: 6),
                    Text(
                      likes.toString(),
                      style: TextStyle(
                        fontSize: isReply ? 12 : 13,
                        color: isLiked
                            ? theme.colorScheme.primary
                            : theme.hintColor,
                        fontWeight:
                            isLiked ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 4),

        // Reply Button
        InkWell(
          onTap: onReply,
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: isReply ? 16 : 18,
                    color: theme.hintColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.reply,
                    style: TextStyle(
                      fontSize: isReply ? 12 : 13,
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Replies Toggle with count
        if (repliesCount > 0 && onToggleReplies != null) ...[
          const SizedBox(width: 8),
          InkWell(
            onTap: onToggleReplies,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isRepliesExpanded
                      ? theme.colorScheme.primary.withOpacity(0.1)
                      : theme.colorScheme.surfaceContainerHighest.withOpacity(
                          0.5,
                        ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isRepliesExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: isReply ? 16 : 18,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isRepliesExpanded
                          ? l10n.hideReplies(repliesCount)
                          : l10n.viewReplies(repliesCount),
                      style: TextStyle(
                        fontSize: isReply ? 12 : 13,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RepliesSection extends StatelessWidget {
  final List<Comment> replies;
  final int repliesCount;
  final void Function(String commentId)? onReplyLike;
  final void Function(String commentId, String userName)? onReplyReply;
  final VoidCallback? onLoadMoreReplies;
  final Set<String> likedReplyIds;

  const _RepliesSection({
    required this.replies,
    required this.repliesCount,
    this.onReplyLike,
    this.onReplyReply,
    this.onLoadMoreReplies,
    this.likedReplyIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Replies list
          ...replies.map((reply) {
            return CommentItem(
              comment: reply,
              onLike: () => onReplyLike?.call(reply.id),
              onDislike: () {},
              onReply: () => onReplyReply?.call(reply.id, reply.userName),
              onToggleReplies: () {},
              isReply: true,
              isLiked: likedReplyIds.contains(reply.id),
            );
          }),

          // "View more replies" button if there are more replies than shown
          if (replies.length < repliesCount)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4),
              child: InkWell(
                onTap: onLoadMoreReplies,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.viewMoreReplies(repliesCount - replies.length),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
