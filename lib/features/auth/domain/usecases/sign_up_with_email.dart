import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<Either<Failure, AppUser>> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return await repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
