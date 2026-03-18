// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoritesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesEventCopyWith<$Res> {
  factory $FavoritesEventCopyWith(
          FavoritesEvent value, $Res Function(FavoritesEvent) then) =
      _$FavoritesEventCopyWithImpl<$Res, FavoritesEvent>;
}

/// @nodoc
class _$FavoritesEventCopyWithImpl<$Res, $Val extends FavoritesEvent>
    implements $FavoritesEventCopyWith<$Res> {
  _$FavoritesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadFavoritesImplCopyWith<$Res> {
  factory _$$LoadFavoritesImplCopyWith(
          _$LoadFavoritesImpl value, $Res Function(_$LoadFavoritesImpl) then) =
      __$$LoadFavoritesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int page});
}

/// @nodoc
class __$$LoadFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$LoadFavoritesImpl>
    implements _$$LoadFavoritesImplCopyWith<$Res> {
  __$$LoadFavoritesImplCopyWithImpl(
      _$LoadFavoritesImpl _value, $Res Function(_$LoadFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$LoadFavoritesImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadFavoritesImpl implements LoadFavorites {
  const _$LoadFavoritesImpl({this.page = 1});

  @override
  @JsonKey()
  final int page;

  @override
  String toString() {
    return 'FavoritesEvent.loadFavorites(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFavoritesImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFavoritesImplCopyWith<_$LoadFavoritesImpl> get copyWith =>
      __$$LoadFavoritesImplCopyWithImpl<_$LoadFavoritesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return loadFavorites(page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return loadFavorites?.call(page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (loadFavorites != null) {
      return loadFavorites(page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return loadFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return loadFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (loadFavorites != null) {
      return loadFavorites(this);
    }
    return orElse();
  }
}

abstract class LoadFavorites implements FavoritesEvent {
  const factory LoadFavorites({final int page}) = _$LoadFavoritesImpl;

  int get page;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadFavoritesImplCopyWith<_$LoadFavoritesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreFavoritesImplCopyWith<$Res> {
  factory _$$LoadMoreFavoritesImplCopyWith(_$LoadMoreFavoritesImpl value,
          $Res Function(_$LoadMoreFavoritesImpl) then) =
      __$$LoadMoreFavoritesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$LoadMoreFavoritesImpl>
    implements _$$LoadMoreFavoritesImplCopyWith<$Res> {
  __$$LoadMoreFavoritesImplCopyWithImpl(_$LoadMoreFavoritesImpl _value,
      $Res Function(_$LoadMoreFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreFavoritesImpl implements LoadMoreFavorites {
  const _$LoadMoreFavoritesImpl();

  @override
  String toString() {
    return 'FavoritesEvent.loadMoreFavorites()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreFavoritesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return loadMoreFavorites();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return loadMoreFavorites?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (loadMoreFavorites != null) {
      return loadMoreFavorites();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return loadMoreFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return loadMoreFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (loadMoreFavorites != null) {
      return loadMoreFavorites(this);
    }
    return orElse();
  }
}

abstract class LoadMoreFavorites implements FavoritesEvent {
  const factory LoadMoreFavorites() = _$LoadMoreFavoritesImpl;
}

/// @nodoc
abstract class _$$AddFavoriteEventImplCopyWith<$Res> {
  factory _$$AddFavoriteEventImplCopyWith(_$AddFavoriteEventImpl value,
          $Res Function(_$AddFavoriteEventImpl) then) =
      __$$AddFavoriteEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String movieId,
      String? movieTitle,
      String? moviePoster,
      String? movieType,
      String folder});
}

/// @nodoc
class __$$AddFavoriteEventImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$AddFavoriteEventImpl>
    implements _$$AddFavoriteEventImplCopyWith<$Res> {
  __$$AddFavoriteEventImplCopyWithImpl(_$AddFavoriteEventImpl _value,
      $Res Function(_$AddFavoriteEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
    Object? movieTitle = freezed,
    Object? moviePoster = freezed,
    Object? movieType = freezed,
    Object? folder = null,
  }) {
    return _then(_$AddFavoriteEventImpl(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
      movieTitle: freezed == movieTitle
          ? _value.movieTitle
          : movieTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      moviePoster: freezed == moviePoster
          ? _value.moviePoster
          : moviePoster // ignore: cast_nullable_to_non_nullable
              as String?,
      movieType: freezed == movieType
          ? _value.movieType
          : movieType // ignore: cast_nullable_to_non_nullable
              as String?,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddFavoriteEventImpl implements AddFavoriteEvent {
  const _$AddFavoriteEventImpl(
      {required this.movieId,
      this.movieTitle,
      this.moviePoster,
      this.movieType,
      this.folder = 'Default'});

  @override
  final String movieId;
  @override
  final String? movieTitle;
  @override
  final String? moviePoster;
  @override
  final String? movieType;
  @override
  @JsonKey()
  final String folder;

  @override
  String toString() {
    return 'FavoritesEvent.addFavorite(movieId: $movieId, movieTitle: $movieTitle, moviePoster: $moviePoster, movieType: $movieType, folder: $folder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFavoriteEventImpl &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.movieTitle, movieTitle) ||
                other.movieTitle == movieTitle) &&
            (identical(other.moviePoster, moviePoster) ||
                other.moviePoster == moviePoster) &&
            (identical(other.movieType, movieType) ||
                other.movieType == movieType) &&
            (identical(other.folder, folder) || other.folder == folder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, movieId, movieTitle, moviePoster, movieType, folder);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFavoriteEventImplCopyWith<_$AddFavoriteEventImpl> get copyWith =>
      __$$AddFavoriteEventImplCopyWithImpl<_$AddFavoriteEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return addFavorite(movieId, movieTitle, moviePoster, movieType, folder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return addFavorite?.call(
        movieId, movieTitle, moviePoster, movieType, folder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (addFavorite != null) {
      return addFavorite(movieId, movieTitle, moviePoster, movieType, folder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return addFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return addFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (addFavorite != null) {
      return addFavorite(this);
    }
    return orElse();
  }
}

abstract class AddFavoriteEvent implements FavoritesEvent {
  const factory AddFavoriteEvent(
      {required final String movieId,
      final String? movieTitle,
      final String? moviePoster,
      final String? movieType,
      final String folder}) = _$AddFavoriteEventImpl;

  String get movieId;
  String? get movieTitle;
  String? get moviePoster;
  String? get movieType;
  String get folder;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddFavoriteEventImplCopyWith<_$AddFavoriteEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFavoriteEventImplCopyWith<$Res> {
  factory _$$RemoveFavoriteEventImplCopyWith(_$RemoveFavoriteEventImpl value,
          $Res Function(_$RemoveFavoriteEventImpl) then) =
      __$$RemoveFavoriteEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String movieId});
}

/// @nodoc
class __$$RemoveFavoriteEventImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$RemoveFavoriteEventImpl>
    implements _$$RemoveFavoriteEventImplCopyWith<$Res> {
  __$$RemoveFavoriteEventImplCopyWithImpl(_$RemoveFavoriteEventImpl _value,
      $Res Function(_$RemoveFavoriteEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
  }) {
    return _then(_$RemoveFavoriteEventImpl(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveFavoriteEventImpl implements RemoveFavoriteEvent {
  const _$RemoveFavoriteEventImpl({required this.movieId});

  @override
  final String movieId;

  @override
  String toString() {
    return 'FavoritesEvent.removeFavorite(movieId: $movieId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFavoriteEventImpl &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFavoriteEventImplCopyWith<_$RemoveFavoriteEventImpl> get copyWith =>
      __$$RemoveFavoriteEventImplCopyWithImpl<_$RemoveFavoriteEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return removeFavorite(movieId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return removeFavorite?.call(movieId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (removeFavorite != null) {
      return removeFavorite(movieId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return removeFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return removeFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (removeFavorite != null) {
      return removeFavorite(this);
    }
    return orElse();
  }
}

abstract class RemoveFavoriteEvent implements FavoritesEvent {
  const factory RemoveFavoriteEvent({required final String movieId}) =
      _$RemoveFavoriteEventImpl;

  String get movieId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFavoriteEventImplCopyWith<_$RemoveFavoriteEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFavoritesImplCopyWith<$Res> {
  factory _$$ClearFavoritesImplCopyWith(_$ClearFavoritesImpl value,
          $Res Function(_$ClearFavoritesImpl) then) =
      __$$ClearFavoritesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$ClearFavoritesImpl>
    implements _$$ClearFavoritesImplCopyWith<$Res> {
  __$$ClearFavoritesImplCopyWithImpl(
      _$ClearFavoritesImpl _value, $Res Function(_$ClearFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFavoritesImpl implements ClearFavorites {
  const _$ClearFavoritesImpl();

  @override
  String toString() {
    return 'FavoritesEvent.clearFavorites()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFavoritesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return clearFavorites();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return clearFavorites?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return clearFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return clearFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites(this);
    }
    return orElse();
  }
}

abstract class ClearFavorites implements FavoritesEvent {
  const factory ClearFavorites() = _$ClearFavoritesImpl;
}

/// @nodoc
abstract class _$$CheckFavoriteStatusImplCopyWith<$Res> {
  factory _$$CheckFavoriteStatusImplCopyWith(_$CheckFavoriteStatusImpl value,
          $Res Function(_$CheckFavoriteStatusImpl) then) =
      __$$CheckFavoriteStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String movieId});
}

/// @nodoc
class __$$CheckFavoriteStatusImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$CheckFavoriteStatusImpl>
    implements _$$CheckFavoriteStatusImplCopyWith<$Res> {
  __$$CheckFavoriteStatusImplCopyWithImpl(_$CheckFavoriteStatusImpl _value,
      $Res Function(_$CheckFavoriteStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
  }) {
    return _then(_$CheckFavoriteStatusImpl(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckFavoriteStatusImpl implements CheckFavoriteStatus {
  const _$CheckFavoriteStatusImpl({required this.movieId});

  @override
  final String movieId;

  @override
  String toString() {
    return 'FavoritesEvent.checkFavoriteStatus(movieId: $movieId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckFavoriteStatusImpl &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckFavoriteStatusImplCopyWith<_$CheckFavoriteStatusImpl> get copyWith =>
      __$$CheckFavoriteStatusImplCopyWithImpl<_$CheckFavoriteStatusImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) loadFavorites,
    required TResult Function() loadMoreFavorites,
    required TResult Function(String movieId, String? movieTitle,
            String? moviePoster, String? movieType, String folder)
        addFavorite,
    required TResult Function(String movieId) removeFavorite,
    required TResult Function() clearFavorites,
    required TResult Function(String movieId) checkFavoriteStatus,
  }) {
    return checkFavoriteStatus(movieId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? loadFavorites,
    TResult? Function()? loadMoreFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    return checkFavoriteStatus?.call(movieId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? loadFavorites,
    TResult Function()? loadMoreFavorites,
    TResult Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType, String folder)?
        addFavorite,
    TResult Function(String movieId)? removeFavorite,
    TResult Function()? clearFavorites,
    TResult Function(String movieId)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (checkFavoriteStatus != null) {
      return checkFavoriteStatus(movieId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavorites value) loadFavorites,
    required TResult Function(LoadMoreFavorites value) loadMoreFavorites,
    required TResult Function(AddFavoriteEvent value) addFavorite,
    required TResult Function(RemoveFavoriteEvent value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
    required TResult Function(CheckFavoriteStatus value) checkFavoriteStatus,
  }) {
    return checkFavoriteStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavorites value)? loadFavorites,
    TResult? Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult? Function(AddFavoriteEvent value)? addFavorite,
    TResult? Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
    TResult? Function(CheckFavoriteStatus value)? checkFavoriteStatus,
  }) {
    return checkFavoriteStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavorites value)? loadFavorites,
    TResult Function(LoadMoreFavorites value)? loadMoreFavorites,
    TResult Function(AddFavoriteEvent value)? addFavorite,
    TResult Function(RemoveFavoriteEvent value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    TResult Function(CheckFavoriteStatus value)? checkFavoriteStatus,
    required TResult orElse(),
  }) {
    if (checkFavoriteStatus != null) {
      return checkFavoriteStatus(this);
    }
    return orElse();
  }
}

abstract class CheckFavoriteStatus implements FavoritesEvent {
  const factory CheckFavoriteStatus({required final String movieId}) =
      _$CheckFavoriteStatusImpl;

  String get movieId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckFavoriteStatusImplCopyWith<_$CheckFavoriteStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
