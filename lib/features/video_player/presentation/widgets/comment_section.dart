import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/utils/time_formatter.dart';
import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../bloc/comments/comments_cubit.dart';
import '../bloc/comments/comments_state.dart';

// DEPRECATED: Use PlayerCommentsSection instead which integrates with the real
// Supabase-backed comment system from features/comments/
// This file is kept for reference but should not be used in production.

// ==========================================
// 1. Data Model (DEPRECATED)
// ==========================================
/// DEPRECATED: Use CommentModel from features/comments/data/models/ instead
@Deprecated('Use CommentModel from features/comments/data/models/ instead')
class CommentModel {
  final String id;
  final String userName;
  final String? userAvatarUrl;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userName,
    this.userAvatarUrl,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      userName: json['user_name'] ?? '',
      userAvatarUrl: json['avatar_url'],
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

// ==========================================
// 2. Comment Section Widget (DEPRECATED)
// ==========================================
/// DEPRECATED: Use [PlayerCommentsSection] instead.
///
/// This widget uses the mock [CommentsCubit] which provides in-memory
/// mock data only. For production, use PlayerCommentsSection which
/// integrates with the real Supabase-backed comment system.
@Deprecated(
    'Use PlayerCommentsSection instead. This mock implementation will be removed.')
class CommentSection extends StatelessWidget {
  final String videoId;

  const CommentSection({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CommentsCubit>(),
      child: _CommentSectionView(videoId: videoId),
    );
  }
}

class _CommentSectionView extends StatefulWidget {
  final String videoId;

  const _CommentSectionView({required this.videoId});

  @override
  State<_CommentSectionView> createState() => _CommentSectionViewState();
}

class _CommentSectionViewState extends State<_CommentSectionView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    context.read<CommentsCubit>().loadComments(widget.videoId);
  }

  @override
  void didUpdateWidget(_CommentSectionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      context.read<CommentsCubit>().loadComments(widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _postComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    setState(() => _isPosting = true);

    await context.read<CommentsCubit>().addComment(widget.videoId, content);

    if (mounted) {
      setState(() => _isPosting = false);
      _controller.clear();
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  // Helper for "Time Ago" format
  String _timeAgo(BuildContext context, DateTime date) {
    return TimeFormatter.formatTimeAgo(context, date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Dark background to prevent transparency
      ),
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          List<CommentModel> comments = [];
          bool isLoading = true;

          if (state is CommentsLoaded && state.videoId == widget.videoId) {
            comments = state.comments;
            isLoading = false;
          }

          return Column(
            children: [
              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.commentsCount(comments.length),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.white10),

              // --- Comment List ---
              Expanded(
                child: isLoading
                    ? const Center(child: LoadingIndicator())
                    : comments.isEmpty
                        ? _buildEmptyState(l10n)
                        : ListView.builder(
                            cacheExtent: 300,
                            controller: _scrollController,
                            itemCount: comments.length,
                            padding: const EdgeInsets.only(bottom: 16),
                            itemBuilder: (context, index) {
                              return _buildCommentItem(
                                  context, comments[index]);
                            },
                          ),
              ),

              // --- Input Field ---
              _buildInputArea(context, colorScheme, l10n),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey[700]),
          const SizedBox(height: 16),
          Text(
            l10n.noComments,
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.beFirstToComment,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(BuildContext context, CommentModel comment) {
    final l10n = AppLocalizations.of(context)!;
    final userName =
        comment.userName.isEmpty ? l10n.anonymous : comment.userName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[800],
            backgroundImage: comment.userAvatarUrl != null
                ? NetworkImage(comment.userAvatarUrl!)
                : null,
            child: comment.userAvatarUrl == null
                ? Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name + Time
                Row(
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _timeAgo(context, comment.createdAt),
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Comment Body
                Text(
                  comment.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(
      BuildContext context, ColorScheme colorScheme, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          // Current User Avatar (Mock)
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.primary,
            child: const Icon(Icons.person, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          // Text Field
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: l10n.addCommentHint,
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                isDense: true,
              ),
              minLines: 1,
              maxLines: 3,
            ),
          ),
          // Send Button
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              final isEnabled = value.text.trim().isNotEmpty && !_isPosting;
              return IconButton(
                icon: _isPosting
                    ? const LoadingIndicator(size: 20)
                    : Icon(
                        Icons.send_rounded,
                        color:
                            isEnabled ? colorScheme.primary : Colors.grey[700],
                      ),
                onPressed: isEnabled ? _postComment : null,
                tooltip: l10n.send,
              );
            },
          ),
        ],
      ),
    );
  }
}
