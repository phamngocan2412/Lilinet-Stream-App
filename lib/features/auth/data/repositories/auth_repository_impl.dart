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
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Sign in failed: ${e.toString()}'));
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
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Sign up failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Sign out failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      final user = await dataSource.getCurrentUser();
      return Right(user?.toEntity());
    } catch (e) {
      return Left(ServerFailure('Get current user failed: ${e.toString()}'));
    }
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return dataSource.authStateChanges.map((user) => user?.toEntity());
  }
}
