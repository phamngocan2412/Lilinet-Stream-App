// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoritesEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FavoritesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent()';
  }
}

/// @nodoc
class $FavoritesEventCopyWith<$Res> {
  $FavoritesEventCopyWith(FavoritesEvent _, $Res Function(FavoritesEvent) __);
}

/// Adds pattern-matching-related methods to [FavoritesEvent].
extension FavoritesEventPatterns on FavoritesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadFavorites value)?  loadFavorites,TResult Function( LoadMoreFavorites value)?  loadMoreFavorites,TResult Function( AddFavoriteEvent value)?  addFavorite,TResult Function( RemoveFavoriteEvent value)?  removeFavorite,TResult Function( ClearFavorites value)?  clearFavorites,TResult Function( CheckFavoriteStatus value)?  checkFavoriteStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadFavorites() when loadFavorites != null:
return loadFavorites(_that);case LoadMoreFavorites() when loadMoreFavorites != null:
return loadMoreFavorites(_that);case AddFavoriteEvent() when addFavorite != null:
return addFavorite(_that);case RemoveFavoriteEvent() when removeFavorite != null:
return removeFavorite(_that);case ClearFavorites() when clearFavorites != null:
return clearFavorites(_that);case CheckFavoriteStatus() when checkFavoriteStatus != null:
return checkFavoriteStatus(_that);case _:
  return orElse();

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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadFavorites value)  loadFavorites,required TResult Function( LoadMoreFavorites value)  loadMoreFavorites,required TResult Function( AddFavoriteEvent value)  addFavorite,required TResult Function( RemoveFavoriteEvent value)  removeFavorite,required TResult Function( ClearFavorites value)  clearFavorites,required TResult Function( CheckFavoriteStatus value)  checkFavoriteStatus,}){
final _that = this;
switch (_that) {
case LoadFavorites():
return loadFavorites(_that);case LoadMoreFavorites():
return loadMoreFavorites(_that);case AddFavoriteEvent():
return addFavorite(_that);case RemoveFavoriteEvent():
return removeFavorite(_that);case ClearFavorites():
return clearFavorites(_that);case CheckFavoriteStatus():
return checkFavoriteStatus(_that);case _:
  throw StateError('Unexpected subclass');

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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadFavorites value)?  loadFavorites,TResult? Function( LoadMoreFavorites value)?  loadMoreFavorites,TResult? Function( AddFavoriteEvent value)?  addFavorite,TResult? Function( RemoveFavoriteEvent value)?  removeFavorite,TResult? Function( ClearFavorites value)?  clearFavorites,TResult? Function( CheckFavoriteStatus value)?  checkFavoriteStatus,}){
final _that = this;
switch (_that) {
case LoadFavorites() when loadFavorites != null:
return loadFavorites(_that);case LoadMoreFavorites() when loadMoreFavorites != null:
return loadMoreFavorites(_that);case AddFavoriteEvent() when addFavorite != null:
return addFavorite(_that);case RemoveFavoriteEvent() when removeFavorite != null:
return removeFavorite(_that);case ClearFavorites() when clearFavorites != null:
return clearFavorites(_that);case CheckFavoriteStatus() when checkFavoriteStatus != null:
return checkFavoriteStatus(_that);case _:
  return null;

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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page)?  loadFavorites,TResult Function()?  loadMoreFavorites,TResult Function( String movieId,  String? movieTitle,  String? moviePoster,  String? movieType,  String folder)?  addFavorite,TResult Function( String movieId)?  removeFavorite,TResult Function()?  clearFavorites,TResult Function( String movieId)?  checkFavoriteStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadFavorites() when loadFavorites != null:
return loadFavorites(_that.page);case LoadMoreFavorites() when loadMoreFavorites != null:
return loadMoreFavorites();case AddFavoriteEvent() when addFavorite != null:
return addFavorite(_that.movieId,_that.movieTitle,_that.moviePoster,_that.movieType,_that.folder);case RemoveFavoriteEvent() when removeFavorite != null:
return removeFavorite(_that.movieId);case ClearFavorites() when clearFavorites != null:
return clearFavorites();case CheckFavoriteStatus() when checkFavoriteStatus != null:
return checkFavoriteStatus(_that.movieId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page)  loadFavorites,required TResult Function()  loadMoreFavorites,required TResult Function( String movieId,  String? movieTitle,  String? moviePoster,  String? movieType,  String folder)  addFavorite,required TResult Function( String movieId)  removeFavorite,required TResult Function()  clearFavorites,required TResult Function( String movieId)  checkFavoriteStatus,}) {final _that = this;
switch (_that) {
case LoadFavorites():
return loadFavorites(_that.page);case LoadMoreFavorites():
return loadMoreFavorites();case AddFavoriteEvent():
return addFavorite(_that.movieId,_that.movieTitle,_that.moviePoster,_that.movieType,_that.folder);case RemoveFavoriteEvent():
return removeFavorite(_that.movieId);case ClearFavorites():
return clearFavorites();case CheckFavoriteStatus():
return checkFavoriteStatus(_that.movieId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page)?  loadFavorites,TResult? Function()?  loadMoreFavorites,TResult? Function( String movieId,  String? movieTitle,  String? moviePoster,  String? movieType,  String folder)?  addFavorite,TResult? Function( String movieId)?  removeFavorite,TResult? Function()?  clearFavorites,TResult? Function( String movieId)?  checkFavoriteStatus,}) {final _that = this;
switch (_that) {
case LoadFavorites() when loadFavorites != null:
return loadFavorites(_that.page);case LoadMoreFavorites() when loadMoreFavorites != null:
return loadMoreFavorites();case AddFavoriteEvent() when addFavorite != null:
return addFavorite(_that.movieId,_that.movieTitle,_that.moviePoster,_that.movieType,_that.folder);case RemoveFavoriteEvent() when removeFavorite != null:
return removeFavorite(_that.movieId);case ClearFavorites() when clearFavorites != null:
return clearFavorites();case CheckFavoriteStatus() when checkFavoriteStatus != null:
return checkFavoriteStatus(_that.movieId);case _:
  return null;

}
}

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFavorites,
    TResult? Function(String movieId, String? movieTitle, String? moviePoster,
            String? movieType)?
        addFavorite,
    TResult? Function(String movieId)? removeFavorite,
    TResult? Function()? clearFavorites,
    TResult? Function(String movieId)? checkFavoriteStatus,
  }) {
    final _that = this;
    switch (_that) {
      case LoadFavorites() when loadFavorites != null:
        return loadFavorites();
      case AddFavoriteEvent() when addFavorite != null:
        return addFavorite(_that.movieId, _that.movieTitle, _that.moviePoster,
            _that.movieType);
      case RemoveFavoriteEvent() when removeFavorite != null:
        return removeFavorite(_that.movieId);
      case ClearFavorites() when clearFavorites != null:
        return clearFavorites();
      case CheckFavoriteStatus() when checkFavoriteStatus != null:
        return checkFavoriteStatus(_that.movieId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoadFavorites implements FavoritesEvent {
  const LoadFavorites({this.page = 1});
  

@JsonKey() final  int page;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadFavoritesCopyWith<LoadFavorites> get copyWith => _$LoadFavoritesCopyWithImpl<LoadFavorites>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFavorites&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'FavoritesEvent.loadFavorites(page: $page)';
}


}

/// @nodoc
abstract mixin class $LoadFavoritesCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory $LoadFavoritesCopyWith(LoadFavorites value, $Res Function(LoadFavorites) _then) = _$LoadFavoritesCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$LoadFavoritesCopyWithImpl<$Res>
    implements $LoadFavoritesCopyWith<$Res> {
  _$LoadFavoritesCopyWithImpl(this._self, this._then);

  final LoadFavorites _self;
  final $Res Function(LoadFavorites) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(LoadFavorites(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LoadMoreFavorites implements FavoritesEvent {
  const LoadMoreFavorites();
  

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadFavorites);
  }

  @override
  int get hashCode => runtimeType.hashCode;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreFavorites);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent.loadMoreFavorites()';
}


}




/// @nodoc

class AddFavoriteEvent implements FavoritesEvent {
  const AddFavoriteEvent({required this.movieId, this.movieTitle, this.moviePoster, this.movieType, this.folder = 'Default'});
  

 final  String movieId;
 final  String? movieTitle;
 final  String? moviePoster;
 final  String? movieType;
@JsonKey() final  String folder;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddFavoriteEventCopyWith<AddFavoriteEvent> get copyWith =>
      _$AddFavoriteEventCopyWithImpl<AddFavoriteEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddFavoriteEvent &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.movieTitle, movieTitle) ||
                other.movieTitle == movieTitle) &&
            (identical(other.moviePoster, moviePoster) ||
                other.moviePoster == moviePoster) &&
            (identical(other.movieType, movieType) ||
                other.movieType == movieType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, movieId, movieTitle, moviePoster, movieType);

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddFavoriteEvent&&(identical(other.movieId, movieId) || other.movieId == movieId)&&(identical(other.movieTitle, movieTitle) || other.movieTitle == movieTitle)&&(identical(other.moviePoster, moviePoster) || other.moviePoster == moviePoster)&&(identical(other.movieType, movieType) || other.movieType == movieType)&&(identical(other.folder, folder) || other.folder == folder));
}


