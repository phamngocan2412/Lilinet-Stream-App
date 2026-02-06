import 'package:flutter/material.dart';

class PlayerTitleSection extends StatelessWidget {
  final String? title;
  final String? episodeTitle;
  final Color orangeColor;

  const PlayerTitleSection({
    super.key,
    required this.title,
    this.episodeTitle,
    this.orangeColor = const Color(0xFFC6A664),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$title${episodeTitle != null ? " - $episodeTitle" : ""}',
            style: TextStyle(
              color: orangeColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
