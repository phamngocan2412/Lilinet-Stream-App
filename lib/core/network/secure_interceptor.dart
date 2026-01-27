import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef LogCallback = void Function(String message, {String name});

class SecureInterceptor extends Interceptor {
  final LogCallback _log;

  SecureInterceptor({LogCallback? logCallback})
      : _log = logCallback ??
            ((message, {name = ''}) => developer.log(message, name: name));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        final data = options.data;
        if (data != null) {
          if (data is Map<String, dynamic>) {
            final sanitized = Map<String, dynamic>.from(data);
            const keysToRedact = [
              'password',
              'confirm_password',
              'old_password',
              'token',
              'access_token',
              'refresh_token',
              'secret'
            ];

            for (final key in keysToRedact) {
              if (sanitized.containsKey(key)) {
                sanitized[key] = '***REDACTED***';
              }
            }

            // Pretty print JSON
            final prettyJson =
                const JsonEncoder.withIndent('  ').convert(sanitized);
            _log('Request Body:\n$prettyJson', name: 'SecureLogger');
          } else if (data is FormData) {
            _log('Request Body: [FormData]', name: 'SecureLogger');
          } else {
            _log('Request Body: $data', name: 'SecureLogger');
          }
        }
      } catch (e) {
        _log('Failed to log secure request body: $e', name: 'SecureLogger');
      }
    }
    handler.next(options);
  }
}
