// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryState()';
  }
}

/// @nodoc
class $HistoryStateCopyWith<$Res> {
  $HistoryStateCopyWith(HistoryState _, $Res Function(HistoryState) __);
}

/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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
    TResult Function(HistoryInitial value)? initial,
    TResult Function(HistoryLoading value)? loading,
    TResult Function(HistoryLoaded value)? loaded,
    TResult Function(HistoryEmpty value)? empty,
    TResult Function(HistoryError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case HistoryInitial() when initial != null:
        return initial(_that);
      case HistoryLoading() when loading != null:
        return loading(_that);
      case HistoryLoaded() when loaded != null:
        return loaded(_that);
      case HistoryEmpty() when empty != null:
        return empty(_that);
      case HistoryError() when error != null:
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
    required TResult Function(HistoryInitial value) initial,
    required TResult Function(HistoryLoading value) loading,
    required TResult Function(HistoryLoaded value) loaded,
    required TResult Function(HistoryEmpty value) empty,
    required TResult Function(HistoryError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case HistoryInitial():
        return initial(_that);
      case HistoryLoading():
        return loading(_that);
      case HistoryLoaded():
        return loaded(_that);
      case HistoryEmpty():
        return empty(_that);
      case HistoryError():
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
    TResult? Function(HistoryInitial value)? initial,
    TResult? Function(HistoryLoading value)? loading,
    TResult? Function(HistoryLoaded value)? loaded,
    TResult? Function(HistoryEmpty value)? empty,
    TResult? Function(HistoryError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case HistoryInitial() when initial != null:
        return initial(_that);
      case HistoryLoading() when loading != null:
        return loading(_that);
      case HistoryLoaded() when loaded != null:
        return loaded(_that);
      case HistoryEmpty() when empty != null:
        return empty(_that);
      case HistoryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WatchProgress> history,  int totalVideos,  int totalTimeSeconds)?  loaded,TResult Function()?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoaded() when loaded != null:
return loaded(_that.history,_that.totalVideos,_that.totalTimeSeconds);case HistoryEmpty() when empty != null:
return empty();case HistoryError() when error != null:
return error(_that.message);case _:
  return orElse();

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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WatchProgress> history,  int totalVideos,  int totalTimeSeconds)  loaded,required TResult Function()  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HistoryInitial():
return initial();case HistoryLoading():
return loading();case HistoryLoaded():
return loaded(_that.history,_that.totalVideos,_that.totalTimeSeconds);case HistoryEmpty():
return empty();case HistoryError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WatchProgress> history,  int totalVideos,  int totalTimeSeconds)?  loaded,TResult? Function()?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoaded() when loaded != null:
return loaded(_that.history,_that.totalVideos,_that.totalTimeSeconds);case HistoryEmpty() when empty != null:
return empty();case HistoryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<WatchProgress> history)? loaded,
    TResult? Function()? empty,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case HistoryInitial() when initial != null:
        return initial();
      case HistoryLoading() when loading != null:
        return loading();
      case HistoryLoaded() when loaded != null:
        return loaded(_that.history);
      case HistoryEmpty() when empty != null:
        return empty();
      case HistoryError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class HistoryInitial implements HistoryState {
  const HistoryInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryState.initial()';
  }
}

/// @nodoc

class HistoryLoading implements HistoryState {
  const HistoryLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryState.loading()';
  }
}

/// @nodoc

class HistoryLoaded implements HistoryState {
  const HistoryLoaded({required final  List<WatchProgress> history, this.totalVideos = 0, this.totalTimeSeconds = 0}): _history = history;
  

  final List<WatchProgress> _history;
  List<WatchProgress> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

@JsonKey() final  int totalVideos;
@JsonKey() final  int totalTimeSeconds;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLoadedCopyWith<HistoryLoaded> get copyWith => _$HistoryLoadedCopyWithImpl<HistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoaded&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.totalVideos, totalVideos) || other.totalVideos == totalVideos)&&(identical(other.totalTimeSeconds, totalTimeSeconds) || other.totalTimeSeconds == totalTimeSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history),totalVideos,totalTimeSeconds);

@override
String toString() {
  return 'HistoryState.loaded(history: $history, totalVideos: $totalVideos, totalTimeSeconds: $totalTimeSeconds)';
}

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_history));

  @override
  String toString() {
    return 'HistoryState.loaded(history: $history)';
  }
}

/// @nodoc
abstract mixin class $HistoryLoadedCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryLoadedCopyWith(HistoryLoaded value, $Res Function(HistoryLoaded) _then) = _$HistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<WatchProgress> history, int totalVideos, int totalTimeSeconds
});




}

/// @nodoc
class _$HistoryLoadedCopyWithImpl<$Res>
    implements $HistoryLoadedCopyWith<$Res> {
  _$HistoryLoadedCopyWithImpl(this._self, this._then);

  final HistoryLoaded _self;
  final $Res Function(HistoryLoaded) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,Object? totalVideos = null,Object? totalTimeSeconds = null,}) {
  return _then(HistoryLoaded(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<WatchProgress>,totalVideos: null == totalVideos ? _self.totalVideos : totalVideos // ignore: cast_nullable_to_non_nullable
as int,totalTimeSeconds: null == totalTimeSeconds ? _self.totalTimeSeconds : totalTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc

class HistoryEmpty implements HistoryState {
  const HistoryEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryState.empty()';
  }
}

/// @nodoc

class HistoryError implements HistoryState {
  const HistoryError({required this.message});

  final String message;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HistoryErrorCopyWith<HistoryError> get copyWith =>
      _$HistoryErrorCopyWithImpl<HistoryError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HistoryError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'HistoryState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $HistoryErrorCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory $HistoryErrorCopyWith(
          HistoryError value, $Res Function(HistoryError) _then) =
      _$HistoryErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$HistoryErrorCopyWithImpl<$Res> implements $HistoryErrorCopyWith<$Res> {
  _$HistoryErrorCopyWithImpl(this._self, this._then);

  final HistoryError _self;
  final $Res Function(HistoryError) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(HistoryError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
