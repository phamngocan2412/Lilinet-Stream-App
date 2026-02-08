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

      expect(logs.any((log) => log.contains('Request: GET /test-endpoint')),
          isTrue);
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

      final headerLog =
          logs.firstWhere((log) => log.contains('Request Headers:'));
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

    test('redacts sensitive data from JSON string body', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/json-string',
        data: '{"password": "secret_password", "email": "test@example.com"}',
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('"password": "***REDACTED***"'));
      expect(bodyLog, isNot(contains('secret_password')));
    });

    test('logs sanitized response body', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(path: '/response');
      final response = Response(
        requestOptions: options,
        statusCode: 200,
        data: {'token': 'secret_token', 'public': 'data'},
      );

      final handler = ResponseInterceptorHandler();
      interceptor.onResponse(response, handler);

      final bodyLog = logs.firstWhere((log) => log.contains('Response Body:'));
      expect(bodyLog, contains('"token": "***REDACTED***"'));
      expect(bodyLog, contains('"public": "data"'));
      expect(bodyLog, isNot(contains('secret_token')));
    });

    test('handles binary data in request', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/upload',
        data: [1, 2, 3, 4, 5], // List<int>
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('[Binary Data: 5 bytes]'));
      expect(bodyLog, isNot(contains('[1, 2, 3, 4, 5]')));
    });

    test('redacts nested sensitive data', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/nested',
        data: {
          'user': {
            'password': 'nested_secret_password',
            'email': 'test@example.com'
          }
        },
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('"password": "***REDACTED***"'));
      expect(bodyLog, isNot(contains('nested_secret_password')));
    });

    test('redacts sensitive data in lists', () {
      final logs = <String>[];
      final interceptor = SecureInterceptor(
        logCallback: (message, {name = ''}) {
          logs.add(message);
        },
      );

      final options = RequestOptions(
        path: '/bulk',
        data: [
          {'password': 'secret_pass_1'},
          {'password': 'secret_pass_2'}
        ],
      );

      final handler = RequestInterceptorHandler();
      interceptor.onRequest(options, handler);

      final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
      expect(bodyLog, contains('"password": "***REDACTED***"'));
      expect(bodyLog, isNot(contains('secret_pass_1')));
      expect(bodyLog, isNot(contains('secret_pass_2')));
    });
  });
}
