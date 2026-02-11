// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StreamingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    ) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingStateCopyWith<$Res> {
  factory $StreamingStateCopyWith(
    StreamingState value,
    $Res Function(StreamingState) then,
  ) = _$StreamingStateCopyWithImpl<$Res, StreamingState>;
}

/// @nodoc
class _$StreamingStateCopyWithImpl<$Res, $Val extends StreamingState>
    implements $StreamingStateCopyWith<$Res> {
  _$StreamingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StreamingInitialImplCopyWith<$Res> {
  factory _$$StreamingInitialImplCopyWith(
    _$StreamingInitialImpl value,
    $Res Function(_$StreamingInitialImpl) then,
  ) = __$$StreamingInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StreamingInitialImplCopyWithImpl<$Res>
    extends _$StreamingStateCopyWithImpl<$Res, _$StreamingInitialImpl>
    implements _$$StreamingInitialImplCopyWith<$Res> {
  __$$StreamingInitialImplCopyWithImpl(
    _$StreamingInitialImpl _value,
    $Res Function(_$StreamingInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StreamingInitialImpl implements StreamingInitial {
  const _$StreamingInitialImpl();

  @override
  String toString() {
    return 'StreamingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StreamingInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    ) loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class StreamingInitial implements StreamingState {
  const factory StreamingInitial() = _$StreamingInitialImpl;
}

/// @nodoc
abstract class _$$StreamingLoadingImplCopyWith<$Res> {
  factory _$$StreamingLoadingImplCopyWith(
    _$StreamingLoadingImpl value,
    $Res Function(_$StreamingLoadingImpl) then,
  ) = __$$StreamingLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StreamingLoadingImplCopyWithImpl<$Res>
    extends _$StreamingStateCopyWithImpl<$Res, _$StreamingLoadingImpl>
    implements _$$StreamingLoadingImplCopyWith<$Res> {
  __$$StreamingLoadingImplCopyWithImpl(
    _$StreamingLoadingImpl _value,
    $Res Function(_$StreamingLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StreamingLoadingImpl implements StreamingLoading {
  const _$StreamingLoadingImpl();

  @override
  String toString() {
    return 'StreamingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StreamingLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    ) loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StreamingLoading implements StreamingState {
  const factory StreamingLoading() = _$StreamingLoadingImpl;
}

/// @nodoc
abstract class _$$StreamingLoadedImplCopyWith<$Res> {
  factory _$$StreamingLoadedImplCopyWith(
    _$StreamingLoadedImpl value,
    $Res Function(_$StreamingLoadedImpl) then,
  ) = __$$StreamingLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<StreamingLink> links,
    String selectedServer,
    String? selectedQuality,
  });
}

/// @nodoc
class __$$StreamingLoadedImplCopyWithImpl<$Res>
    extends _$StreamingStateCopyWithImpl<$Res, _$StreamingLoadedImpl>
    implements _$$StreamingLoadedImplCopyWith<$Res> {
  __$$StreamingLoadedImplCopyWithImpl(
    _$StreamingLoadedImpl _value,
    $Res Function(_$StreamingLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? selectedServer = null,
    Object? selectedQuality = freezed,
  }) {
    return _then(
      _$StreamingLoadedImpl(
        links: null == links
            ? _value._links
            : links // ignore: cast_nullable_to_non_nullable
                as List<StreamingLink>,
        selectedServer: null == selectedServer
            ? _value.selectedServer
            : selectedServer // ignore: cast_nullable_to_non_nullable
                as String,
        selectedQuality: freezed == selectedQuality
            ? _value.selectedQuality
            : selectedQuality // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc

class _$StreamingLoadedImpl implements StreamingLoaded {
  const _$StreamingLoadedImpl({
    required final List<StreamingLink> links,
    required this.selectedServer,
    this.selectedQuality,
  }) : _links = links;

  final List<StreamingLink> _links;
  @override
  List<StreamingLink> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  @override
  final String selectedServer;
  @override
  final String? selectedQuality;

  @override
  String toString() {
    return 'StreamingState.loaded(links: $links, selectedServer: $selectedServer, selectedQuality: $selectedQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingLoadedImpl &&
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
        selectedQuality,
      );

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingLoadedImplCopyWith<_$StreamingLoadedImpl> get copyWith =>
      __$$StreamingLoadedImplCopyWithImpl<_$StreamingLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    ) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(links, selectedServer, selectedQuality);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(links, selectedServer, selectedQuality);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(links, selectedServer, selectedQuality);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class StreamingLoaded implements StreamingState {
  const factory StreamingLoaded({
    required final List<StreamingLink> links,
    required final String selectedServer,
    final String? selectedQuality,
  }) = _$StreamingLoadedImpl;

  List<StreamingLink> get links;
  String get selectedServer;
  String? get selectedQuality;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingLoadedImplCopyWith<_$StreamingLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StreamingErrorImplCopyWith<$Res> {
  factory _$$StreamingErrorImplCopyWith(
    _$StreamingErrorImpl value,
    $Res Function(_$StreamingErrorImpl) then,
  ) = __$$StreamingErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StreamingErrorImplCopyWithImpl<$Res>
    extends _$StreamingStateCopyWithImpl<$Res, _$StreamingErrorImpl>
    implements _$$StreamingErrorImplCopyWith<$Res> {
  __$$StreamingErrorImplCopyWithImpl(
    _$StreamingErrorImpl _value,
    $Res Function(_$StreamingErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$StreamingErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$StreamingErrorImpl implements StreamingError {
  const _$StreamingErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StreamingState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingErrorImplCopyWith<_$StreamingErrorImpl> get copyWith =>
      __$$StreamingErrorImplCopyWithImpl<_$StreamingErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    ) loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
      List<StreamingLink> links,
      String selectedServer,
      String? selectedQuality,
    )? loaded,
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
    required TResult Function(StreamingInitial value) initial,
    required TResult Function(StreamingLoading value) loading,
    required TResult Function(StreamingLoaded value) loaded,
    required TResult Function(StreamingError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StreamingInitial value)? initial,
    TResult? Function(StreamingLoading value)? loading,
    TResult? Function(StreamingLoaded value)? loaded,
    TResult? Function(StreamingError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StreamingInitial value)? initial,
    TResult Function(StreamingLoading value)? loading,
    TResult Function(StreamingLoaded value)? loaded,
    TResult Function(StreamingError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class StreamingError implements StreamingState {
  const factory StreamingError(final String message) = _$StreamingErrorImpl;

  String get message;

  /// Create a copy of StreamingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingErrorImplCopyWith<_$StreamingErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
