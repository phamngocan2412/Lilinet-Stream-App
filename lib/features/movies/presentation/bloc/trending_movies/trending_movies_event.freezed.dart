// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_movies_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrendingMoviesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingMoviesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TrendingMoviesEvent()';
}


}

/// @nodoc
class $TrendingMoviesEventCopyWith<$Res>  {
$TrendingMoviesEventCopyWith(TrendingMoviesEvent _, $Res Function(TrendingMoviesEvent) __);
}


/// Adds pattern-matching-related methods to [TrendingMoviesEvent].
extension TrendingMoviesEventPatterns on TrendingMoviesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadTrendingMovies value)?  load,TResult Function( RefreshTrendingMovies value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadTrendingMovies() when load != null:
return load(_that);case RefreshTrendingMovies() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadTrendingMovies value)  load,required TResult Function( RefreshTrendingMovies value)  refresh,}){
final _that = this;
switch (_that) {
case LoadTrendingMovies():
return load(_that);case RefreshTrendingMovies():
return refresh(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadTrendingMovies value)?  load,TResult? Function( RefreshTrendingMovies value)?  refresh,}){
final _that = this;
switch (_that) {
case LoadTrendingMovies() when load != null:
return load(_that);case RefreshTrendingMovies() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String type)?  load,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadTrendingMovies() when load != null:
return load(_that.type);case RefreshTrendingMovies() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String type)  load,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case LoadTrendingMovies():
return load(_that.type);case RefreshTrendingMovies():
return refresh();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String type)?  load,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case LoadTrendingMovies() when load != null:
return load(_that.type);case RefreshTrendingMovies() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class LoadTrendingMovies implements TrendingMoviesEvent {
  const LoadTrendingMovies({this.type = 'all'});
  

@JsonKey() final  String type;

/// Create a copy of TrendingMoviesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadTrendingMoviesCopyWith<LoadTrendingMovies> get copyWith => _$LoadTrendingMoviesCopyWithImpl<LoadTrendingMovies>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadTrendingMovies&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'TrendingMoviesEvent.load(type: $type)';
}


}

/// @nodoc
abstract mixin class $LoadTrendingMoviesCopyWith<$Res> implements $TrendingMoviesEventCopyWith<$Res> {
  factory $LoadTrendingMoviesCopyWith(LoadTrendingMovies value, $Res Function(LoadTrendingMovies) _then) = _$LoadTrendingMoviesCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$LoadTrendingMoviesCopyWithImpl<$Res>
    implements $LoadTrendingMoviesCopyWith<$Res> {
  _$LoadTrendingMoviesCopyWithImpl(this._self, this._then);

  final LoadTrendingMovies _self;
  final $Res Function(LoadTrendingMovies) _then;

/// Create a copy of TrendingMoviesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(LoadTrendingMovies(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RefreshTrendingMovies implements TrendingMoviesEvent {
  const RefreshTrendingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTrendingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TrendingMoviesEvent.refresh()';
}


}




// dart format on