@override
int get hashCode => Object.hash(runtimeType,movieId,movieTitle,moviePoster,movieType,folder);

@override
String toString() {
  return 'FavoritesEvent.addFavorite(movieId: $movieId, movieTitle: $movieTitle, moviePoster: $moviePoster, movieType: $movieType, folder: $folder)';
}


}

/// @nodoc
abstract mixin class $AddFavoriteEventCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory $AddFavoriteEventCopyWith(AddFavoriteEvent value, $Res Function(AddFavoriteEvent) _then) = _$AddFavoriteEventCopyWithImpl;
@useResult
$Res call({
 String movieId, String? movieTitle, String? moviePoster, String? movieType, String folder
});




}

/// @nodoc
class _$AddFavoriteEventCopyWithImpl<$Res>
    implements $AddFavoriteEventCopyWith<$Res> {
  _$AddFavoriteEventCopyWithImpl(this._self, this._then);

  final AddFavoriteEvent _self;
  final $Res Function(AddFavoriteEvent) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movieId = null,Object? movieTitle = freezed,Object? moviePoster = freezed,Object? movieType = freezed,Object? folder = null,}) {
  return _then(AddFavoriteEvent(
movieId: null == movieId ? _self.movieId : movieId // ignore: cast_nullable_to_non_nullable
as String,movieTitle: freezed == movieTitle ? _self.movieTitle : movieTitle // ignore: cast_nullable_to_non_nullable
as String?,moviePoster: freezed == moviePoster ? _self.moviePoster : moviePoster // ignore: cast_nullable_to_non_nullable
as String?,movieType: freezed == movieType ? _self.movieType : movieType // ignore: cast_nullable_to_non_nullable
as String?,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

class RemoveFavoriteEvent implements FavoritesEvent {
  const RemoveFavoriteEvent({required this.movieId});

  final String movieId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoveFavoriteEventCopyWith<RemoveFavoriteEvent> get copyWith =>
      _$RemoveFavoriteEventCopyWithImpl<RemoveFavoriteEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoveFavoriteEvent &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  @override
  String toString() {
    return 'FavoritesEvent.removeFavorite(movieId: $movieId)';
  }
}

/// @nodoc
abstract mixin class $RemoveFavoriteEventCopyWith<$Res>
    implements $FavoritesEventCopyWith<$Res> {
  factory $RemoveFavoriteEventCopyWith(
          RemoveFavoriteEvent value, $Res Function(RemoveFavoriteEvent) _then) =
      _$RemoveFavoriteEventCopyWithImpl;
  @useResult
  $Res call({String movieId});
}

/// @nodoc
class _$RemoveFavoriteEventCopyWithImpl<$Res>
    implements $RemoveFavoriteEventCopyWith<$Res> {
  _$RemoveFavoriteEventCopyWithImpl(this._self, this._then);

  final RemoveFavoriteEvent _self;
  final $Res Function(RemoveFavoriteEvent) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? movieId = null,
  }) {
    return _then(RemoveFavoriteEvent(
      movieId: null == movieId
          ? _self.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ClearFavorites implements FavoritesEvent {
  const ClearFavorites();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ClearFavorites);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent.clearFavorites()';
  }
}

/// @nodoc

class CheckFavoriteStatus implements FavoritesEvent {
  const CheckFavoriteStatus({required this.movieId});

  final String movieId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckFavoriteStatusCopyWith<CheckFavoriteStatus> get copyWith =>
      _$CheckFavoriteStatusCopyWithImpl<CheckFavoriteStatus>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckFavoriteStatus &&
            (identical(other.movieId, movieId) || other.movieId == movieId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movieId);

  @override
  String toString() {
    return 'FavoritesEvent.checkFavoriteStatus(movieId: $movieId)';
  }
}

/// @nodoc
abstract mixin class $CheckFavoriteStatusCopyWith<$Res>
    implements $FavoritesEventCopyWith<$Res> {
  factory $CheckFavoriteStatusCopyWith(
          CheckFavoriteStatus value, $Res Function(CheckFavoriteStatus) _then) =
      _$CheckFavoriteStatusCopyWithImpl;
  @useResult
  $Res call({String movieId});
}

/// @nodoc
class _$CheckFavoriteStatusCopyWithImpl<$Res>
    implements $CheckFavoriteStatusCopyWith<$Res> {
  _$CheckFavoriteStatusCopyWithImpl(this._self, this._then);

  final CheckFavoriteStatus _self;
  final $Res Function(CheckFavoriteStatus) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? movieId = null,
  }) {
    return _then(CheckFavoriteStatus(
      movieId: null == movieId
          ? _self.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
