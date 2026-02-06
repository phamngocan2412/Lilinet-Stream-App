import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';

/// Global error handler service for logging and reporting errors.
///
/// In the future, this can be extended to:
/// - Send errors to Sentry/Firebase Crashlytics
/// - Log to local file for debugging
/// - Show user-friendly notifications
@lazySingleton
class ErrorHandlerService {
  /// Logs an error with optional stack trace and context.
  void logError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════════════════════');
      if (context != null) {
        debugPrint('📍 Context: $context');
      }
      debugPrint('${fatal ? '💀 FATAL' : '❌'} Error: $error');
      if (stackTrace != null) {
        debugPrint('Stack trace:\n$stackTrace');
      }
      debugPrint('═══════════════════════════════════════════════════════');
    } else {
      // In release mode, could send to crash reporting service
      // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  /// Logs a warning message.
  void logWarning(String message, {String? context}) {
    if (kDebugMode) {
      debugPrint('⚠️ Warning${context != null ? ' [$context]' : ''}: $message');
    }
  }

  /// Logs an info message.
  void logInfo(String message, {String? context}) {
    if (kDebugMode) {
      debugPrint('ℹ️ Info${context != null ? ' [$context]' : ''}: $message');
    }
  }

  /// Converts a Failure or error to user-friendly message.
  String getUserFriendlyMessage(Object error, AppLocalizations l10n) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('socket') ||
        errorStr.contains('connection') ||
        errorStr.contains('network') ||
        errorStr.contains('internet')) {
      return l10n.noNetworkError;
    }

    if (errorStr.contains('timeout')) {
      return l10n.timeoutError;
    }

    if (errorStr.contains('unauthorized') ||
        errorStr.contains('401') ||
        errorStr.contains('authentication required')) {
      return l10n.authRequired;
    }

    if (errorStr.contains('invalid response')) {
      return l10n.invalidResponse;
    }

    if (errorStr.contains('source unavailable')) {
      return l10n.sourceUnavailable;
    }

    if (errorStr.contains('rate limit')) {
      return l10n.rateLimited;
    }

    if (errorStr.contains('provider error')) {
      return l10n.providerError;
    }

    if (errorStr.contains('service unavailable')) {
      return l10n.serviceUnavailable;
    }

    if (errorStr.contains('forbidden') || errorStr.contains('403')) {
      return l10n.forbiddenError;
    }

    if (errorStr.contains('not found') || errorStr.contains('404')) {
      return l10n.notFoundError;
    }

    if (errorStr.contains('server') || errorStr.contains('500')) {
      return l10n.serverError;
    }

    return l10n.unknownError;
  }
}
