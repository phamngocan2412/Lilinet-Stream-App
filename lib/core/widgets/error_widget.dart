import 'package:flutter/foundation.dart';
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
    IconData icon = Icons.error_outline_rounded;
    Color iconColor = Theme.of(context).colorScheme.error;
    String helpText = message;
    String title = 'Something went wrong';

    if (message.toLowerCase().contains('not found') ||
        message.contains('404')) {
      icon = Icons.search_off_rounded;
      iconColor = Theme.of(context).colorScheme.tertiary;
      title = 'Content Not Found';
      helpText = 'We couldn\'t find what you were looking for.';
    } else if (message.toLowerCase().contains('internet') ||
        message.toLowerCase().contains('connection')) {
      icon = Icons.wifi_off_rounded;
      iconColor = Theme.of(context).colorScheme.error;
      title = 'No Connection';
      helpText = 'Please check your internet connection and try again.';
    } else if (message.toLowerCase().contains('timeout')) {
      icon = Icons.timer_off_rounded;
      iconColor = Theme.of(context).colorScheme.tertiary;
      title = 'Request Timeout';
      helpText = 'The server took too long to respond.';
    }

    if (isCompact) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(height: 8),
              Text(
                helpText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (onRetry != null)
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: onRetry,
                  tooltip: 'Retry',
                ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48, color: iconColor),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                helpText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              // Show raw error for debugging if needed, but smaller
              if (kDebugMode && message != helpText) ...[
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontFamily: 'monospace',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try Again'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
