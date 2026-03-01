// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
          HistoryState value, $Res Function(HistoryState) then) =
      _$HistoryStateCopyWithImpl<$Res, HistoryState>;
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res, $Val extends HistoryState>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HistoryInitialImplCopyWith<$Res> {
  factory _$$HistoryInitialImplCopyWith(_$HistoryInitialImpl value,
          $Res Function(_$HistoryInitialImpl) then) =
      __$$HistoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryInitialImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryInitialImpl>
    implements _$$HistoryInitialImplCopyWith<$Res> {
  __$$HistoryInitialImplCopyWithImpl(
      _$HistoryInitialImpl _value, $Res Function(_$HistoryInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryInitialImpl implements HistoryInitial {
  const _$HistoryInitialImpl();

  @override
  String toString() {
    return 'HistoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HistoryInitial implements HistoryState {
  const factory HistoryInitial() = _$HistoryInitialImpl;
}

/// @nodoc
abstract class _$$HistoryLoadingImplCopyWith<$Res> {
  factory _$$HistoryLoadingImplCopyWith(_$HistoryLoadingImpl value,
          $Res Function(_$HistoryLoadingImpl) then) =
      __$$HistoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryLoadingImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryLoadingImpl>
    implements _$$HistoryLoadingImplCopyWith<$Res> {
  __$$HistoryLoadingImplCopyWithImpl(
      _$HistoryLoadingImpl _value, $Res Function(_$HistoryLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryLoadingImpl implements HistoryLoading {
  const _$HistoryLoadingImpl();

  @override
  String toString() {
    return 'HistoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HistoryLoading implements HistoryState {
  const factory HistoryLoading() = _$HistoryLoadingImpl;
}

/// @nodoc
abstract class _$$HistoryLoadedImplCopyWith<$Res> {
  factory _$$HistoryLoadedImplCopyWith(
          _$HistoryLoadedImpl value, $Res Function(_$HistoryLoadedImpl) then) =
      __$$HistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<WatchProgress> history, int totalVideos, int totalTimeSeconds});
}

/// @nodoc
class __$$HistoryLoadedImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryLoadedImpl>
    implements _$$HistoryLoadedImplCopyWith<$Res> {
  __$$HistoryLoadedImplCopyWithImpl(
      _$HistoryLoadedImpl _value, $Res Function(_$HistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
    Object? totalVideos = null,
    Object? totalTimeSeconds = null,
  }) {
    return _then(_$HistoryLoadedImpl(
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<WatchProgress>,
      totalVideos: null == totalVideos
          ? _value.totalVideos
          : totalVideos // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeSeconds: null == totalTimeSeconds
          ? _value.totalTimeSeconds
          : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HistoryLoadedImpl implements HistoryLoaded {
  const _$HistoryLoadedImpl(
      {required final List<WatchProgress> history,
      this.totalVideos = 0,
      this.totalTimeSeconds = 0})
      : _history = history;

  final List<WatchProgress> _history;
  @override
  List<WatchProgress> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final int totalVideos;
  @override
  @JsonKey()
  final int totalTimeSeconds;

  @override
  String toString() {
    return 'HistoryState.loaded(history: $history, totalVideos: $totalVideos, totalTimeSeconds: $totalTimeSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.totalVideos, totalVideos) ||
                other.totalVideos == totalVideos) &&
            (identical(other.totalTimeSeconds, totalTimeSeconds) ||
                other.totalTimeSeconds == totalTimeSeconds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_history),
      totalVideos,
      totalTimeSeconds);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryLoadedImplCopyWith<_$HistoryLoadedImpl> get copyWith =>
      __$$HistoryLoadedImplCopyWithImpl<_$HistoryLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return loaded(history, totalVideos, totalTimeSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(history, totalVideos, totalTimeSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(history, totalVideos, totalTimeSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class HistoryLoaded implements HistoryState {
  const factory HistoryLoaded(
      {required final List<WatchProgress> history,
      final int totalVideos,
      final int totalTimeSeconds}) = _$HistoryLoadedImpl;

  List<WatchProgress> get history;
  int get totalVideos;
  int get totalTimeSeconds;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryLoadedImplCopyWith<_$HistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryEmptyImplCopyWith<$Res> {
  factory _$$HistoryEmptyImplCopyWith(
          _$HistoryEmptyImpl value, $Res Function(_$HistoryEmptyImpl) then) =
      __$$HistoryEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryEmptyImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryEmptyImpl>
    implements _$$HistoryEmptyImplCopyWith<$Res> {
  __$$HistoryEmptyImplCopyWithImpl(
      _$HistoryEmptyImpl _value, $Res Function(_$HistoryEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryEmptyImpl implements HistoryEmpty {
  const _$HistoryEmptyImpl();

  @override
  String toString() {
    return 'HistoryState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class HistoryEmpty implements HistoryState {
  const factory HistoryEmpty() = _$HistoryEmptyImpl;
}

/// @nodoc
abstract class _$$HistoryErrorImplCopyWith<$Res> {
  factory _$$HistoryErrorImplCopyWith(
          _$HistoryErrorImpl value, $Res Function(_$HistoryErrorImpl) then) =
      __$$HistoryErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HistoryErrorImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryErrorImpl>
    implements _$$HistoryErrorImplCopyWith<$Res> {
  __$$HistoryErrorImplCopyWithImpl(
      _$HistoryErrorImpl _value, $Res Function(_$HistoryErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HistoryErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HistoryErrorImpl implements HistoryError {
  const _$HistoryErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'HistoryState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryErrorImplCopyWith<_$HistoryErrorImpl> get copyWith =>
      __$$HistoryErrorImplCopyWithImpl<_$HistoryErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)
        loaded,
    required TResult Function() empty,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<WatchProgress> history, int totalVideos, int totalTimeSeconds)?
        loaded,
    TResult Function()? empty,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HistoryError implements HistoryState {
  const factory HistoryError({required final String message}) =
      _$HistoryErrorImpl;

  String get message;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryErrorImplCopyWith<_$HistoryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
