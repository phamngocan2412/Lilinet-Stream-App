import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';
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
        _log('Response: ${response.statusCode} ${response.requestOptions.uri}',
            name: 'SecureLogger');

        // Log Headers (sanitized)
        final headers = response.headers.map;
        if (headers.isNotEmpty) {
          final sanitizedHeaders = _sanitizeData(headers);
          _log('Response Headers: $sanitizedHeaders', name: 'SecureLogger');
        }

        final data = response.data;
        if (data != null) {
          final sanitized = _sanitizeData(data);
          if (sanitized is Map || sanitized is List) {
            try {
              final prettyJson =
                  const JsonEncoder.withIndent('  ').convert(sanitized);
              _log('Response Body:\n$prettyJson', name: 'SecureLogger');
            } catch (e) {
              _log('Response Body: $sanitized', name: 'SecureLogger');
            }
          } else {
            _log('Response Body: $sanitized', name: 'SecureLogger');
          }
        }
      } catch (e) {
        _log('Failed to log secure response: $e', name: 'SecureLogger');
      }
    }
    handler.next(response);
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is String) {
      try {
        // Attempt to parse string as JSON to sanitize internal fields
        if (data.trim().startsWith('{') || data.trim().startsWith('[')) {
          final decoded = jsonDecode(data);
          return _sanitizeData(decoded);
        }
      } catch (_) {
        // Not valid JSON, return as is
      }
      return data;
    }

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
    } else if (data is Uint8List || (data is List<int> && data is! String)) {
      // Handle binary data to prevent massive logs
      return '[Binary Data: ${(data as List).length} bytes]';
    } else if (data is List) {
      return data.map((item) => _sanitizeData(item)).toList();
    } else if (data is ResponseBody) {
      return '[Stream ResponseBody]';
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
