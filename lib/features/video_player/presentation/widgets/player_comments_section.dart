import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/error_handler_service.dart';
import '../../../comments/presentation/manager/comment_cubit.dart';
import '../../../comments/presentation/manager/comment_state.dart';
import '../../../comments/presentation/widgets/comment_input.dart';
import '../../../comments/presentation/widgets/comment_item.dart';
import '../../../comments/presentation/widgets/comment_sort_tabs.dart';
import '../../../../core/widgets/loading_indicator.dart';

class PlayerCommentsSection extends StatefulWidget {
  final String mediaId;

  const PlayerCommentsSection({super.key, required this.mediaId});

  @override
  State<PlayerCommentsSection> createState() => _PlayerCommentsSectionState();
}

class _PlayerCommentsSectionState extends State<PlayerCommentsSection> {
  late final CommentCubit _commentCubit;

  @override
  void initState() {
    super.initState();
    _commentCubit = GetIt.I<CommentCubit>();
    _commentCubit.loadComments(widget.mediaId);
  }

  @override
  void didUpdateWidget(PlayerCommentsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaId != widget.mediaId) {
      _commentCubit.loadComments(widget.mediaId);
    }
  }

  @override
  void dispose() {
    _commentCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _commentCubit,
      child: const PlayerCommentsView(),
    );
  }
}

class PlayerCommentsView extends StatefulWidget {
  const PlayerCommentsView({super.key});

  @override
  State<PlayerCommentsView> createState() => _PlayerCommentsViewState();
}

class _PlayerCommentsViewState extends State<PlayerCommentsView>
    with AutomaticKeepAliveClientMixin {
  bool get _isLoggedIn => Supabase.instance.client.auth.currentUser != null;
  final ScrollController _scrollController = ScrollController();
  String? _lastAddedCommentId;

  @override
  bool get wantKeepAlive => true;

  String? get _userName {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.userMetadata?['display_name'] as String? ??
        user?.email?.split('@').first;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        state.mapOrNull(
          loaded: (loadedState) {
            // Track newly added comment for animation
            if (loadedState.comments.isNotEmpty &&
                loadedState.comments.first.id != _lastAddedCommentId) {
              setState(() {
                _lastAddedCommentId = loadedState.comments.first.id;
              });
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: LoadingIndicator(size: 30),
            ),
          ),
          error: (errorState) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.commentLoadError(
                  GetIt.I<ErrorHandlerService>().getUserFriendlyMessage(
                    errorState.message,
                    AppLocalizations.of(context)!,
                  ),
                ),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          loaded: (loadedState) {
            final comments = loadedState.comments;
            final sortType = loadedState.sortType;
            final expandedReplies = loadedState.expandedReplies;
            final likedCommentIds = loadedState.likedCommentIds;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .commentsCount(comments.length),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CommentSortTabs(
                      currentSort: sortType,
                      onSortChanged: (type) {
                        context.read<CommentCubit>().changeSortType(type);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Colors.white24),
                const SizedBox(height: 12),
                if (comments.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        AppLocalizations.of(context)!.noCommentsYet,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    separatorBuilder: (_, i) =>
                        const Divider(height: 1, color: Colors.white12),
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
                        onLike: () {
                          context.read<CommentCubit>().likeComment(
                                comment.id,
                              );
                        },
                        onDislike: () {},
                        onReply: () {
                          _showReplyDialog(
                            context,
                            comment.id,
                            comment.userName,
                          );
                        },
                        onToggleReplies: () {
                          context.read<CommentCubit>().toggleReplies(
                                comment.id,
                              );
                        },
                        isRepliesExpanded: isExpanded,
                        isLiked: likedCommentIds.contains(comment.id),
                        onReplyLike: (replyId) {
                          context.read<CommentCubit>().likeComment(replyId);
                        },
                        onReplyReply: (replyId, userName) {
                          _showReplyDialog(context, replyId, userName);
                        },
                        onLoadMoreReplies: () {
                          context.read<CommentCubit>().toggleReplies(
                                comment.id,
                              );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Colors.white24),
                  const SizedBox(height: 12),
                  // Comment Input at the top
                  CommentInput(
                    isLoggedIn: _isLoggedIn,
                    userName: _userName,
                    isSending: loadedState.isAddingComment,
                    onSend: (text) {
                      context.read<CommentCubit>().addComment(text);
                      _scrollToTop();
                    },
                  ),
                  const SizedBox(height: 12),
                  if (comments.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          AppLocalizations.of(context)!.noCommentsYet,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      separatorBuilder: (_, i) =>
                          const Divider(height: 1, color: Colors.white12),
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final isExpanded = expandedReplies.containsKey(
                          comment.id,
                        );
                        // Check if this is a newly added comment
                        final isNewComment = _lastAddedCommentId == comment.id;
                        return AnimatedOpacity(
                          opacity: 1.0,
                          duration:
                              Duration(milliseconds: isNewComment ? 500 : 0),
                          curve:
                              isNewComment ? Curves.easeOutBack : Curves.linear,
                          child: AnimatedSlide(
                            offset:
                                isNewComment ? Offset.zero : const Offset(0, 0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutBack,
                            child: Container(
                              decoration: isNewComment
                                  ? BoxDecoration(
                                      color: Colors.blue.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                  : null,
                              child: CommentItem(
                                comment: comment.copyWith(
                                  replies: isExpanded
                                      ? (expandedReplies[comment.id] ?? [])
                                      : [],
                                ),
                                onLike: () {
                                  context.read<CommentCubit>().likeComment(
                                        comment.id,
                                      );
                                },
                                onDislike: () {},
                                onReply: () {
                                  _showReplyDialog(
                                    context,
                                    comment.id,
                                    comment.userName,
                                  );
                                },
                                onToggleReplies: () {
                                  context.read<CommentCubit>().toggleReplies(
                                        comment.id,
                                      );
                                },
                                isRepliesExpanded: isExpanded,
                                isLiked: likedCommentIds.contains(comment.id),
                                onReplyLike: (replyId) {
                                  context
                                      .read<CommentCubit>()
                                      .likeComment(replyId);
                                },
                                onReplyReply: (replyId, userName) {
                                  _showReplyDialog(context, replyId, userName);
                                },
                                onLoadMoreReplies: () {
                                  context.read<CommentCubit>().toggleReplies(
                                        comment.id,
                                      );
                                },
                                likedReplyIds: likedCommentIds,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 100), // Bottom padding for scrolling
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  void _showReplyDialog(
    BuildContext context,
    String commentId,
    String userName,
  ) {
    final TextEditingController controller = TextEditingController(
      text: '@$userName ',
    );
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.reply),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: l10n.writeReply,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<CommentCubit>().addComment(
                      controller.text,
                      parentId: commentId,
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: Text(l10n.send),
          ),
        ],
      ),
    );
  }
}
