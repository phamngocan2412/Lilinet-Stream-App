import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/security_utils.dart';

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
        // Log Method and URI
        final sanitizedUri = SecurityUtils.sanitizeUri(options.uri);
        _log('Request: ${options.method} $sanitizedUri', name: 'SecureLogger');

        // Log Headers with Redaction
        final headers = options.headers;
        if (headers.isNotEmpty) {
          final sanitizedHeaders = SecurityUtils.sanitizeData(headers);
          _log('Request Headers: $sanitizedHeaders', name: 'SecureLogger');
        }

        final data = options.data;
        if (data != null) {
          if (data is FormData) {
            _log('Request Body: [FormData]', name: 'SecureLogger');
          } else {
            final sanitized = SecurityUtils.sanitizeData(data);
            if (sanitized is Map || sanitized is List) {
              try {
                final prettyJson =
                    const JsonEncoder.withIndent('  ').convert(sanitized);
                _log('Request Body:\n$prettyJson', name: 'SecureLogger');
              } catch (e) {
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

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        final sanitizedUri =
            SecurityUtils.sanitizeUri(response.requestOptions.uri);
        _log('Response: ${response.statusCode} $sanitizedUri',
            name: 'SecureLogger');

        // Log Headers (sanitized)
        final headers = response.headers.map;
        if (headers.isNotEmpty) {
          final sanitizedHeaders = SecurityUtils.sanitizeData(headers);
          _log('Response Headers: $sanitizedHeaders', name: 'SecureLogger');
        }

        final data = response.data;
        if (data != null) {
          _logBody(data, 'Response Body');
        }
      } catch (e) {
        _log('Failed to log secure response: $e', name: 'SecureLogger');
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        final sanitizedMessage =
            SecurityUtils.sanitizeUrlInString(err.message ?? '');
        _log(
          'Error: ${err.error} $sanitizedMessage',
          name: 'SecureLogger',
        );

        final response = err.response;
        if (response != null) {
          final sanitizedUri =
              SecurityUtils.sanitizeUri(response.requestOptions.uri);
          _log(
            'Error Response: ${response.statusCode} $sanitizedUri',
            name: 'SecureLogger',
          );

          final headers = response.headers.map;
          if (headers.isNotEmpty) {
            final sanitizedHeaders = SecurityUtils.sanitizeData(headers);
            _log(
              'Error Response Headers: $sanitizedHeaders',
              name: 'SecureLogger',
            );
          }

          final data = response.data;
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

  void _logBody(dynamic data, String label) {
    final sanitized = SecurityUtils.sanitizeData(data);
    if (sanitized is Map || sanitized is List) {
      try {
        final prettyJson = const JsonEncoder.withIndent(
          '  ',
        ).convert(sanitized);
        _log('$label:\n$prettyJson', name: 'SecureLogger');
      } catch (e) {
        _log('$label: $sanitized', name: 'SecureLogger');
      }
    } else {
      _log('$label: $sanitized', name: 'SecureLogger');
    }
  }
}
