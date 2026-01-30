import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef LogCallback = void Function(String message, {String name});

class SecureInterceptor extends Interceptor {
  final LogCallback _log;

  static const _keysToRedact = {
    'password',
    'confirm_password',
    'old_password',
    'token',
    'access_token',
    'refresh_token',
    'secret',
    'authorization',
    'cookie',
    'x-auth-token',
  };

  SecureInterceptor({LogCallback? logCallback})
      : _log = logCallback ??
            ((message, {name = ''}) => developer.log(message, name: name));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        // Log Method and URI
        _log('Request: ${options.method} ${options.uri}', name: 'SecureLogger');

        // Log Headers with Redaction
        final headers = options.headers;
        if (headers.isNotEmpty) {
          final sanitizedHeaders = _sanitizeData(headers);
          _log('Request Headers: $sanitizedHeaders', name: 'SecureLogger');
        }

        final data = options.data;
        if (data != null) {
          if (data is FormData) {
            _log('Request Body: [FormData]', name: 'SecureLogger');
          } else {
            // Recursive sanitization
            final sanitized = _sanitizeData(data);

            // Pretty print JSON if possible
            if (sanitized is Map || sanitized is List) {
              try {
                final prettyJson =
                    const JsonEncoder.withIndent('  ').convert(sanitized);
                _log('Request Body:\n$prettyJson', name: 'SecureLogger');
              } catch (e) {
                // Fallback for non-encodable data
                _log('Request Body: $sanitized', name: 'SecureLogger');
              }
            } else {
              _log('Request Body: $sanitized', name: 'SecureLogger');
            }
          }
        }
      } catch (e) {
        _log('Failed to log secure request body: $e', name: 'SecureLogger');
      }
    }
    handler.next(options);
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is Map) {
      final sanitized = <String, dynamic>{};
      for (final entry in data.entries) {
        final key = entry.key.toString();
        final value = entry.value;

        if (_keysToRedact.contains(key.toLowerCase())) {
          sanitized[key] = '***REDACTED***';
        } else {
          sanitized[key] = _sanitizeData(value);
        }
      }
      return sanitized;
    } else if (data is List) {
      return data.map((item) => _sanitizeData(item)).toList();
    }
    return data;
  }
}
