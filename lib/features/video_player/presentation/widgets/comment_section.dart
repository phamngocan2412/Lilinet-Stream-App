import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/comments/comments_cubit.dart';
import '../bloc/comments/comments_state.dart';

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

  // Factory to create from Supabase JSON later
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      userName:
          json['user_name'] ?? 'Anonymous', // Adjust based on your DB schema
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

  const CommentSection({
    super.key,
    required this.videoId,
  });

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
  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
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
                    'Comments',
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

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<CommentModel> _comments = [];
  bool _isLoading = true;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ==========================================
  // 3. Functional Logic (Mock + Supabase Ready)
  // ==========================================

  Future<void> _fetchComments() async {
    setState(() => _isLoading = true);

    // --- MOCK API CALL (Replace with Supabase) ---
    await Future.delayed(const Duration(seconds: 1)); // Simulate network

    final List<CommentModel> mockComments = [
      CommentModel(
        id: '1',
        userName: 'Sarah Jenkins',
        userAvatarUrl: 'https://i.pravatar.cc/150?u=1',
        content:
            'This episode was absolutely mind-blowing! The animation quality has improved so much.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      CommentModel(
        id: '2',
        userName: 'OtakuKing99',
        content: 'Does anyone know the name of the OST playing at 12:30?',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CommentModel(
        id: '3',
        userName: 'AnimeLover',
        userAvatarUrl: 'https://i.pravatar.cc/150?u=3',
        content: 'Can\'t wait for the next season!',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
    // ---------------------------------------------

    /* SUPABASE IMPLEMENTATION EXAMPLE:
    final response = await Supabase.instance.client
        .from('comments')
        .select()
        .eq('video_id', widget.videoId)
        .order('created_at', ascending: false);
    
    final fetchedComments = (response as List).map((e) => CommentModel.fromJson(e)).toList();
    */

    if (mounted) {
      setState(() {
        _comments = mockComments; // Replace with fetchedComments
        _isLoading = false;
      });
    }
  }

  Future<void> _postComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    setState(() => _isPosting = true);

    // --- MOCK POST CALL (Replace with Supabase) ---
    await Future.delayed(const Duration(milliseconds: 500));

    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: 'You', // In real app, get from Auth Provider
      content: content,
      createdAt: DateTime.now(),
    );
    // ---------------------------------------------

    /* SUPABASE IMPLEMENTATION EXAMPLE:
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    await Supabase.instance.client.from('comments').insert({
      'video_id': widget.videoId,
      'user_id': user.id,
      'content': content,
      'user_name': user.userMetadata?['name'] ?? 'User', // Store denormalized or join
    });
    // Then refresh or insert locally
    */

    if (mounted) {
      setState(() {
        // Add to top of list
        _comments.insert(0, newComment);
        _controller.clear();
        _isPosting = false;
      });
      // Scroll to top
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Helper for "Time Ago" format
  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  // ==========================================
  // 4. UI Design
  // ==========================================

  @override
  Widget build(BuildContext context) {
    // Using app theme colors
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // --- Header ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(
                'Comments',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '${_comments.length}',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.white10),

        // --- Comment List ---
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _comments.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _comments.length,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    return _buildCommentItem(_comments[index]);
                  },
                ),
        ),

        // --- Input Field ---
        _buildInputArea(colorScheme),
      ],
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
            'No comments yet',
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Be the first to share your thoughts!',
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
                    comment.userName[0].toUpperCase(),
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
                        color: Colors
                            .white, // Or Theme.of(context).colorScheme.onSurface
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
                    color: Colors
                        .white70, // Or Theme.of(context).colorScheme.onSurfaceVariant
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
        color: Color(0xFF1E1E1E), // Slightly lighter than background
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
                hintText: 'Add a comment...',
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
