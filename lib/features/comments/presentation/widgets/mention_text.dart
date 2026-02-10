import 'package:flutter/material.dart';

/// Parses comment text and highlights @username mentions in the primary color.
///
/// Usage:
/// ```dart
/// MentionText(
///   text: 'Hello @JohnDoe how are you?',
///   style: TextStyle(fontSize: 13),
/// )
/// ```
class MentionText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const MentionText({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final mentionColor = Theme.of(context).colorScheme.primary;
    final spans = _parseMentions(text, style, mentionColor);

    return RichText(
      text: TextSpan(children: spans, style: style),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }

  /// Splits [text] on `@username` patterns and returns styled [TextSpan]s.
  ///
  /// Usernames may contain letters, digits, underscores, dots, and hyphens.
  static List<TextSpan> _parseMentions(
    String text,
    TextStyle? baseStyle,
    Color mentionColor,
  ) {
    // Match @username (letters, digits, underscore, dot, hyphen — at least 1 char)
    final regex = RegExp(r'@([\w.\-]+)');
    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Text before the mention
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      // The @mention itself
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: mentionColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      lastEnd = match.end;
    }

    // Remaining text after last mention
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    // If no mentions found, return the full text as a single span
    if (spans.isEmpty) {
      spans.add(TextSpan(text: text));
    }

    return spans;
  }
}
