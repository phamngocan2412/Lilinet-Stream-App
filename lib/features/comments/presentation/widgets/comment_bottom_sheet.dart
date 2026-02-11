import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/error_handler_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../presentation/manager/comment_cubit.dart';
import '../../presentation/manager/comment_state.dart';
import 'comment_header.dart';
import 'comment_input.dart';
import 'comment_item.dart';
import 'comment_sort_tabs.dart';

class CommentBottomSheet extends StatelessWidget {
  final String videoId;

  const CommentBottomSheet({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<CommentCubit>()..loadComments(videoId),
      child: _CommentBottomSheetView(videoId: videoId),
    );
  }
}

class _CommentBottomSheetView extends StatefulWidget {
  final String videoId;

  const _CommentBottomSheetView({required this.videoId});

  @override
  State<_CommentBottomSheetView> createState() =>
      _CommentBottomSheetViewState();
}

class CommentBottomSheetWrapper extends StatelessWidget {
  final String videoId;
  final Widget child;

  const CommentBottomSheetWrapper({
    super.key,
    required this.videoId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        state.maybeMap(
          loaded: (s) {
            if (s.errorMessage != null) {
              final l10n = AppLocalizations.of(context)!;
              final userFriendlyMsg = GetIt.I<ErrorHandlerService>()
                  .getUserFriendlyMessage(s.errorMessage!, l10n);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(userFriendlyMsg),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          orElse: () {},
        );
      },
      child: child,
    );
  }
}

class _CommentBottomSheetViewState extends State<_CommentBottomSheetView> {
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();
  String? _replyingToCommentId;
  String? _replyingToUserName;

  @override
  void dispose() {
    _replyController.dispose();
    _replyFocusNode.dispose();
    super.dispose();
  }

  bool get _isLoggedIn => Supabase.instance.client.auth.currentUser != null;

  String? get _userName {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.userMetadata?['display_name'] as String? ??
        user?.email?.split('@').first;
  }

