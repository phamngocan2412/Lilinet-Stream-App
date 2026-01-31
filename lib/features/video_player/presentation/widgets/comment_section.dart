import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/comments/comments_cubit.dart';
import '../bloc/comments/comments_state.dart';

// ==========================================
// 0. String Resources (i18n-ready structure)
// ==========================================
/// Localized strings for CommentSection
/// Following SRP: All strings in one place, easy to maintain and extend for full i18n
class _CommentSectionStrings {
  // Section title
  static const String commentsTitle = 'Comments';

  // Empty states
  static const String noCommentsYet = 'No comments yet';
  static const String beTheFirst = 'Be the first to share your thoughts!';

  // Input hints
  static const String addComment = 'Add a comment...';

  // Avatar fallback
  static const String anonymous = 'Anonymous';
  static const String unknownUserInitial = '?';

  // Time formatting - Relative time units
  static const String timeJustNow = 'Just now';
  static String timeYearsAgo(int years) => '${years}y ago';
  static String timeMonthsAgo(int months) => '${months}mo ago';
  static String timeDaysAgo(int days) => '${days}d ago';
  static String timeHoursAgo(int hours) => '${hours}h ago';
  static String timeMinutesAgo(int minutes) => '${minutes}m ago';
}

// ==========================================
// 1. Data Model
// ==========================================
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
      userName: json['user_name'] ?? _CommentSectionStrings.anonymous,
      userAvatarUrl: json['avatar_url'],
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

// ==========================================
// 2. Comment Section Widget
// ==========================================
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
  /// Formats DateTime to relative time string
  /// Following OCP: Easy to extend for localization without modifying logic
  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) {
      return _CommentSectionStrings.timeYearsAgo((diff.inDays / 365).floor());
    }
    if (diff.inDays > 30) {
      return _CommentSectionStrings.timeMonthsAgo((diff.inDays / 30).floor());
    }
    if (diff.inDays > 0) {
      return _CommentSectionStrings.timeDaysAgo(diff.inDays);
    }
    if (diff.inHours > 0) {
      return _CommentSectionStrings.timeHoursAgo(diff.inHours);
    }
    if (diff.inMinutes > 0) {
      return _CommentSectionStrings.timeMinutesAgo(diff.inMinutes);
    }
    return _CommentSectionStrings.timeJustNow;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        List<CommentModel> comments = [];
        bool isLoading = true;

        if (state is CommentsLoaded && state.videoId == widget.videoId) {
          comments = state.comments;
          isLoading = false;
        } else if (state is CommentsLoaded) {
          // Different video loaded in singleton? Reload
          // But initState should catch this.
          // Just show loading if ID mismatch or wait for event.
        }

        return Column(
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    _CommentSectionStrings.commentsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isLoading)
                    Text(
                      '${comments.length}',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white10),

            // --- Comment List ---
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : comments.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      cacheExtent: 300,
                      controller: _scrollController,
                      itemCount: comments.length,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemBuilder: (context, index) {
                        return _buildCommentItem(comments[index]);
                      },
                    ),
            ),

            // --- Input Field ---
            _buildInputArea(colorScheme),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey[700]),
          const SizedBox(height: 16),
          Text(
            _CommentSectionStrings.noCommentsYet,
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            _CommentSectionStrings.beTheFirst,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(CommentModel comment) {
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
                    comment.userName.isNotEmpty
                        ? comment.userName[0].toUpperCase()
                        : _CommentSectionStrings.unknownUserInitial,
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
                      comment.userName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _timeAgo(comment.createdAt),
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

  Widget _buildInputArea(ColorScheme colorScheme) {
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
                hintText: _CommentSectionStrings.addComment,
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
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: isEnabled
                            ? colorScheme.primary
                            : Colors.grey[700],
                      ),
                onPressed: isEnabled ? _postComment : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
