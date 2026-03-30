// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_movies_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrendingMoviesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) load,
    required TResult Function() refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? load,
    TResult? Function()? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? load,
    TResult Function()? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTrendingMovies value) load,
    required TResult Function(RefreshTrendingMovies value) refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTrendingMovies value)? load,
    TResult? Function(RefreshTrendingMovies value)? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTrendingMovies value)? load,
    TResult Function(RefreshTrendingMovies value)? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendingMoviesEventCopyWith<$Res> {
  factory $TrendingMoviesEventCopyWith(
    TrendingMoviesEvent value,
    $Res Function(TrendingMoviesEvent) then,
  ) = _$TrendingMoviesEventCopyWithImpl<$Res, TrendingMoviesEvent>;
}

/// @nodoc
class _$TrendingMoviesEventCopyWithImpl<$Res, $Val extends TrendingMoviesEvent>
    implements $TrendingMoviesEventCopyWith<$Res> {
  _$TrendingMoviesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendingMoviesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTrendingMoviesImplCopyWith<$Res> {
  factory _$$LoadTrendingMoviesImplCopyWith(
    _$LoadTrendingMoviesImpl value,
    $Res Function(_$LoadTrendingMoviesImpl) then,
  ) = __$$LoadTrendingMoviesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String type});
}

/// @nodoc
class __$$LoadTrendingMoviesImplCopyWithImpl<$Res>
    extends _$TrendingMoviesEventCopyWithImpl<$Res, _$LoadTrendingMoviesImpl>
    implements _$$LoadTrendingMoviesImplCopyWith<$Res> {
  __$$LoadTrendingMoviesImplCopyWithImpl(
    _$LoadTrendingMoviesImpl _value,
    $Res Function(_$LoadTrendingMoviesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrendingMoviesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null}) {
    return _then(
      _$LoadTrendingMoviesImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadTrendingMoviesImpl implements LoadTrendingMovies {
  const _$LoadTrendingMoviesImpl({this.type = 'all'});

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'TrendingMoviesEvent.load(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTrendingMoviesImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of TrendingMoviesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTrendingMoviesImplCopyWith<_$LoadTrendingMoviesImpl> get copyWith =>
      __$$LoadTrendingMoviesImplCopyWithImpl<_$LoadTrendingMoviesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) load,
    required TResult Function() refresh,
  }) {
    return load(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? load,
    TResult? Function()? refresh,
  }) {
    return load?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? load,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTrendingMovies value) load,
    required TResult Function(RefreshTrendingMovies value) refresh,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTrendingMovies value)? load,
    TResult? Function(RefreshTrendingMovies value)? refresh,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTrendingMovies value)? load,
    TResult Function(RefreshTrendingMovies value)? refresh,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadTrendingMovies implements TrendingMoviesEvent {
  const factory LoadTrendingMovies({final String type}) =
      _$LoadTrendingMoviesImpl;

  String get type;

  /// Create a copy of TrendingMoviesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTrendingMoviesImplCopyWith<_$LoadTrendingMoviesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTrendingMoviesImplCopyWith<$Res> {
  factory _$$RefreshTrendingMoviesImplCopyWith(
    _$RefreshTrendingMoviesImpl value,
    $Res Function(_$RefreshTrendingMoviesImpl) then,
  ) = __$$RefreshTrendingMoviesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshTrendingMoviesImplCopyWithImpl<$Res>
    extends _$TrendingMoviesEventCopyWithImpl<$Res, _$RefreshTrendingMoviesImpl>
    implements _$$RefreshTrendingMoviesImplCopyWith<$Res> {
  __$$RefreshTrendingMoviesImplCopyWithImpl(
    _$RefreshTrendingMoviesImpl _value,
    $Res Function(_$RefreshTrendingMoviesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrendingMoviesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshTrendingMoviesImpl implements RefreshTrendingMovies {
  const _$RefreshTrendingMoviesImpl();

  @override
  String toString() {
    return 'TrendingMoviesEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTrendingMoviesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String type) load,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String type)? load,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String type)? load,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTrendingMovies value) load,
    required TResult Function(RefreshTrendingMovies value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTrendingMovies value)? load,
    TResult? Function(RefreshTrendingMovies value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTrendingMovies value)? load,
    TResult Function(RefreshTrendingMovies value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshTrendingMovies implements TrendingMoviesEvent {
  const factory RefreshTrendingMovies() = _$RefreshTrendingMoviesImpl;
}