  void _showLoginPrompt() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.lock_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.loginRequiredAction),
          ],
        ),
        backgroundColor: Colors.orangeAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleLike(String commentId) {
    if (!_isLoggedIn) {
      _showLoginPrompt();
      return;
    }
    context.read<CommentCubit>().likeComment(commentId);
  }

  void _handleReply(String commentId, String userName) {
    if (!_isLoggedIn) {
      _showLoginPrompt();
      return;
    }
    setState(() {
      _replyingToCommentId = commentId;
      _replyingToUserName = userName;
      _replyController.text = '@$userName ';
    });
    _replyFocusNode.requestFocus();
  }

  void _handleDislike(String commentId) {
    if (!_isLoggedIn) {
      _showLoginPrompt();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.dislikeFeaturePending),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _cancelReply() {
    setState(() {
      _replyingToCommentId = null;
      _replyingToUserName = null;
      _replyController.clear();
    });
    _replyFocusNode.unfocus();
  }

  void _sendReply() {
    if (_replyController.text.trim().isEmpty) return;
    if (_replyingToCommentId == null) return;

    context.read<CommentCubit>().addComment(
          _replyController.text,
          parentId: _replyingToCommentId,
        );
    _cancelReply();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              BlocBuilder<CommentCubit, CommentState>(
                buildWhen: (p, c) =>
                    p.maybeMap(
                      loaded: (s) => s.comments.length,
                      orElse: () => 0,
                    ) !=
                    c.maybeMap(
                      loaded: (s) => s.comments.length,
                      orElse: () => 0,
                    ),
                builder: (context, state) {
                  final count = state.maybeMap(
                    loaded: (s) => s.comments.length,
                    orElse: () => 0,
                  );
                  return CommentHeader(
                    count: count,
                    onClose: () => Navigator.pop(context),
                  );
                },
              ),

              // Sort Tabs
              BlocBuilder<CommentCubit, CommentState>(
                buildWhen: (p, c) =>
                    p.maybeMap(loaded: (s) => s.sortType, orElse: () => null) !=
                    c.maybeMap(loaded: (s) => s.sortType, orElse: () => null),
                builder: (context, state) {
                  return state.maybeMap(
                    loaded: (s) => CommentSortTabs(
                      currentSort: s.sortType,
                      onSortChanged: (type) {
                        context.read<CommentCubit>().changeSortType(type);
                      },
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),

              const Divider(height: 1),

              // Reply indicator
              if (_replyingToCommentId != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.08),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.dividerColor.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.reply,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.replyingTo,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                            Text(
                              _replyingToUserName ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: _cancelReply,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ],
                  ),
                ),

              // Comments List
              Expanded(
                child: BlocBuilder<CommentCubit, CommentState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: LoadingIndicator()),
                      loading: () => const Center(child: LoadingIndicator()),
                      error: (msg) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              msg.contains('internet')
                                  ? Icons.signal_wifi_off
                                  : Icons.error_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              GetIt.I<ErrorHandlerService>()
                                  .getUserFriendlyMessage(msg, l10n),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => context
                                  .read<CommentCubit>()
                                  .loadComments(widget.videoId),
                              icon: const Icon(Icons.refresh),
                              label: Text(l10n.retry),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      loaded: (
                        comments,
                        sortType,
                        expandedReplies,
                        isAdding,
                        totalComments, // totalComments
                        likedCommentIds,
                        totalLikes, // totalLikes
                      ) {
                        if (comments.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.chat_bubble_outline,
                                    size: 48,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  l10n.noComments,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.beFirstToComment,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          cacheExtent: 300,
                          controller: scrollController,
                          itemCount: comments.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            final isExpanded = expandedReplies.containsKey(
                              comment.id,
                            );

                            return CommentItem(
                              comment: comment.copyWith(
                                replies: isExpanded
                                    ? (expandedReplies[comment.id] ?? [])
                                    : [],
                              ),
                              onLike: () => _handleLike(comment.id),
                              onDislike: () => _handleDislike(comment.id),
                              onReply: () => _handleReply(
                                comment.id,
                                comment.userName,
                              ),
                              onToggleReplies: () => context
                                  .read<CommentCubit>()
                                  .toggleReplies(comment.id),
                              isRepliesExpanded: isExpanded,
                              isLiked: likedCommentIds.contains(comment.id),
                              onReplyLike: _handleLike,
                              onReplyReply: _handleReply,
                              onLoadMoreReplies: () => context
                                  .read<CommentCubit>()
                                  .toggleReplies(comment.id),
                              likedReplyIds: likedCommentIds,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              // Input Section
              Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(
                      color: theme.dividerColor.withOpacity(0.2),
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: _replyingToCommentId != null
                      ? _buildReplyInput()
                      : _buildCommentInput(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the avatar for the reply input using [AppCachedImage] with shimmer.
  Widget _buildReplyAvatar() {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['display_name'] as String? ??
        user?.userMetadata?['name'] as String? ??
        user?.email?.split('@').first ??
        'Anonymous';
    final avatarUrl = user?.userMetadata?['avatar_url'] as String? ??
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName)}';

    final shimmerBase = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[300]!;
    final shimmerHighlight = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[700]!
        : Colors.grey[100]!;

    return CircleAvatar(
      radius: 18,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ClipOval(
        child: AppCachedImage(
          imageUrl: avatarUrl,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          memCacheWidth: 72,
          placeholder: Shimmer.fromColors(
            baseColor: shimmerBase,
            highlightColor: shimmerHighlight,
            child: Container(width: 36, height: 36, color: shimmerBase),
          ),
        ),
      ),
    );
  }

  Widget _buildReplyInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildReplyAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                ),
              ),
              child: TextField(
                controller: _replyController,
                focusNode: _replyFocusNode,
                maxLines: null,
                maxLength: 1000,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendReply(),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.writeReply,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  counterText: "",
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Send button - keep same appearance but disable when sending (spam prevention)
          BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              final isSending = state.maybeMap(
                loaded: (s) => s.isAddingComment,
                orElse: () => false,
              );

              return Container(
                decoration: BoxDecoration(
                  color: isSending
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  onPressed: isSending
                      ? null // Disable when sending to prevent spam
                      : _sendReply,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        final isSending = state.maybeMap(
          loaded: (s) => s.isAddingComment,
          orElse: () => false,
        );

        return CommentInput(
          isSending: isSending,
          onSend: (content) {
            context.read<CommentCubit>().addComment(content);
          },
          userName: _userName,
          isLoggedIn: _isLoggedIn,
        );
      },
    );
  }
}
