import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import 'retry_interceptor.dart';
import 'secure_interceptor.dart';

class NetworkModule {
  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectionTimeout,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(RetryInterceptor(dio: dio));

    if (kDebugMode) {
      dio.interceptors.add(SecureInterceptor());
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false, // Handled by SecureInterceptor
          requestBody: false, // Handled by SecureInterceptor
          responseBody: false, // Disabled huge body logging
          responseHeader: false,
          error: false, // Handled by SecureInterceptor
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  }
}
