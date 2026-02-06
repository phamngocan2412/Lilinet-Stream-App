import 'package:flutter/material.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

class TimeFormatter {
  static String formatTimeAgo(BuildContext context, DateTime dateTime) {
    final l10n = AppLocalizations.of(context)!;
    final duration = DateTime.now().difference(dateTime);

    if (duration.inDays >= 30) {
      // For very old dates, return simple date or weeks if under a year
      if (duration.inDays >= 365) {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
      return l10n.weeksAgo((duration.inDays / 7).floor());
    } else if (duration.inDays >= 7) {
      return l10n.weeksAgo((duration.inDays / 7).floor());
    } else if (duration.inDays > 0) {
      return l10n.daysAgo(duration.inDays);
    } else if (duration.inHours > 0) {
      return l10n.hoursAgo(duration.inHours);
    } else if (duration.inMinutes > 0) {
      return l10n.minutesAgo(duration.inMinutes);
    } else {
      return l10n.justNow;
    }
  }

  static String formatDisplayTimeAgo({
    required BuildContext context,
    required DateTime createdAt,
    bool isEdited = false,
    DateTime? updatedAt,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final timeStr = formatTimeAgo(context, createdAt);

    if (isEdited && updatedAt != null) {
      return '$timeStr (${l10n.edited})';
    }
    return timeStr;
  }
}
