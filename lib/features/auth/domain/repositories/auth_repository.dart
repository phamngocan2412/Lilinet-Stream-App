import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, AppUser?>> getCurrentUser();

  /// Sends a password reset email to the specified email address.
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Updates the user's profile information.
  Future<Either<Failure, AppUser>> updateProfile({
    String? displayName,
    String? avatarUrl,
  });

  /// Changes the user's password.
  Future<Either<Failure, void>> changePassword(String newPassword);

  /// Deletes the user's account and all associated data.
  Future<Either<Failure, void>> deleteAccount();

  Stream<AppUser?> get authStateChanges;
}
