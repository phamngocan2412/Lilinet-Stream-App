import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lilinet_app/features/auth/domain/entities/app_user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/send_password_reset_email.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SendPasswordResetEmail sendPasswordResetEmail;
  final AuthRepository authRepository;

  StreamSubscription? _authStateSubscription;

  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signOut,
    required this.getCurrentUser,
    required this.sendPasswordResetEmail,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInRequested>(_onSignInRequested);
    on<AuthSubmitted>(_onAuthSubmitted);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthStateChanged>(_onAuthStateChanged);
    on<PasswordResetRequested>(_onPasswordResetRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<ChangePasswordRequested>(_onChangePasswordRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);

    // Listen to auth state changes
    _authStateSubscription = authRepository.authStateChanges.listen((user) {
      add(AuthStateChanged(isAuthenticated: user != null));
    });
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await getCurrentUser();
    result.fold((failure) => emit(const Unauthenticated()), (user) {
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  Future<void> _onAuthSubmitted(
    AuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final email = '${event.username.trim()}@lilinet.app';
    final password = event.password;

    if (event.isLogin) {
      final signInResult = await signInWithEmail(
        email: email,
        password: password,
      );
      signInResult.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(Authenticated(user: user)),
      );
    } else {
      final signUpResult = await signUpWithEmail(
        email: email,
        password: password,
        displayName: event.username,
      );
      signUpResult.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(Authenticated(user: user)),
      );
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signInWithEmail(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signUpWithEmail(
      email: event.email,
      password: event.password,
      displayName: event.displayName,
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signOut();
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }

  Future<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.isAuthenticated) {
      final result = await getCurrentUser();
      result.fold((failure) => emit(const Unauthenticated()), (user) {
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(const Unauthenticated());
        }
      });
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onPasswordResetRequested(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await sendPasswordResetEmail(event.email);
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(PasswordResetEmailSent(email: event.email)),
    );
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Keep current user to prevent UI flickering if possible, but AuthLoading is standard
    emit(const AuthLoading());
    final result = await authRepository.updateProfile(
      displayName: event.displayName,
      avatarUrl: event.avatarUrl,
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onChangePasswordRequested(
    ChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentUserState = state;
    AppUser? currentUser;
    if (currentUserState is Authenticated) {
      currentUser = currentUserState.user;
    }

    emit(const AuthLoading());
    final result = await authRepository.changePassword(event.newPassword);
    result.fold((failure) => emit(AuthError(message: failure.message)), (_) {
      // On success, we are still authenticated.
      // Ideally we show a success message.
      // For now, re-emit authenticated state.
      if (currentUser != null) {
        emit(Authenticated(user: currentUser));
      } else {
        // Fallback if we lost user state (shouldn't happen if logic is correct)
        add(const CheckAuthStatus());
      }
    });
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await authRepository.deleteAccount();
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
