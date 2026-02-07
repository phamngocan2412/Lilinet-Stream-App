// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc
class $AuthEventCopyWith<$Res> {
  $AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}

/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus() when checkAuthStatus != null:
        return checkAuthStatus(_that);
      case SignInRequested() when signInRequested != null:
        return signInRequested(_that);
      case AuthSubmitted() when authSubmitted != null:
        return authSubmitted(_that);
      case SignUpRequested() when signUpRequested != null:
        return signUpRequested(_that);
      case SignOutRequested() when signOutRequested != null:
        return signOutRequested(_that);
      case AuthStateChanged() when authStateChanged != null:
        return authStateChanged(_that);
      case PasswordResetRequested() when passwordResetRequested != null:
        return passwordResetRequested(_that);
      case UpdateProfileRequested() when updateProfileRequested != null:
        return updateProfileRequested(_that);
      case ChangePasswordRequested() when changePasswordRequested != null:
        return changePasswordRequested(_that);
      case DeleteAccountRequested() when deleteAccountRequested != null:
        return deleteAccountRequested(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus():
        return checkAuthStatus(_that);
      case SignInRequested():
        return signInRequested(_that);
      case AuthSubmitted():
        return authSubmitted(_that);
      case SignUpRequested():
        return signUpRequested(_that);
      case SignOutRequested():
        return signOutRequested(_that);
      case AuthStateChanged():
        return authStateChanged(_that);
      case PasswordResetRequested():
        return passwordResetRequested(_that);
      case UpdateProfileRequested():
        return updateProfileRequested(_that);
      case ChangePasswordRequested():
        return changePasswordRequested(_that);
      case DeleteAccountRequested():
        return deleteAccountRequested(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus() when checkAuthStatus != null:
        return checkAuthStatus(_that);
      case SignInRequested() when signInRequested != null:
        return signInRequested(_that);
      case AuthSubmitted() when authSubmitted != null:
        return authSubmitted(_that);
      case SignUpRequested() when signUpRequested != null:
        return signUpRequested(_that);
      case SignOutRequested() when signOutRequested != null:
        return signOutRequested(_that);
      case AuthStateChanged() when authStateChanged != null:
        return authStateChanged(_that);
      case PasswordResetRequested() when passwordResetRequested != null:
        return passwordResetRequested(_that);
      case UpdateProfileRequested() when updateProfileRequested != null:
        return updateProfileRequested(_that);
      case ChangePasswordRequested() when changePasswordRequested != null:
        return changePasswordRequested(_that);
      case DeleteAccountRequested() when deleteAccountRequested != null:
        return deleteAccountRequested(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus() when checkAuthStatus != null:
        return checkAuthStatus();
      case SignInRequested() when signInRequested != null:
        return signInRequested(_that.email, _that.password);
      case AuthSubmitted() when authSubmitted != null:
        return authSubmitted(_that.username, _that.password, _that.isLogin);
      case SignUpRequested() when signUpRequested != null:
        return signUpRequested(_that.email, _that.password, _that.displayName);
      case SignOutRequested() when signOutRequested != null:
        return signOutRequested();
      case AuthStateChanged() when authStateChanged != null:
        return authStateChanged(_that.isAuthenticated);
      case PasswordResetRequested() when passwordResetRequested != null:
        return passwordResetRequested(_that.email);
      case UpdateProfileRequested() when updateProfileRequested != null:
        return updateProfileRequested(_that.displayName, _that.avatarUrl);
      case ChangePasswordRequested() when changePasswordRequested != null:
        return changePasswordRequested(_that.newPassword);
      case DeleteAccountRequested() when deleteAccountRequested != null:
        return deleteAccountRequested();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus():
        return checkAuthStatus();
      case SignInRequested():
        return signInRequested(_that.email, _that.password);
      case AuthSubmitted():
        return authSubmitted(_that.username, _that.password, _that.isLogin);
      case SignUpRequested():
        return signUpRequested(_that.email, _that.password, _that.displayName);
      case SignOutRequested():
        return signOutRequested();
      case AuthStateChanged():
        return authStateChanged(_that.isAuthenticated);
      case PasswordResetRequested():
        return passwordResetRequested(_that.email);
      case UpdateProfileRequested():
        return updateProfileRequested(_that.displayName, _that.avatarUrl);
      case ChangePasswordRequested():
        return changePasswordRequested(_that.newPassword);
      case DeleteAccountRequested():
        return deleteAccountRequested();
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

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
    final _that = this;
    switch (_that) {
      case CheckAuthStatus() when checkAuthStatus != null:
        return checkAuthStatus();
      case SignInRequested() when signInRequested != null:
        return signInRequested(_that.email, _that.password);
      case AuthSubmitted() when authSubmitted != null:
        return authSubmitted(_that.username, _that.password, _that.isLogin);
      case SignUpRequested() when signUpRequested != null:
        return signUpRequested(_that.email, _that.password, _that.displayName);
      case SignOutRequested() when signOutRequested != null:
        return signOutRequested();
      case AuthStateChanged() when authStateChanged != null:
        return authStateChanged(_that.isAuthenticated);
      case PasswordResetRequested() when passwordResetRequested != null:
        return passwordResetRequested(_that.email);
      case UpdateProfileRequested() when updateProfileRequested != null:
        return updateProfileRequested(_that.displayName, _that.avatarUrl);
      case ChangePasswordRequested() when changePasswordRequested != null:
        return changePasswordRequested(_that.newPassword);
      case DeleteAccountRequested() when deleteAccountRequested != null:
        return deleteAccountRequested();
      case _:
        return null;
    }
  }
}

/// @nodoc

class CheckAuthStatus implements AuthEvent {
  const CheckAuthStatus();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CheckAuthStatus);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.checkAuthStatus()';
  }
}

