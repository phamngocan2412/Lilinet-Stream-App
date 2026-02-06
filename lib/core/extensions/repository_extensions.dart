import 'dart:io';
import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:postgrest/postgrest.dart';
import '../errors/failures.dart';

extension RepositoryHelper on Object {
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } on PostgrestException catch (e) {
      // Handle Supabase/PostgREST errors
      final message = e.message;
      if (message.contains('JWT') ||
          message.contains('auth') ||
          e.code == '42501') {
        return const Left(
          Failure.server('Không thể truy cập. Vui lòng đăng nhập.'),
        );
      }
      // PostgrestException messages are usually safe from Supabase (e.g. "User not found")
      // but logging it is good practice.
      developer.log('Supabase error: $message', error: e, name: 'RepositoryHelper');
      return Left(Failure.server(message));
    } on SocketException {
      return const Left(Failure.network('Không có kết nối internet'));
    } on FormatException {
      return const Left(Failure.server('Định dạng phản hồi không hợp lệ'));
    } catch (e, stackTrace) {
      // Log the full error securely
      developer.log(
        'Unexpected error in safeCall',
        error: e,
        stackTrace: stackTrace,
        name: 'RepositoryHelper',
      );

      // Check if it's an auth/permission error
      final errorStr = e.toString().toLowerCase();
      if (errorStr.contains('unauthorized') ||
          errorStr.contains('permission') ||
          errorStr.contains('jwt') ||
          errorStr.contains('auth')) {
        return const Left(
          Failure.server('Không thể truy cập dữ liệu. Vui lòng đăng nhập.'),
        );
      }

      // Return generic message instead of raw exception string
      return const Left(Failure.server('An unexpected error occurred. Please try again later.'));
    }
  }

  Failure _mapDioErrorToFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');
      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) return const Failure.server('Unauthorized');
        if (statusCode == 404) {
          return const Failure.server('Resource not found');
        }
        if (statusCode == 500) return const Failure.server('Server error');

        final data = error.response?.data;
        if (data is Map && data.containsKey('message')) {
          // Assuming backend returned message is safe to display
          return Failure.server(data['message']);
        }

        return const Failure.server('Server error');
      default:
        // Log the details securely
        developer.log(
          'Dio error: ${error.message}',
          error: error,
          name: 'RepositoryHelper',
        );
        // Return generic message instead of leaking URL/headers
        return const Failure.server('An unexpected network error occurred.');
    }
  }
}
