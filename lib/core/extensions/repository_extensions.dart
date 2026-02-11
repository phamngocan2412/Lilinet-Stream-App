import 'dart:io';
import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../errors/failures.dart';
import '../utils/security_utils.dart';

extension RepositoryHelper on Object {
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } on AuthException catch (e) {
      return Left(Failure.server(e.message));
    } on PostgrestException catch (e) {
      // Handle Supabase/PostgREST errors
      final message = e.message;
      if (message.contains('JWT') ||
          message.contains('auth') ||
          e.code == '42501') {
        return const Left(
          Failure.server('Authentication required'),
        );
      }
      // PostgrestException messages are usually safe from Supabase (e.g. "User not found")
      // but logging it is good practice.
      developer.log('Supabase error: $message',
          error: e, name: 'RepositoryHelper');
      return Left(Failure.server(message));
    } on SocketException {
      return const Left(Failure.network('No internet connection'));
    } on FormatException {
      return const Left(Failure.server('Invalid response format'));
    } catch (e, stackTrace) {
      // Log the full error securely
      final sanitizedError = SecurityUtils.sanitizeUrlInString(e.toString());
      developer.log(
        'Unexpected error in safeCall: $sanitizedError',
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
          Failure.server('Authentication required'),
        );
      }

      // Return generic message instead of raw exception string
      return const Left(Failure.server(
          'An unexpected error occurred. Please try again later.'));
    }
  }

  Failure _mapDioErrorToFailure(DioException error) {
    // Log the details securely
    final sanitizedMessage =
        SecurityUtils.sanitizeUrlInString(error.message ?? 'Unknown error');
    developer.log(
      'Dio error: $sanitizedMessage',
      error: error,
      name: 'RepositoryHelper',
    );

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');
      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection');
      case DioExceptionType.badResponse:
        final data = error.response?.data;

        // Handle new Consumet API Error Format
        // { error: "CODE", message: "...", statusCode: 500, ... }
        if (data is Map) {
          if (data.containsKey('error') && data.containsKey('message')) {
            final code = data['error'];
            final message = data['message'];

            // Map specific backend error codes to user-friendly messages
            switch (code) {
              case 'SOURCE_UNAVAILABLE':
                return const Failure.server('Source unavailable');
              case 'RATE_LIMITED':
                return const Failure.server('Rate limit reached');
              case 'NOT_FOUND':
                return const Failure.server('Data not found');
              case 'INVALID_PARAM':
              case 'MISSING_PARAM':
              case 'BAD_REQUEST':
                return Failure.validation(message);
              case 'PROVIDER_ERROR':
                return const Failure.server('Provider error');
              default:
                return Failure.server(message);
            }
          }

          // Fallback for legacy format { message: "..." }
          if (data.containsKey('message')) {
            return Failure.server(data['message']);
          }
        }

        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const Failure.server('Unauthorized');
        }
        if (statusCode == 403) {
          return const Failure.server('Forbidden');
        }
        if (statusCode == 404) {
          return const Failure.server('Not found');
        }
        if (statusCode == 500) {
          return const Failure.server('Internal server error');
        }
        if (statusCode == 503) {
          return const Failure.server('Service unavailable');
        }

        return Failure.server(sanitizedMessage);
      default:
        return Failure.server(sanitizedMessage);
    }
  }
}
