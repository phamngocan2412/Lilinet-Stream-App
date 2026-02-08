import 'package:flutter/material.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

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
    // Use MediaQuery.viewInsetsOf to only rebuild when insets actually change
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + bottomInset,
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
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.addCommentHint,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!.loginToComment,
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        AppLocalizations.of(context)!.loginToComment,
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
