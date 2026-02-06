import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatus;

  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = SignInRequested;

  const factory AuthEvent.authSubmitted({
    required String username,
    required String password,
    required bool isLogin,
  }) = AuthSubmitted;

  const factory AuthEvent.signUpRequested({
    required String email,
    required String password,
    String? displayName,
  }) = SignUpRequested;

  const factory AuthEvent.signOutRequested() = SignOutRequested;

  const factory AuthEvent.authStateChanged({required bool isAuthenticated}) =
      AuthStateChanged;

  const factory AuthEvent.passwordResetRequested({required String email}) =
      PasswordResetRequested;

  const factory AuthEvent.updateProfileRequested({
    String? displayName,
    String? avatarUrl,
  }) = UpdateProfileRequested;

  const factory AuthEvent.changePasswordRequested({
    required String newPassword,
  }) = ChangePasswordRequested;

  const factory AuthEvent.deleteAccountRequested() = DeleteAccountRequested;
}
