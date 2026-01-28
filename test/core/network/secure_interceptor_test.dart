import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:lilinet_app/core/network/secure_interceptor.dart';

void main() {
  group('SecureInterceptor', () {
    test('logs request method and URI', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/test-endpoint',
        method: 'GET',
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      expect(logs.any((log) => log.contains('Request: GET /test-endpoint')), isTrue);
    });

    test('redacts Authorization header', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/protected',
        headers: {
          'Authorization': 'Bearer secret_token',
          'Content-Type': 'application/json',
        },
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      final headerLog = logs.firstWhere((log) => log.contains('Request Headers:'));
      expect(headerLog, contains('Authorization: ***REDACTED***'));
      expect(headerLog, contains('Content-Type: application/json'));
      expect(headerLog, isNot(contains('secret_token')));
    });

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

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('"password": "***REDACTED***"'));
      expect(bodyLog, contains('"email": "test@example.com"'));
      expect(bodyLog, isNot(contains('secret_password')));
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

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('"token": "***REDACTED***"'));
      expect(bodyLog, isNot(contains('secret_token')));
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

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('plain text query'));
    });
  });
}
