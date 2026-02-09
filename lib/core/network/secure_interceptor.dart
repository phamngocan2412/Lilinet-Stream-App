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
    'api_key',
    'apikey',
    'bearer',
    'session_id',
    'jwt',
    'access_key',
    'otp',
    'code',
  };

  SecureInterceptor({LogCallback? logCallback})
      : _log = logCallback ??
            ((message, {name = ''}) => developer.log(message, name: name));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        // Log Method and URI
        final sanitizedUri = _sanitizeUri(options.uri);
        _log('Request: ${options.method} $sanitizedUri', name: 'SecureLogger');

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
            _logBody(data, 'Request Body');
          }
        }
      } catch (e) {
        _log('Failed to log secure request body: $e', name: 'SecureLogger');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        _log('Response: ${response.statusCode} ${response.statusMessage}',
            name: 'SecureLogger');

        final data = response.data;
        if (data != null) {
          _logBody(data, 'Response Body');
        }
      } catch (e) {
        _log('Failed to log secure response body: $e', name: 'SecureLogger');
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        _log('Error: ${err.message}', name: 'SecureLogger');
        if (err.response != null) {
          _log(
              'Error Response: ${err.response?.statusCode} ${err.response?.statusMessage}',
              name: 'SecureLogger');
          final data = err.response?.data;
          if (data != null) {
            _logBody(data, 'Error Response Body');
          }
        }
      } catch (e) {
        _log('Failed to log secure error: $e', name: 'SecureLogger');
      }
    }
    handler.next(err);
  }

  void _logBody(dynamic data, String prefix) {
    // Recursive sanitization
    final sanitized = _sanitizeData(data);

    // Pretty print JSON if possible
    if (sanitized is Map || sanitized is List) {
      try {
        final prettyJson =
            const JsonEncoder.withIndent('  ').convert(sanitized);
        _log('$prefix:\n$prettyJson', name: 'SecureLogger');
      } catch (e) {
        // Fallback for non-encodable data
        _log('$prefix: $sanitized', name: 'SecureLogger');
      }
    } else {
      _log('$prefix: $sanitized', name: 'SecureLogger');
    }
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is String) {
      try {
        // Attempt to parse string as JSON
        final decoded = jsonDecode(data);
        if (decoded is Map || decoded is List) {
          // If it is valid JSON, sanitize it recursively
          return _sanitizeData(decoded);
        }
      } catch (_) {
        // Not a JSON string, return as is
      }
      return data;
    } else if (data is Map) {
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

  Uri _sanitizeUri(Uri uri) {
    if (uri.queryParameters.isEmpty) return uri;

    final sanitizedParams = <String, dynamic>{};
    uri.queryParameters.forEach((key, value) {
      if (_keysToRedact.contains(key.toLowerCase())) {
        sanitizedParams[key] = '***REDACTED***';
      } else {
        sanitizedParams[key] = value;
      }
    });

    return uri.replace(queryParameters: sanitizedParams);
  }
}
