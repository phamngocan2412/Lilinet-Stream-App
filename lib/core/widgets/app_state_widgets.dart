import 'package:flutter/material.dart';

import 'empty_state_widget.dart';
import 'error_widget.dart';
import 'loading_indicator.dart';

class AppLoadingState extends StatelessWidget {
  final double size;

  const AppLoadingState({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingIndicator(size: size));
  }
}

class AppErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isCompact;

  const AppErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      message: message,
      onRetry: onRetry,
      isCompact: isCompact,
    );
  }
}

class AppEmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const AppEmptyState({
    super.key,
    required this.message,
    this.icon,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      message: message,
      icon: icon,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }
}
