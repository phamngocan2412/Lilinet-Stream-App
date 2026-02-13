import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class SecurityUtils {
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

  static dynamic sanitizeData(dynamic data) {
    if (data is String) {
      try {
        if (data.trim().startsWith('{') || data.trim().startsWith('[')) {
          final decoded = jsonDecode(data);
          return sanitizeData(decoded);
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
          sanitized[key] = sanitizeData(value);
        }
      }
      return sanitized;
    } else if (data is Uint8List || (data is List<int> && data is! String)) {
      return '[Binary Data: ${(data as List).length} bytes]';
    } else if (data is List) {
      return data.map((item) => sanitizeData(item)).toList();
    } else if (data is ResponseBody) {
      return '[Stream ResponseBody]';
    }

    return data;
  }

  static Uri sanitizeUri(Uri uri) {
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

  /// Sanitizes any URLs found in the string by redacting sensitive query parameters.
  static String sanitizeUrlInString(String message) {
    final urlRegex = RegExp(r'(https?:\/\/[^\s]+)');
    return message.replaceAllMapped(urlRegex, (match) {
      try {
        final urlString = match.group(0)!;
        // Handle cases where the URL might be wrapped in quotes or brackets if regex caught them
        // For simplicity, we just parse what we found.
        // If it fails to parse, we return it as is.
        final uri = Uri.parse(urlString);
        return sanitizeUri(uri).toString();
      } catch (_) {
        return match.group(0)!;
      }
    });
  }
}
