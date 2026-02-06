import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  final ValueChanged<String> onSend;
  final bool isSending;
  final String? userAvatar;
  final bool isLoggedIn;

  const CommentInput({
    super.key,
    required this.onSend,
    required this.isLoggedIn,
    this.isSending = false,
    this.userAvatar,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: widget.userAvatar != null
                ? NetworkImage(widget.userAvatar!)
                : null,
            child: widget.userAvatar == null
                ? const Icon(Icons.person, size: 20)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: widget.isLoggedIn
                ? TextField(
                    controller: _controller,
                    maxLines: null,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      counterText: "",
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng đăng nhập để bình luận'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Vui lòng đăng nhập để bình luận',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          // Send button - always visible but disabled when sending (spam prevention)
          if (_hasText)
            IconButton(
              icon: Icon(
                Icons.send,
                color: widget.isSending
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: widget.isSending
                  ? null // Disable when sending to prevent spam
                  : () {
                      widget.onSend(_controller.text);
                      _controller.clear();
                      FocusScope.of(context).unfocus();
                    },
            ),
        ],
      ),
    );
  }
}
