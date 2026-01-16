import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isCompact;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine icon and helpful message based on error type
    IconData icon = Icons.error_outline;
    Color iconColor = Theme.of(context).colorScheme.error;
    String helpText = message;

    if (message.contains('not found') || message.contains('404')) {
      icon = Icons.search_off;
      iconColor = Theme.of(context).colorScheme.tertiary;
      helpText = 'Content not available';
    } else if (message.contains('internet') || message.contains('connection')) {
      icon = Icons.wifi_off;
      iconColor = Theme.of(context).colorScheme.tertiary;
      helpText = 'Check your internet connection';
    } else if (message.contains('timeout')) {
      icon = Icons.hourglass_empty;
      iconColor = Theme.of(context).colorScheme.tertiary;
      helpText = 'Request took too long';
    }

    if (isCompact) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 8),
            Text(helpText, textAlign: TextAlign.center),
            if (onRetry != null)
              IconButton(icon: const Icon(Icons.refresh), onPressed: onRetry),
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: iconColor),
            const SizedBox(height: 16),
            Text('Oops!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              helpText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
