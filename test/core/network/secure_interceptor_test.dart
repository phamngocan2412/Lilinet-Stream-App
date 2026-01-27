import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:lilinet_app/core/network/secure_interceptor.dart';

void main() {
  group('SecureInterceptor', () {
    test('redacts password from JSON body', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/login',
        data: {
          'email': 'test@example.com',
          'password': 'secret_password',
        },
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      expect(logs.length, 1);
      expect(logs.first, contains('"password": "***REDACTED***"'));
      expect(logs.first, contains('"email": "test@example.com"'));
      expect(logs.first, isNot(contains('secret_password')));
    });

    test('redacts token from JSON body', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/refresh',
        data: {
          'token': 'secret_token',
        },
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      expect(logs.length, 1);
      expect(logs.first, contains('"token": "***REDACTED***"'));
      expect(logs.first, isNot(contains('secret_token')));
    });

    test('handles non-map data gracefully', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/search',
        data: 'plain text query',
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      expect(logs.length, 1);
      expect(logs.first, contains('plain text query'));
    });
  });
}
