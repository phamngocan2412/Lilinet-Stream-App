import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthSubmitted extends AuthEvent {
  final String username;
  final String password;
  final bool isLogin;

  const AuthSubmitted({
    required this.username,
    required this.password,
    required this.isLogin,
  });

  @override
  List<Object?> get props => [username, password, isLogin];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String? displayName;

  const SignUpRequested({
    required this.email,
    required this.password,
    this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}

class SignOutRequested extends AuthEvent {}

class AuthStateChanged extends AuthEvent {
  final bool isAuthenticated;

  const AuthStateChanged(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}
