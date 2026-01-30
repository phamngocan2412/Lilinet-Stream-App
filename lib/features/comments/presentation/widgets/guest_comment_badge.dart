import 'package:flutter/material.dart';

class GuestCommentBadge extends StatelessWidget {
  final bool isGuest;
  final bool isPending;

  const GuestCommentBadge({
    super.key,
    this.isGuest = false,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isGuest && !isPending) {
      return const SizedBox.shrink();
    }

    if (isPending) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Đang đồng bộ...',
              style: TextStyle(
                fontSize: 10,
                color: Colors.blue.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // Guest badge
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off,
            size: 10,
            color: Colors.orange.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 4),
          Text(
            'Chưa đồng bộ',
            style: TextStyle(
              fontSize: 10,
              color: Colors.orange.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
