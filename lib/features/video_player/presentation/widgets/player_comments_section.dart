// ignore_for_file: deprecated_member_use

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

// Optimized Player Comments Section using Slivers
// This avoids nesting ListView(shrinkWrap: true) inside another ScrollView

class PlayerCommentsHeaderSliver extends StatelessWidget {
  const PlayerCommentsHeaderSliver({super.key});

  bool get _isLoggedIn => Supabase.instance.client.auth.currentUser != null;

  String? get _userName {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.userMetadata?['display_name'] as String? ??
        user?.email?.split('@').first;
  }

  void _scrollToTop(BuildContext context) {
    // Scroll to top of the CustomScrollView
    PrimaryScrollController.of(context).animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (loadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!
                            .commentsCount(loadedState.comments.length),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CommentSortTabs(
                        currentSort: loadedState.sortType,
                        onSortChanged: (type) {
                          context.read<CommentCubit>().changeSortType(type);
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
                      _scrollToTop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class PlayerCommentsListSliver extends StatefulWidget {
  const PlayerCommentsListSliver({super.key});

  @override
  State<PlayerCommentsListSliver> createState() =>
      _PlayerCommentsListSliverState();
}

class _PlayerCommentsListSliverState extends State<PlayerCommentsListSliver> {
  String? _lastAddedCommentId;

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

  @override
  Widget build(BuildContext context) {
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
          loading: (_) => const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LoadingIndicator(size: 30),
              ),
            ),
          ),
          error: (errorState) => SliverToBoxAdapter(
            child: Center(
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
          ),
          loaded: (loadedState) {
            final comments = loadedState.comments;
            final expandedReplies = loadedState.expandedReplies;
            final likedCommentIds = loadedState.likedCommentIds;

            if (comments.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      AppLocalizations.of(context)!.noCommentsYet,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                // Add separator logic: if index is odd, return divider?
                // SliverList doesn't support separators easily like ListView.separated.
                // We can double the count and return divider for odd indices, or just include divider in item.
                // Or use SliverMainAxisGroup... but let's just add divider to the item bottom.

                final commentIndex = index;
                final comment = comments[commentIndex];
                final isExpanded = expandedReplies.containsKey(comment.id);
                // Check if this is a newly added comment
                final isNewComment = _lastAddedCommentId == comment.id;

                return Column(
                  children: [
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: isNewComment ? 500 : 0),
                      curve: isNewComment ? Curves.easeOutBack : Curves.linear,
                      child: AnimatedSlide(
                        offset: isNewComment ? Offset.zero : const Offset(0, 0),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutBack,
                        child: Container(
                          decoration: isNewComment
                              ? BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
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
                            likedReplyIds: likedCommentIds,
                          ),
                        ),
                      ),
                    ),
                    if (index < comments.length - 1)
                      const Divider(height: 1, color: Colors.white12),
                  ],
                );
              }, childCount: comments.length),
            );
          },
          orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
        );
      },
    );
  }
}
