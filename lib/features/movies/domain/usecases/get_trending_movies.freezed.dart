// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_trending_movies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrendingParams {

 String get type; int get page;
/// Create a copy of TrendingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingParamsCopyWith<TrendingParams> get copyWith => _$TrendingParamsCopyWithImpl<TrendingParams>(this as TrendingParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingParams&&(identical(other.type, type) || other.type == type)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,type,page);

@override
String toString() {
  return 'TrendingParams(type: $type, page: $page)';
}


}

/// @nodoc
abstract mixin class $TrendingParamsCopyWith<$Res>  {
  factory $TrendingParamsCopyWith(TrendingParams value, $Res Function(TrendingParams) _then) = _$TrendingParamsCopyWithImpl;
@useResult
$Res call({
 String type, int page
});




}
/// @nodoc
class _$TrendingParamsCopyWithImpl<$Res>
    implements $TrendingParamsCopyWith<$Res> {
  _$TrendingParamsCopyWithImpl(this._self, this._then);

  final TrendingParams _self;
  final $Res Function(TrendingParams) _then;

/// Create a copy of TrendingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? page = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingParams].
extension TrendingParamsPatterns on TrendingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingParams value)  $default,){
final _that = this;
switch (_that) {
case _TrendingParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingParams value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingParams() when $default != null:
return $default(_that.type,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int page)  $default,) {final _that = this;
switch (_that) {
case _TrendingParams():
return $default(_that.type,_that.page);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int page)?  $default,) {final _that = this;
switch (_that) {
case _TrendingParams() when $default != null:
return $default(_that.type,_that.page);case _:
  return null;

}
}

}

/// @nodoc


class _TrendingParams implements TrendingParams {
  const _TrendingParams({this.type = 'all', this.page = 1});
  

@override@JsonKey() final  String type;
@override@JsonKey() final  int page;

/// Create a copy of TrendingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingParamsCopyWith<_TrendingParams> get copyWith => __$TrendingParamsCopyWithImpl<_TrendingParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingParams&&(identical(other.type, type) || other.type == type)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,type,page);

@override
String toString() {
  return 'TrendingParams(type: $type, page: $page)';
}


}

/// @nodoc
abstract mixin class _$TrendingParamsCopyWith<$Res> implements $TrendingParamsCopyWith<$Res> {
  factory _$TrendingParamsCopyWith(_TrendingParams value, $Res Function(_TrendingParams) _then) = __$TrendingParamsCopyWithImpl;
@override @useResult
$Res call({
 String type, int page
});




}
/// @nodoc
class __$TrendingParamsCopyWithImpl<$Res>
    implements _$TrendingParamsCopyWith<$Res> {
  __$TrendingParamsCopyWithImpl(this._self, this._then);

  final _TrendingParams _self;
  final $Res Function(_TrendingParams) _then;

/// Create a copy of TrendingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? page = null,}) {
  return _then(_TrendingParams(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
