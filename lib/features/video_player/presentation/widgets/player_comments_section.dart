import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/services/error_handler_service.dart';
import '../../../comments/presentation/manager/comment_cubit.dart';
import '../../../comments/presentation/manager/comment_state.dart';
import '../../../comments/presentation/widgets/comment_item.dart';
import '../../../comments/presentation/widgets/comment_sort_tabs.dart';
import '../../../../core/widgets/loading_indicator.dart';

class PlayerCommentsSection extends StatelessWidget {
  final String mediaId;

  const PlayerCommentsSection({super.key, required this.mediaId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<CommentCubit>()..loadComments(mediaId),
      child: const PlayerCommentsView(),
    );
  }
}

class PlayerCommentsView extends StatelessWidget {
  const PlayerCommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
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
                        likedReplyIds: likedCommentIds,
                      );
                    },
                  ),
              ],
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
