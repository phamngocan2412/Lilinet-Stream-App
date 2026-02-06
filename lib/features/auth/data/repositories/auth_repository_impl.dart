import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/repository_extensions.dart';
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
    return safeCall(() async {
      final user = await dataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return user.toEntity();
    });
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return safeCall(() async {
      final user = await dataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return user.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return safeCall(() async {
      await dataSource.signOut();
    });
  }

  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    return safeCall(() async {
      final user = await dataSource.getCurrentUser();
      return user?.toEntity();
    });
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return dataSource.authStateChanges.map((user) => user?.toEntity());
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    return safeCall(() async {
      await dataSource.sendPasswordResetEmail(email);
    });
  }

  @override
  Future<Either<Failure, AppUser>> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    return safeCall(() async {
      final user = await dataSource.updateProfile(
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
      return user.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> changePassword(String newPassword) async {
    return safeCall(() async {
      await dataSource.changePassword(newPassword);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    return safeCall(() async {
      await dataSource.deleteAccount();
    });
  }
}