/// @nodoc

class SignInRequested implements AuthEvent {
  const SignInRequested({required this.email, required this.password});

  final String email;
  final String password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInRequestedCopyWith<SignInRequested> get copyWith =>
      _$SignInRequestedCopyWithImpl<SignInRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInRequested &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @override
  String toString() {
    return 'AuthEvent.signInRequested(email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $SignInRequestedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $SignInRequestedCopyWith(
          SignInRequested value, $Res Function(SignInRequested) _then) =
      _$SignInRequestedCopyWithImpl;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$SignInRequestedCopyWithImpl<$Res>
    implements $SignInRequestedCopyWith<$Res> {
  _$SignInRequestedCopyWithImpl(this._self, this._then);

  final SignInRequested _self;
  final $Res Function(SignInRequested) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(SignInRequested(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthSubmitted implements AuthEvent {
  const AuthSubmitted(
      {required this.username, required this.password, required this.isLogin});

  final String username;
  final String password;
  final bool isLogin;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthSubmittedCopyWith<AuthSubmitted> get copyWith =>
      _$AuthSubmittedCopyWithImpl<AuthSubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthSubmitted &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password, isLogin);

  @override
  String toString() {
    return 'AuthEvent.authSubmitted(username: $username, password: $password, isLogin: $isLogin)';
  }
}

/// @nodoc
abstract mixin class $AuthSubmittedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $AuthSubmittedCopyWith(
          AuthSubmitted value, $Res Function(AuthSubmitted) _then) =
      _$AuthSubmittedCopyWithImpl;
  @useResult
  $Res call({String username, String password, bool isLogin});
}

/// @nodoc
class _$AuthSubmittedCopyWithImpl<$Res>
    implements $AuthSubmittedCopyWith<$Res> {
  _$AuthSubmittedCopyWithImpl(this._self, this._then);

  final AuthSubmitted _self;
  final $Res Function(AuthSubmitted) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? isLogin = null,
  }) {
    return _then(AuthSubmitted(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isLogin: null == isLogin
          ? _self.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class SignUpRequested implements AuthEvent {
  const SignUpRequested(
      {required this.email, required this.password, this.displayName});

  final String email;
  final String password;
  final String? displayName;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignUpRequestedCopyWith<SignUpRequested> get copyWith =>
      _$SignUpRequestedCopyWithImpl<SignUpRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignUpRequested &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, displayName);

  @override
  String toString() {
    return 'AuthEvent.signUpRequested(email: $email, password: $password, displayName: $displayName)';
  }
}

/// @nodoc
abstract mixin class $SignUpRequestedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $SignUpRequestedCopyWith(
          SignUpRequested value, $Res Function(SignUpRequested) _then) =
      _$SignUpRequestedCopyWithImpl;
  @useResult
  $Res call({String email, String password, String? displayName});
}

/// @nodoc
class _$SignUpRequestedCopyWithImpl<$Res>
    implements $SignUpRequestedCopyWith<$Res> {
  _$SignUpRequestedCopyWithImpl(this._self, this._then);

  final SignUpRequested _self;
  final $Res Function(SignUpRequested) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? displayName = freezed,
  }) {
    return _then(SignUpRequested(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class SignOutRequested implements AuthEvent {
  const SignOutRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignOutRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.signOutRequested()';
  }
}

/// @nodoc

class AuthStateChanged implements AuthEvent {
  const AuthStateChanged({required this.isAuthenticated});

  final bool isAuthenticated;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateChangedCopyWith<AuthStateChanged> get copyWith =>
      _$AuthStateChangedCopyWithImpl<AuthStateChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthStateChanged &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAuthenticated);

  @override
  String toString() {
    return 'AuthEvent.authStateChanged(isAuthenticated: $isAuthenticated)';
  }
}

/// @nodoc
abstract mixin class $AuthStateChangedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $AuthStateChangedCopyWith(
          AuthStateChanged value, $Res Function(AuthStateChanged) _then) =
      _$AuthStateChangedCopyWithImpl;
  @useResult
  $Res call({bool isAuthenticated});
}

/// @nodoc
class _$AuthStateChangedCopyWithImpl<$Res>
    implements $AuthStateChangedCopyWith<$Res> {
  _$AuthStateChangedCopyWithImpl(this._self, this._then);

  final AuthStateChanged _self;
  final $Res Function(AuthStateChanged) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isAuthenticated = null,
  }) {
    return _then(AuthStateChanged(
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class PasswordResetRequested implements AuthEvent {
  const PasswordResetRequested({required this.email});

  final String email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PasswordResetRequestedCopyWith<PasswordResetRequested> get copyWith =>
      _$PasswordResetRequestedCopyWithImpl<PasswordResetRequested>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PasswordResetRequested &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @override
  String toString() {
    return 'AuthEvent.passwordResetRequested(email: $email)';
  }
}

/// @nodoc
abstract mixin class $PasswordResetRequestedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $PasswordResetRequestedCopyWith(PasswordResetRequested value,
          $Res Function(PasswordResetRequested) _then) =
      _$PasswordResetRequestedCopyWithImpl;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$PasswordResetRequestedCopyWithImpl<$Res>
    implements $PasswordResetRequestedCopyWith<$Res> {
  _$PasswordResetRequestedCopyWithImpl(this._self, this._then);

  final PasswordResetRequested _self;
  final $Res Function(PasswordResetRequested) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
  }) {
    return _then(PasswordResetRequested(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UpdateProfileRequested implements AuthEvent {
  const UpdateProfileRequested({this.displayName, this.avatarUrl});

  final String? displayName;
  final String? avatarUrl;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateProfileRequestedCopyWith<UpdateProfileRequested> get copyWith =>
      _$UpdateProfileRequestedCopyWithImpl<UpdateProfileRequested>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateProfileRequested &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, avatarUrl);

  @override
  String toString() {
    return 'AuthEvent.updateProfileRequested(displayName: $displayName, avatarUrl: $avatarUrl)';
  }
}

/// @nodoc
abstract mixin class $UpdateProfileRequestedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $UpdateProfileRequestedCopyWith(UpdateProfileRequested value,
          $Res Function(UpdateProfileRequested) _then) =
      _$UpdateProfileRequestedCopyWithImpl;
  @useResult
  $Res call({String? displayName, String? avatarUrl});
}

/// @nodoc
class _$UpdateProfileRequestedCopyWithImpl<$Res>
    implements $UpdateProfileRequestedCopyWith<$Res> {
  _$UpdateProfileRequestedCopyWithImpl(this._self, this._then);

  final UpdateProfileRequested _self;
  final $Res Function(UpdateProfileRequested) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(UpdateProfileRequested(
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class ChangePasswordRequested implements AuthEvent {
  const ChangePasswordRequested({required this.newPassword});

  final String newPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChangePasswordRequestedCopyWith<ChangePasswordRequested> get copyWith =>
      _$ChangePasswordRequestedCopyWithImpl<ChangePasswordRequested>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangePasswordRequested &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newPassword);

  @override
  String toString() {
    return 'AuthEvent.changePasswordRequested(newPassword: $newPassword)';
  }
}

/// @nodoc
abstract mixin class $ChangePasswordRequestedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory $ChangePasswordRequestedCopyWith(ChangePasswordRequested value,
          $Res Function(ChangePasswordRequested) _then) =
      _$ChangePasswordRequestedCopyWithImpl;
  @useResult
  $Res call({String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestedCopyWithImpl<$Res>
    implements $ChangePasswordRequestedCopyWith<$Res> {
  _$ChangePasswordRequestedCopyWithImpl(this._self, this._then);

  final ChangePasswordRequested _self;
  final $Res Function(ChangePasswordRequested) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? newPassword = null,
  }) {
    return _then(ChangePasswordRequested(
      newPassword: null == newPassword
          ? _self.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class DeleteAccountRequested implements AuthEvent {
  const DeleteAccountRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeleteAccountRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.deleteAccountRequested()';
  }
}

// dart format on
