// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState()';
  }
}

/// @nodoc
class $SettingsStateCopyWith<$Res> {
  $SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}

/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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
    TResult Function(SettingsInitial value)? initial,
    TResult Function(SettingsLoading value)? loading,
    TResult Function(SettingsLoaded value)? loaded,
    TResult Function(SettingsSaving value)? saving,
    TResult Function(SettingsSaved value)? saved,
    TResult Function(SettingsError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial() when initial != null:
        return initial(_that);
      case SettingsLoading() when loading != null:
        return loading(_that);
      case SettingsLoaded() when loaded != null:
        return loaded(_that);
      case SettingsSaving() when saving != null:
        return saving(_that);
      case SettingsSaved() when saved != null:
        return saved(_that);
      case SettingsError() when error != null:
        return error(_that);
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
    required TResult Function(SettingsInitial value) initial,
    required TResult Function(SettingsLoading value) loading,
    required TResult Function(SettingsLoaded value) loaded,
    required TResult Function(SettingsSaving value) saving,
    required TResult Function(SettingsSaved value) saved,
    required TResult Function(SettingsError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial():
        return initial(_that);
      case SettingsLoading():
        return loading(_that);
      case SettingsLoaded():
        return loaded(_that);
      case SettingsSaving():
        return saving(_that);
      case SettingsSaved():
        return saved(_that);
      case SettingsError():
        return error(_that);
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
    TResult? Function(SettingsInitial value)? initial,
    TResult? Function(SettingsLoading value)? loading,
    TResult? Function(SettingsLoaded value)? loaded,
    TResult? Function(SettingsSaving value)? saving,
    TResult? Function(SettingsSaved value)? saved,
    TResult? Function(SettingsError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial() when initial != null:
        return initial(_that);
      case SettingsLoading() when loading != null:
        return loading(_that);
      case SettingsLoaded() when loaded != null:
        return loaded(_that);
      case SettingsSaving() when saving != null:
        return saving(_that);
      case SettingsSaved() when saved != null:
        return saved(_that);
      case SettingsError() when error != null:
        return error(_that);
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
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppSettings settings)? loaded,
    TResult Function()? saving,
    TResult Function(AppSettings settings)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial() when initial != null:
        return initial();
      case SettingsLoading() when loading != null:
        return loading();
      case SettingsLoaded() when loaded != null:
        return loaded(_that.settings);
      case SettingsSaving() when saving != null:
        return saving();
      case SettingsSaved() when saved != null:
        return saved(_that.settings);
      case SettingsError() when error != null:
        return error(_that.message);
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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppSettings settings) loaded,
    required TResult Function() saving,
    required TResult Function(AppSettings settings) saved,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial():
        return initial();
      case SettingsLoading():
        return loading();
      case SettingsLoaded():
        return loaded(_that.settings);
      case SettingsSaving():
        return saving();
      case SettingsSaved():
        return saved(_that.settings);
      case SettingsError():
        return error(_that.message);
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
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppSettings settings)? loaded,
    TResult? Function()? saving,
    TResult? Function(AppSettings settings)? saved,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsInitial() when initial != null:
        return initial();
      case SettingsLoading() when loading != null:
        return loading();
      case SettingsLoaded() when loaded != null:
        return loaded(_that.settings);
      case SettingsSaving() when saving != null:
        return saving();
      case SettingsSaved() when saved != null:
        return saved(_that.settings);
      case SettingsError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SettingsInitial implements SettingsState {
  const SettingsInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState.initial()';
  }
}

/// @nodoc

class SettingsLoading implements SettingsState {
  const SettingsLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState.loading()';
  }
}

/// @nodoc

class SettingsLoaded implements SettingsState {
  const SettingsLoaded({required this.settings});

  final AppSettings settings;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsLoadedCopyWith<SettingsLoaded> get copyWith =>
      _$SettingsLoadedCopyWithImpl<SettingsLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsLoaded &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsState.loaded(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $SettingsLoadedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory $SettingsLoadedCopyWith(
          SettingsLoaded value, $Res Function(SettingsLoaded) _then) =
      _$SettingsLoadedCopyWithImpl;
  @useResult
  $Res call({AppSettings settings});
}

/// @nodoc
class _$SettingsLoadedCopyWithImpl<$Res>
    implements $SettingsLoadedCopyWith<$Res> {
  _$SettingsLoadedCopyWithImpl(this._self, this._then);

  final SettingsLoaded _self;
  final $Res Function(SettingsLoaded) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(SettingsLoaded(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
    ));
  }
}

/// @nodoc

class SettingsSaving implements SettingsState {
  const SettingsSaving();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsSaving);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState.saving()';
  }
}

/// @nodoc

class SettingsSaved implements SettingsState {
  const SettingsSaved({required this.settings});

  final AppSettings settings;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsSavedCopyWith<SettingsSaved> get copyWith =>
      _$SettingsSavedCopyWithImpl<SettingsSaved>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsSaved &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsState.saved(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class $SettingsSavedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory $SettingsSavedCopyWith(
          SettingsSaved value, $Res Function(SettingsSaved) _then) =
      _$SettingsSavedCopyWithImpl;
  @useResult
  $Res call({AppSettings settings});
}

/// @nodoc
class _$SettingsSavedCopyWithImpl<$Res>
    implements $SettingsSavedCopyWith<$Res> {
  _$SettingsSavedCopyWithImpl(this._self, this._then);

  final SettingsSaved _self;
  final $Res Function(SettingsSaved) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(SettingsSaved(
      settings: null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
    ));
  }
}

/// @nodoc

class SettingsError implements SettingsState {
  const SettingsError({required this.message});

  final String message;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsErrorCopyWith<SettingsError> get copyWith =>
      _$SettingsErrorCopyWithImpl<SettingsError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SettingsState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SettingsErrorCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory $SettingsErrorCopyWith(
          SettingsError value, $Res Function(SettingsError) _then) =
      _$SettingsErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SettingsErrorCopyWithImpl<$Res>
    implements $SettingsErrorCopyWith<$Res> {
  _$SettingsErrorCopyWithImpl(this._self, this._then);

  final SettingsError _self;
  final $Res Function(SettingsError) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SettingsError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
