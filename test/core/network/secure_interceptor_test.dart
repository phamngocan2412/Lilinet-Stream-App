import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:lilinet_app/core/network/secure_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

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

    group('Query Parameters', () {
      test('redacts sensitive query parameters', () {
        final logs = <String>[];
        final interceptor = SecureInterceptor(
          logCallback: (message, {name = ''}) {
            logs.add(message);
          },
        );
        final options = RequestOptions(
          path: '/api',
          queryParameters: {
            'api_key': 'secret_api_key',
            'token': 'secret_token',
            'public': 'public_value',
          },
        );

        final handler = MockRequestInterceptorHandler();
        interceptor.onRequest(options, handler);

        final requestLog = logs.firstWhere((log) => log.contains('Request:'));

        expect(
            requestLog,
            anyOf(contains('api_key=***REDACTED***'),
                contains('api_key=%2A%2A%2AREDACTED%2A%2A%2A')));
        expect(
            requestLog,
            anyOf(contains('token=***REDACTED***'),
                contains('token=%2A%2A%2AREDACTED%2A%2A%2A')));
        expect(requestLog, contains('public=public_value'));

        expect(requestLog, isNot(contains('secret_api_key')));
        expect(requestLog, isNot(contains('secret_token')));

        verify(() => handler.next(options)).called(1);
      });
    });

    group('Response Logging', () {
      test('redacts sensitive data in response body', () {
        final logs = <String>[];
        final interceptor = SecureInterceptor(
          logCallback: (message, {name = ''}) {
            logs.add(message);
          },
        );
        final options = RequestOptions(path: '/user');
        final response = Response(
          requestOptions: options,
          statusCode: 200,
          statusMessage: 'OK',
          data: {
            'id': 1,
            'email': 'user@example.com',
            'token': 'secret_response_token',
          },
        );

        final handler = MockResponseInterceptorHandler();
        interceptor.onResponse(response, handler);

        final responseLog =
            logs.firstWhere((log) => log.contains('Response Body:'));
        expect(responseLog, contains('"token": "***REDACTED***"'));
        expect(responseLog, contains('"email": "user@example.com"'));
        expect(responseLog, isNot(contains('secret_response_token')));

        verify(() => handler.next(response)).called(1);
      });
    });

    group('Error Logging', () {
      test('redacts sensitive known keys in error response', () {
        final logs = <String>[];
        final interceptor = SecureInterceptor(
          logCallback: (message, {name = ''}) {
            logs.add(message);
          },
        );
        final options = RequestOptions(path: '/login');
        final errorResponse = Response(
          requestOptions: options,
          statusCode: 401,
          statusMessage: 'Unauthorized',
          data: {
            'error': 'Invalid credentials',
            'access_token': 'leaked_access_token',
          },
        );
        final error = DioException(
          requestOptions: options,
          response: errorResponse,
          message: 'Http status error [401]',
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        final errorLog =
            logs.firstWhere((log) => log.contains('Error Response Body:'));
        expect(errorLog, contains('"access_token": "***REDACTED***"'));
        expect(errorLog, isNot(contains('leaked_access_token')));

        verify(() => handler.next(error)).called(1);
      });
    });

    group('JSON String Parsing', () {
      test('parses and redacts JSON string in request body', () {
        final logs = <String>[];
        final interceptor = SecureInterceptor(
          logCallback: (message, {name = ''}) {
            logs.add(message);
          },
        );
        final options = RequestOptions(
          path: '/update',
          data:
              '{"user": "test", "password": "secret_password"}', // Stringified JSON
        );

        final handler = MockRequestInterceptorHandler();
        interceptor.onRequest(options, handler);

        final bodyLog = logs.firstWhere((log) => log.contains('Request Body:'));
        expect(bodyLog, contains('"password": "***REDACTED***"'));
        expect(bodyLog, isNot(contains('secret_password')));

        verify(() => handler.next(options)).called(1);
      });
    });
  });
}
