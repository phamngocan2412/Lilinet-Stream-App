import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_supabase_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AppUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await dataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(user.toEntity());
    } on supabase.AuthException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      developer.log('Sign in failed', error: e, name: 'AuthRepository');
      return const Left(
        Failure.server('An unexpected error occurred during sign in.'),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final user = await dataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(user.toEntity());
    } on supabase.AuthException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      developer.log('Sign up failed', error: e, name: 'AuthRepository');
      return const Left(
        Failure.server('An unexpected error occurred during sign up.'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e) {
      developer.log('Sign out failed', error: e, name: 'AuthRepository');
      return const Left(
        Failure.server('An unexpected error occurred during sign out.'),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      final user = await dataSource.getCurrentUser();
      return Right(user?.toEntity());
    } catch (e) {
      developer.log('Get current user failed', error: e, name: 'AuthRepository');
      return const Left(
        Failure.server('An unexpected error occurred while fetching user.'),
      );
    }
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return dataSource.authStateChanges.map((user) => user?.toEntity());
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await dataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on supabase.AuthException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      developer.log('Send password reset email failed', error: e, name: 'AuthRepository');
      return const Left(
        Failure.server('Đã xảy ra lỗi không mong muốn khi gửi email đặt lại mật khẩu.'),
      );
    }
  }
}
