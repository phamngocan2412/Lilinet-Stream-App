// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamingState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StreamingState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StreamingState()';
  }
}

/// @nodoc
class $StreamingStateCopyWith<$Res> {
  $StreamingStateCopyWith(StreamingState _, $Res Function(StreamingState) __);
}

/// Adds pattern-matching-related methods to [StreamingState].
extension StreamingStatePatterns on StreamingState {
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
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial() when initial != null:
        return initial(_that);
      case StreamingLoading() when loading != null:
        return loading(_that);
      case StreamingLoaded() when loaded != null:
        return loaded(_that);
      case StreamingError() when error != null:
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
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial():
        return initial(_that);
      case StreamingLoading():
        return loading(_that);
      case StreamingLoaded():
        return loaded(_that);
      case StreamingError():
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
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial() when initial != null:
        return initial(_that);
      case StreamingLoading() when loading != null:
        return loading(_that);
      case StreamingLoaded() when loaded != null:
        return loaded(_that);
      case StreamingError() when error != null:
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
    TResult Function(List<StreamingLink> links, String selectedServer,
            String? selectedQuality)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial() when initial != null:
        return initial();
      case StreamingLoading() when loading != null:
        return loading();
      case StreamingLoaded() when loaded != null:
        return loaded(_that.links, _that.selectedServer, _that.selectedQuality);
      case StreamingError() when error != null:
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
    required TResult Function(List<StreamingLink> links, String selectedServer,
            String? selectedQuality)
        loaded,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial():
        return initial();
      case StreamingLoading():
        return loading();
      case StreamingLoaded():
        return loaded(_that.links, _that.selectedServer, _that.selectedQuality);
      case StreamingError():
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
    TResult? Function(List<StreamingLink> links, String selectedServer,
            String? selectedQuality)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case StreamingInitial() when initial != null:
        return initial();
      case StreamingLoading() when loading != null:
        return loading();
      case StreamingLoaded() when loaded != null:
        return loaded(_that.links, _that.selectedServer, _that.selectedQuality);
      case StreamingError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class StreamingInitial implements StreamingState {
  const StreamingInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StreamingInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StreamingState.initial()';
  }
}

/// @nodoc

class StreamingLoading implements StreamingState {
  const StreamingLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StreamingLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StreamingState.loading()';
  }
}

/// @nodoc

class StreamingLoaded implements StreamingState {
  const StreamingLoaded(
      {required final List<StreamingLink> links,
      required this.selectedServer,
      this.selectedQuality})
      : _links = links;

  final List<StreamingLink> _links;
  List<StreamingLink> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final String selectedServer;
  final String? selectedQuality;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StreamingLoadedCopyWith<StreamingLoaded> get copyWith =>
      _$StreamingLoadedCopyWithImpl<StreamingLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreamingLoaded &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.selectedServer, selectedServer) ||
                other.selectedServer == selectedServer) &&
            (identical(other.selectedQuality, selectedQuality) ||
                other.selectedQuality == selectedQuality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      selectedServer,
      selectedQuality);

  @override
  String toString() {
    return 'StreamingState.loaded(links: $links, selectedServer: $selectedServer, selectedQuality: $selectedQuality)';
  }
}

/// @nodoc
abstract mixin class $StreamingLoadedCopyWith<$Res>
    implements $StreamingStateCopyWith<$Res> {
  factory $StreamingLoadedCopyWith(
          StreamingLoaded value, $Res Function(StreamingLoaded) _then) =
      _$StreamingLoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality});
}

/// @nodoc
class _$StreamingLoadedCopyWithImpl<$Res>
    implements $StreamingLoadedCopyWith<$Res> {
  _$StreamingLoadedCopyWithImpl(this._self, this._then);

  final StreamingLoaded _self;
  final $Res Function(StreamingLoaded) _then;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? links = null,
    Object? selectedServer = null,
    Object? selectedQuality = freezed,
  }) {
    return _then(StreamingLoaded(
      links: null == links
          ? _self._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<StreamingLink>,
      selectedServer: null == selectedServer
          ? _self.selectedServer
          : selectedServer // ignore: cast_nullable_to_non_nullable
              as String,
      selectedQuality: freezed == selectedQuality
          ? _self.selectedQuality
          : selectedQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class StreamingError implements StreamingState {
  const StreamingError(this.message);

  final String message;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StreamingErrorCopyWith<StreamingError> get copyWith =>
      _$StreamingErrorCopyWithImpl<StreamingError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreamingError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StreamingState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $StreamingErrorCopyWith<$Res>
    implements $StreamingStateCopyWith<$Res> {
  factory $StreamingErrorCopyWith(
          StreamingError value, $Res Function(StreamingError) _then) =
      _$StreamingErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$StreamingErrorCopyWithImpl<$Res>
    implements $StreamingErrorCopyWith<$Res> {
  _$StreamingErrorCopyWithImpl(this._self, this._then);

  final StreamingError _self;
  final $Res Function(StreamingError) _then;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(StreamingError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
