// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckAuthStatusImplCopyWith<$Res> {
  factory _$$CheckAuthStatusImplCopyWith(_$CheckAuthStatusImpl value,
          $Res Function(_$CheckAuthStatusImpl) then) =
      __$$CheckAuthStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthStatusImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CheckAuthStatusImpl>
    implements _$$CheckAuthStatusImplCopyWith<$Res> {
  __$$CheckAuthStatusImplCopyWithImpl(
      _$CheckAuthStatusImpl _value, $Res Function(_$CheckAuthStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckAuthStatusImpl implements CheckAuthStatus {
  const _$CheckAuthStatusImpl();

  @override
  String toString() {
    return 'AuthEvent.checkAuthStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckAuthStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return checkAuthStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return checkAuthStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return checkAuthStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return checkAuthStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus(this);
    }
    return orElse();
  }
}

abstract class CheckAuthStatus implements AuthEvent {
  const factory CheckAuthStatus() = _$CheckAuthStatusImpl;
}

/// @nodoc
abstract class _$$SignInRequestedImplCopyWith<$Res> {
  factory _$$SignInRequestedImplCopyWith(_$SignInRequestedImpl value,
          $Res Function(_$SignInRequestedImpl) then) =
      __$$SignInRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignInRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInRequestedImpl>
    implements _$$SignInRequestedImplCopyWith<$Res> {
  __$$SignInRequestedImplCopyWithImpl(
      _$SignInRequestedImpl _value, $Res Function(_$SignInRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignInRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignInRequestedImpl implements SignInRequested {
  const _$SignInRequestedImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.signInRequested(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInRequestedImplCopyWith<_$SignInRequestedImpl> get copyWith =>
      __$$SignInRequestedImplCopyWithImpl<_$SignInRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return signInRequested(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return signInRequested?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signInRequested != null) {
      return signInRequested(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return signInRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return signInRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signInRequested != null) {
      return signInRequested(this);
    }
    return orElse();
  }
}

abstract class SignInRequested implements AuthEvent {
  const factory SignInRequested(
      {required final String email,
      required final String password}) = _$SignInRequestedImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignInRequestedImplCopyWith<_$SignInRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSubmittedImplCopyWith<$Res> {
  factory _$$AuthSubmittedImplCopyWith(
          _$AuthSubmittedImpl value, $Res Function(_$AuthSubmittedImpl) then) =
      __$$AuthSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String password, bool isLogin});
}

/// @nodoc
class __$$AuthSubmittedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthSubmittedImpl>
    implements _$$AuthSubmittedImplCopyWith<$Res> {
  __$$AuthSubmittedImplCopyWithImpl(
      _$AuthSubmittedImpl _value, $Res Function(_$AuthSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? isLogin = null,
  }) {
    return _then(_$AuthSubmittedImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isLogin: null == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthSubmittedImpl implements AuthSubmitted {
  const _$AuthSubmittedImpl(
      {required this.username, required this.password, required this.isLogin});

  @override
  final String username;
  @override
  final String password;
  @override
  final bool isLogin;

  @override
  String toString() {
    return 'AuthEvent.authSubmitted(username: $username, password: $password, isLogin: $isLogin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSubmittedImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password, isLogin);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSubmittedImplCopyWith<_$AuthSubmittedImpl> get copyWith =>
      __$$AuthSubmittedImplCopyWithImpl<_$AuthSubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return authSubmitted(username, password, isLogin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return authSubmitted?.call(username, password, isLogin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (authSubmitted != null) {
      return authSubmitted(username, password, isLogin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return authSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return authSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (authSubmitted != null) {
      return authSubmitted(this);
    }
    return orElse();
  }
}

abstract class AuthSubmitted implements AuthEvent {
  const factory AuthSubmitted(
      {required final String username,
      required final String password,
      required final bool isLogin}) = _$AuthSubmittedImpl;

  String get username;
  String get password;
  bool get isLogin;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSubmittedImplCopyWith<_$AuthSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignUpRequestedImplCopyWith<$Res> {
  factory _$$SignUpRequestedImplCopyWith(_$SignUpRequestedImpl value,
          $Res Function(_$SignUpRequestedImpl) then) =
      __$$SignUpRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password, String? displayName});
}

/// @nodoc
class __$$SignUpRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignUpRequestedImpl>
    implements _$$SignUpRequestedImplCopyWith<$Res> {
  __$$SignUpRequestedImplCopyWithImpl(
      _$SignUpRequestedImpl _value, $Res Function(_$SignUpRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? displayName = freezed,
  }) {
    return _then(_$SignUpRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignUpRequestedImpl implements SignUpRequested {
  const _$SignUpRequestedImpl(
      {required this.email, required this.password, this.displayName});

  @override
  final String email;
  @override
  final String password;
  @override
  final String? displayName;

  @override
  String toString() {
    return 'AuthEvent.signUpRequested(email: $email, password: $password, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, displayName);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpRequestedImplCopyWith<_$SignUpRequestedImpl> get copyWith =>
      __$$SignUpRequestedImplCopyWithImpl<_$SignUpRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return signUpRequested(email, password, displayName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return signUpRequested?.call(email, password, displayName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signUpRequested != null) {
      return signUpRequested(email, password, displayName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return signUpRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return signUpRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signUpRequested != null) {
      return signUpRequested(this);
    }
    return orElse();
  }
}

abstract class SignUpRequested implements AuthEvent {
  const factory SignUpRequested(
      {required final String email,
      required final String password,
      final String? displayName}) = _$SignUpRequestedImpl;

  String get email;
  String get password;
  String? get displayName;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpRequestedImplCopyWith<_$SignUpRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignOutRequestedImplCopyWith<$Res> {
  factory _$$SignOutRequestedImplCopyWith(_$SignOutRequestedImpl value,
          $Res Function(_$SignOutRequestedImpl) then) =
      __$$SignOutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignOutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignOutRequestedImpl>
    implements _$$SignOutRequestedImplCopyWith<$Res> {
  __$$SignOutRequestedImplCopyWithImpl(_$SignOutRequestedImpl _value,
      $Res Function(_$SignOutRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignOutRequestedImpl implements SignOutRequested {
  const _$SignOutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.signOutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignOutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return signOutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return signOutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return signOutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return signOutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested(this);
    }
    return orElse();
  }
}

abstract class SignOutRequested implements AuthEvent {
  const factory SignOutRequested() = _$SignOutRequestedImpl;
}

/// @nodoc
abstract class _$$AuthStateChangedImplCopyWith<$Res> {
  factory _$$AuthStateChangedImplCopyWith(_$AuthStateChangedImpl value,
          $Res Function(_$AuthStateChangedImpl) then) =
      __$$AuthStateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isAuthenticated});
}

/// @nodoc
class __$$AuthStateChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthStateChangedImpl>
    implements _$$AuthStateChangedImplCopyWith<$Res> {
  __$$AuthStateChangedImplCopyWithImpl(_$AuthStateChangedImpl _value,
      $Res Function(_$AuthStateChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
  }) {
    return _then(_$AuthStateChangedImpl(
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthStateChangedImpl implements AuthStateChanged {
  const _$AuthStateChangedImpl({required this.isAuthenticated});

  @override
  final bool isAuthenticated;

  @override
  String toString() {
    return 'AuthEvent.authStateChanged(isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateChangedImpl &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAuthenticated);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateChangedImplCopyWith<_$AuthStateChangedImpl> get copyWith =>
      __$$AuthStateChangedImplCopyWithImpl<_$AuthStateChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return authStateChanged(isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return authStateChanged?.call(isAuthenticated);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (authStateChanged != null) {
      return authStateChanged(isAuthenticated);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return authStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return authStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (authStateChanged != null) {
      return authStateChanged(this);
    }
    return orElse();
  }
}

abstract class AuthStateChanged implements AuthEvent {
  const factory AuthStateChanged({required final bool isAuthenticated}) =
      _$AuthStateChangedImpl;

  bool get isAuthenticated;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateChangedImplCopyWith<_$AuthStateChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordResetRequestedImplCopyWith<$Res> {
  factory _$$PasswordResetRequestedImplCopyWith(
          _$PasswordResetRequestedImpl value,
          $Res Function(_$PasswordResetRequestedImpl) then) =
      __$$PasswordResetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$PasswordResetRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$PasswordResetRequestedImpl>
    implements _$$PasswordResetRequestedImplCopyWith<$Res> {
  __$$PasswordResetRequestedImplCopyWithImpl(
      _$PasswordResetRequestedImpl _value,
      $Res Function(_$PasswordResetRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$PasswordResetRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordResetRequestedImpl implements PasswordResetRequested {
  const _$PasswordResetRequestedImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.passwordResetRequested(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetRequestedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetRequestedImplCopyWith<_$PasswordResetRequestedImpl>
      get copyWith => __$$PasswordResetRequestedImplCopyWithImpl<
          _$PasswordResetRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return passwordResetRequested(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return passwordResetRequested?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (passwordResetRequested != null) {
      return passwordResetRequested(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return passwordResetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return passwordResetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (passwordResetRequested != null) {
      return passwordResetRequested(this);
    }
    return orElse();
  }
}

abstract class PasswordResetRequested implements AuthEvent {
  const factory PasswordResetRequested({required final String email}) =
      _$PasswordResetRequestedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordResetRequestedImplCopyWith<_$PasswordResetRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateProfileRequestedImplCopyWith<$Res> {
  factory _$$UpdateProfileRequestedImplCopyWith(
          _$UpdateProfileRequestedImpl value,
          $Res Function(_$UpdateProfileRequestedImpl) then) =
      __$$UpdateProfileRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? displayName, String? avatarUrl});
}

/// @nodoc
class __$$UpdateProfileRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UpdateProfileRequestedImpl>
    implements _$$UpdateProfileRequestedImplCopyWith<$Res> {
  __$$UpdateProfileRequestedImplCopyWithImpl(
      _$UpdateProfileRequestedImpl _value,
      $Res Function(_$UpdateProfileRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$UpdateProfileRequestedImpl(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UpdateProfileRequestedImpl implements UpdateProfileRequested {
  const _$UpdateProfileRequestedImpl({this.displayName, this.avatarUrl});

  @override
  final String? displayName;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'AuthEvent.updateProfileRequested(displayName: $displayName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestedImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, avatarUrl);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestedImplCopyWith<_$UpdateProfileRequestedImpl>
      get copyWith => __$$UpdateProfileRequestedImplCopyWithImpl<
          _$UpdateProfileRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return updateProfileRequested(displayName, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return updateProfileRequested?.call(displayName, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (updateProfileRequested != null) {
      return updateProfileRequested(displayName, avatarUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return updateProfileRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return updateProfileRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (updateProfileRequested != null) {
      return updateProfileRequested(this);
    }
    return orElse();
  }
}

abstract class UpdateProfileRequested implements AuthEvent {
  const factory UpdateProfileRequested(
      {final String? displayName,
      final String? avatarUrl}) = _$UpdateProfileRequestedImpl;

  String? get displayName;
  String? get avatarUrl;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestedImplCopyWith<_$UpdateProfileRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePasswordRequestedImplCopyWith<$Res> {
  factory _$$ChangePasswordRequestedImplCopyWith(
          _$ChangePasswordRequestedImpl value,
          $Res Function(_$ChangePasswordRequestedImpl) then) =
      __$$ChangePasswordRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ChangePasswordRequestedImpl>
    implements _$$ChangePasswordRequestedImplCopyWith<$Res> {
  __$$ChangePasswordRequestedImplCopyWithImpl(
      _$ChangePasswordRequestedImpl _value,
      $Res Function(_$ChangePasswordRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPassword = null,
  }) {
    return _then(_$ChangePasswordRequestedImpl(
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangePasswordRequestedImpl implements ChangePasswordRequested {
  const _$ChangePasswordRequestedImpl({required this.newPassword});

  @override
  final String newPassword;

  @override
  String toString() {
    return 'AuthEvent.changePasswordRequested(newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestedImpl &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newPassword);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestedImplCopyWith<_$ChangePasswordRequestedImpl>
      get copyWith => __$$ChangePasswordRequestedImplCopyWithImpl<
          _$ChangePasswordRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return changePasswordRequested(newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return changePasswordRequested?.call(newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (changePasswordRequested != null) {
      return changePasswordRequested(newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return changePasswordRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return changePasswordRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (changePasswordRequested != null) {
      return changePasswordRequested(this);
    }
    return orElse();
  }
}

abstract class ChangePasswordRequested implements AuthEvent {
  const factory ChangePasswordRequested({required final String newPassword}) =
      _$ChangePasswordRequestedImpl;

  String get newPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestedImplCopyWith<_$ChangePasswordRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteAccountRequestedImplCopyWith<$Res> {
  factory _$$DeleteAccountRequestedImplCopyWith(
          _$DeleteAccountRequestedImpl value,
          $Res Function(_$DeleteAccountRequestedImpl) then) =
      __$$DeleteAccountRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteAccountRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$DeleteAccountRequestedImpl>
    implements _$$DeleteAccountRequestedImplCopyWith<$Res> {
  __$$DeleteAccountRequestedImplCopyWithImpl(
      _$DeleteAccountRequestedImpl _value,
      $Res Function(_$DeleteAccountRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeleteAccountRequestedImpl implements DeleteAccountRequested {
  const _$DeleteAccountRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.deleteAccountRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(String username, String password, bool isLogin)
        authSubmitted,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(bool isAuthenticated) authStateChanged,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function(String? displayName, String? avatarUrl)
        updateProfileRequested,
    required TResult Function(String newPassword) changePasswordRequested,
    required TResult Function() deleteAccountRequested,
  }) {
    return deleteAccountRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(bool isAuthenticated)? authStateChanged,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult? Function(String newPassword)? changePasswordRequested,
    TResult? Function()? deleteAccountRequested,
  }) {
    return deleteAccountRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String username, String password, bool isLogin)?
        authSubmitted,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(bool isAuthenticated)? authStateChanged,
    TResult Function(String email)? passwordResetRequested,
    TResult Function(String? displayName, String? avatarUrl)?
        updateProfileRequested,
    TResult Function(String newPassword)? changePasswordRequested,
    TResult Function()? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (deleteAccountRequested != null) {
      return deleteAccountRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthStatus value) checkAuthStatus,
    required TResult Function(SignInRequested value) signInRequested,
    required TResult Function(AuthSubmitted value) authSubmitted,
    required TResult Function(SignUpRequested value) signUpRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
    required TResult Function(AuthStateChanged value) authStateChanged,
    required TResult Function(PasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(UpdateProfileRequested value)
        updateProfileRequested,
    required TResult Function(ChangePasswordRequested value)
        changePasswordRequested,
    required TResult Function(DeleteAccountRequested value)
        deleteAccountRequested,
  }) {
    return deleteAccountRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(SignInRequested value)? signInRequested,
    TResult? Function(AuthSubmitted value)? authSubmitted,
    TResult? Function(SignUpRequested value)? signUpRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
    TResult? Function(AuthStateChanged value)? authStateChanged,
    TResult? Function(PasswordResetRequested value)? passwordResetRequested,
    TResult? Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult? Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult? Function(DeleteAccountRequested value)? deleteAccountRequested,
  }) {
    return deleteAccountRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthStatus value)? checkAuthStatus,
    TResult Function(SignInRequested value)? signInRequested,
    TResult Function(AuthSubmitted value)? authSubmitted,
    TResult Function(SignUpRequested value)? signUpRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    TResult Function(AuthStateChanged value)? authStateChanged,
    TResult Function(PasswordResetRequested value)? passwordResetRequested,
    TResult Function(UpdateProfileRequested value)? updateProfileRequested,
    TResult Function(ChangePasswordRequested value)? changePasswordRequested,
    TResult Function(DeleteAccountRequested value)? deleteAccountRequested,
    required TResult orElse(),
  }) {
    if (deleteAccountRequested != null) {
      return deleteAccountRequested(this);
    }
    return orElse();
  }
}

abstract class DeleteAccountRequested implements AuthEvent {
  const factory DeleteAccountRequested() = _$DeleteAccountRequestedImpl;
}
