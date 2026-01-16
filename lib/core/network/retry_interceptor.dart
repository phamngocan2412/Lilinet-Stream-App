import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryInterval;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = 1000,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final options = err.requestOptions;
        // Attempt retries
        for (var i = 0; i < maxRetries; i++) {
          final retryAttempt = i + 1;
          await Future.delayed(
            Duration(milliseconds: retryInterval * retryAttempt),
          );

          try {
            final response = await dio.fetch(options);
            return handler.resolve(response);
          } catch (e) {
            if (i == maxRetries - 1) {
              // Last attempt failed
              return super.onError(err, handler);
            }
            // Continue to next retry
          }
        }
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.error is SocketException);
  }
}
