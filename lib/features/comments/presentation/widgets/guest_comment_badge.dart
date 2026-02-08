import 'package:flutter/material.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

import '../../../../core/widgets/loading_indicator.dart';

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
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
              height: 10,
              child: LoadingIndicator(size: 10, color: Colors.blue),
            ),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.syncing,
              style: TextStyle(
                fontSize: 10,
                color: Colors.blue.withOpacity(0.8),
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
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off,
            size: 10,
            color: Colors.orange.withOpacity(0.8),
          ),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context)!.notSynced,
            style: TextStyle(
              fontSize: 10,
              color: Colors.orange.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
