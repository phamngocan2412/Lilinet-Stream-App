import 'package:flutter/material.dart';

class PlayerInfoSection extends StatelessWidget {
  final String? description;

  const PlayerInfoSection({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    if (description == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description!,
          style: const TextStyle(color: Colors.grey),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
