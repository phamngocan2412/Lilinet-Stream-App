// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoritesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Favorite> favorites, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoritesInitial value) initial,
    required TResult Function(FavoritesLoading value) loading,
    required TResult Function(FavoritesLoaded value) loaded,
    required TResult Function(FavoritesError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoritesInitial value)? initial,
    TResult? Function(FavoritesLoading value)? loading,
    TResult? Function(FavoritesLoaded value)? loaded,
    TResult? Function(FavoritesError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoritesInitial value)? initial,
    TResult Function(FavoritesLoading value)? loading,
    TResult Function(FavoritesLoaded value)? loaded,
    TResult Function(FavoritesError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesStateCopyWith<$Res> {
  factory $FavoritesStateCopyWith(
          FavoritesState value, $Res Function(FavoritesState) then) =
      _$FavoritesStateCopyWithImpl<$Res, FavoritesState>;
}

/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res, $Val extends FavoritesState>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FavoritesInitialImplCopyWith<$Res> {
  factory _$$FavoritesInitialImplCopyWith(_$FavoritesInitialImpl value,
          $Res Function(_$FavoritesInitialImpl) then) =
      __$$FavoritesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoritesInitialImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesInitialImpl>
    implements _$$FavoritesInitialImplCopyWith<$Res> {
  __$$FavoritesInitialImplCopyWithImpl(_$FavoritesInitialImpl _value,
      $Res Function(_$FavoritesInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoritesInitialImpl implements FavoritesInitial {
  const _$FavoritesInitialImpl();

  @override
  String toString() {
    return 'FavoritesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoritesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Favorite> favorites, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
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
    required TResult Function(FavoritesInitial value) initial,
    required TResult Function(FavoritesLoading value) loading,
    required TResult Function(FavoritesLoaded value) loaded,
    required TResult Function(FavoritesError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoritesInitial value)? initial,
    TResult? Function(FavoritesLoading value)? loading,
    TResult? Function(FavoritesLoaded value)? loaded,
    TResult? Function(FavoritesError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoritesInitial value)? initial,
    TResult Function(FavoritesLoading value)? loading,
    TResult Function(FavoritesLoaded value)? loaded,
    TResult Function(FavoritesError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FavoritesInitial implements FavoritesState {
  const factory FavoritesInitial() = _$FavoritesInitialImpl;
}

/// @nodoc
abstract class _$$FavoritesLoadingImplCopyWith<$Res> {
  factory _$$FavoritesLoadingImplCopyWith(_$FavoritesLoadingImpl value,
          $Res Function(_$FavoritesLoadingImpl) then) =
      __$$FavoritesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoritesLoadingImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesLoadingImpl>
    implements _$$FavoritesLoadingImplCopyWith<$Res> {
  __$$FavoritesLoadingImplCopyWithImpl(_$FavoritesLoadingImpl _value,
      $Res Function(_$FavoritesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoritesLoadingImpl implements FavoritesLoading {
  const _$FavoritesLoadingImpl();

  @override
  String toString() {
    return 'FavoritesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoritesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Favorite> favorites, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
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
    required TResult Function(FavoritesInitial value) initial,
    required TResult Function(FavoritesLoading value) loading,
    required TResult Function(FavoritesLoaded value) loaded,
    required TResult Function(FavoritesError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoritesInitial value)? initial,
    TResult? Function(FavoritesLoading value)? loading,
    TResult? Function(FavoritesLoaded value)? loaded,
    TResult? Function(FavoritesError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoritesInitial value)? initial,
    TResult Function(FavoritesLoading value)? loading,
    TResult Function(FavoritesLoaded value)? loaded,
    TResult Function(FavoritesError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FavoritesLoading implements FavoritesState {
  const factory FavoritesLoading() = _$FavoritesLoadingImpl;
}

/// @nodoc
abstract class _$$FavoritesLoadedImplCopyWith<$Res> {
  factory _$$FavoritesLoadedImplCopyWith(_$FavoritesLoadedImpl value,
          $Res Function(_$FavoritesLoadedImpl) then) =
      __$$FavoritesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Favorite> favorites, int currentPage, bool hasMore});
}

/// @nodoc
class __$$FavoritesLoadedImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesLoadedImpl>
    implements _$$FavoritesLoadedImplCopyWith<$Res> {
  __$$FavoritesLoadedImplCopyWithImpl(
      _$FavoritesLoadedImpl _value, $Res Function(_$FavoritesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(_$FavoritesLoadedImpl(
      favorites: null == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FavoritesLoadedImpl implements FavoritesLoaded {
  const _$FavoritesLoadedImpl(
      {required final List<Favorite> favorites,
      this.currentPage = 1,
      this.hasMore = true})
      : _favorites = favorites;

  final List<Favorite> _favorites;
  @override
  List<Favorite> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'FavoritesState.loaded(favorites: $favorites, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_favorites), currentPage, hasMore);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesLoadedImplCopyWith<_$FavoritesLoadedImpl> get copyWith =>
      __$$FavoritesLoadedImplCopyWithImpl<_$FavoritesLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Favorite> favorites, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(favorites, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(favorites, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(favorites, currentPage, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoritesInitial value) initial,
    required TResult Function(FavoritesLoading value) loading,
    required TResult Function(FavoritesLoaded value) loaded,
    required TResult Function(FavoritesError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoritesInitial value)? initial,
    TResult? Function(FavoritesLoading value)? loading,
    TResult? Function(FavoritesLoaded value)? loaded,
    TResult? Function(FavoritesError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoritesInitial value)? initial,
    TResult Function(FavoritesLoading value)? loading,
    TResult Function(FavoritesLoaded value)? loaded,
    TResult Function(FavoritesError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FavoritesLoaded implements FavoritesState {
  const factory FavoritesLoaded(
      {required final List<Favorite> favorites,
      final int currentPage,
      final bool hasMore}) = _$FavoritesLoadedImpl;

  List<Favorite> get favorites;
  int get currentPage;
  bool get hasMore;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritesLoadedImplCopyWith<_$FavoritesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FavoritesErrorImplCopyWith<$Res> {
  factory _$$FavoritesErrorImplCopyWith(_$FavoritesErrorImpl value,
          $Res Function(_$FavoritesErrorImpl) then) =
      __$$FavoritesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FavoritesErrorImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesErrorImpl>
    implements _$$FavoritesErrorImplCopyWith<$Res> {
  __$$FavoritesErrorImplCopyWithImpl(
      _$FavoritesErrorImpl _value, $Res Function(_$FavoritesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FavoritesErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FavoritesErrorImpl implements FavoritesError {
  const _$FavoritesErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'FavoritesState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesErrorImplCopyWith<_$FavoritesErrorImpl> get copyWith =>
      __$$FavoritesErrorImplCopyWithImpl<_$FavoritesErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Favorite> favorites, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Favorite> favorites, int currentPage, bool hasMore)?
        loaded,
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
    required TResult Function(FavoritesInitial value) initial,
    required TResult Function(FavoritesLoading value) loading,
    required TResult Function(FavoritesLoaded value) loaded,
    required TResult Function(FavoritesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoritesInitial value)? initial,
    TResult? Function(FavoritesLoading value)? loading,
    TResult? Function(FavoritesLoaded value)? loaded,
    TResult? Function(FavoritesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoritesInitial value)? initial,
    TResult Function(FavoritesLoading value)? loading,
    TResult Function(FavoritesLoaded value)? loaded,
    TResult Function(FavoritesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FavoritesError implements FavoritesState {
  const factory FavoritesError({required final String message}) =
      _$FavoritesErrorImpl;

  String get message;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritesErrorImplCopyWith<_$FavoritesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
