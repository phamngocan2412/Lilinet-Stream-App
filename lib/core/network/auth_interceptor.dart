import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  AuthInterceptor(this._dio, this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _secureStorage.read(key: 'refresh_token');
        if (refreshToken != null) {
          // Check if we already tried to refresh
          // To prevent infinite loops, we can check a custom header or internal state
          // but for simplicity we'll just try once if it's not the refresh endpoint itself
          if (err.requestOptions.path.contains('/auth/refresh')) {
            return handler.next(err);
          }

          // Call refresh endpoint
          // Note: using a new Dio instance or the same one carefully to avoid loop
          // Ideally use a separate Dio for auth, or ensure this request doesn't trigger interceptor
          final refreshResponse = await _dio.post(
            '/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (refreshResponse.statusCode == 200) {
            final newToken = refreshResponse.data['access_token'];
            await _secureStorage.write(key: 'auth_token', value: newToken);

            // Retry original request
            final opts = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            );

            final retryResponse = await _dio.fetch(
              err.requestOptions..headers = opts.headers,
            );
            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        // Refresh failed, logout user or just fail
        await _secureStorage.deleteAll();
        return handler.reject(err);
      }
    }
    handler.next(err);
  }
}
