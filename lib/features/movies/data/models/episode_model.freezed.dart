// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpisodeModel {

@HiveField(0)@AnyToStringConverter() String get id;@HiveField(1) String get title;@HiveField(2)@AnyToStringNullableConverter() String? get description;@HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired() int get number;@HiveField(4)@StringToIntConverter() int? get season;@HiveField(5)@EpisodeImageConverter() String? get image;@HiveField(6)@AnyToStringNullableConverter() String? get url;@HiveField(7) DateTime? get releaseDate;
/// Create a copy of EpisodeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeModelCopyWith<EpisodeModel> get copyWith => _$EpisodeModelCopyWithImpl<EpisodeModel>(this as EpisodeModel, _$identity);

  /// Serializes this EpisodeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpisodeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.number, number) || other.number == number)&&(identical(other.season, season) || other.season == season)&&(identical(other.image, image) || other.image == image)&&(identical(other.url, url) || other.url == url)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,number,season,image,url,releaseDate);

@override
String toString() {
  return 'EpisodeModel(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
}


}

/// @nodoc
abstract mixin class $EpisodeModelCopyWith<$Res>  {
  factory $EpisodeModelCopyWith(EpisodeModel value, $Res Function(EpisodeModel) _then) = _$EpisodeModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String id,@HiveField(1) String title,@HiveField(2)@AnyToStringNullableConverter() String? description,@HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired() int number,@HiveField(4)@StringToIntConverter() int? season,@HiveField(5)@EpisodeImageConverter() String? image,@HiveField(6)@AnyToStringNullableConverter() String? url,@HiveField(7) DateTime? releaseDate
});




}
/// @nodoc
class _$EpisodeModelCopyWithImpl<$Res>
    implements $EpisodeModelCopyWith<$Res> {
  _$EpisodeModelCopyWithImpl(this._self, this._then);

  final EpisodeModel _self;
  final $Res Function(EpisodeModel) _then;

/// Create a copy of EpisodeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? number = null,Object? season = freezed,Object? image = freezed,Object? url = freezed,Object? releaseDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EpisodeModel].
extension EpisodeModelPatterns on EpisodeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpisodeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpisodeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpisodeModel value)  $default,){
final _that = this;
switch (_that) {
case _EpisodeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpisodeModel value)?  $default,){
final _that = this;
switch (_that) {
case _EpisodeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? description, @HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired()  int number, @HiveField(4)@StringToIntConverter()  int? season, @HiveField(5)@EpisodeImageConverter()  String? image, @HiveField(6)@AnyToStringNullableConverter()  String? url, @HiveField(7)  DateTime? releaseDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpisodeModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.number,_that.season,_that.image,_that.url,_that.releaseDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? description, @HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired()  int number, @HiveField(4)@StringToIntConverter()  int? season, @HiveField(5)@EpisodeImageConverter()  String? image, @HiveField(6)@AnyToStringNullableConverter()  String? url, @HiveField(7)  DateTime? releaseDate)  $default,) {final _that = this;
switch (_that) {
case _EpisodeModel():
return $default(_that.id,_that.title,_that.description,_that.number,_that.season,_that.image,_that.url,_that.releaseDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? description, @HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired()  int number, @HiveField(4)@StringToIntConverter()  int? season, @HiveField(5)@EpisodeImageConverter()  String? image, @HiveField(6)@AnyToStringNullableConverter()  String? url, @HiveField(7)  DateTime? releaseDate)?  $default,) {final _that = this;
switch (_that) {
case _EpisodeModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.number,_that.season,_that.image,_that.url,_that.releaseDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpisodeModel extends EpisodeModel {
  const _EpisodeModel({@HiveField(0)@AnyToStringConverter() required this.id, @HiveField(1) required this.title, @HiveField(2)@AnyToStringNullableConverter() this.description, @HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired() required this.number, @HiveField(4)@StringToIntConverter() this.season, @HiveField(5)@EpisodeImageConverter() this.image, @HiveField(6)@AnyToStringNullableConverter() this.url, @HiveField(7) this.releaseDate}): super._();
  factory _EpisodeModel.fromJson(Map<String, dynamic> json) => _$EpisodeModelFromJson(json);

@override@HiveField(0)@AnyToStringConverter() final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2)@AnyToStringNullableConverter() final  String? description;
@override@HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired() final  int number;
@override@HiveField(4)@StringToIntConverter() final  int? season;
@override@HiveField(5)@EpisodeImageConverter() final  String? image;
@override@HiveField(6)@AnyToStringNullableConverter() final  String? url;
@override@HiveField(7) final  DateTime? releaseDate;

/// Create a copy of EpisodeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodeModelCopyWith<_EpisodeModel> get copyWith => __$EpisodeModelCopyWithImpl<_EpisodeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpisodeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpisodeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.number, number) || other.number == number)&&(identical(other.season, season) || other.season == season)&&(identical(other.image, image) || other.image == image)&&(identical(other.url, url) || other.url == url)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,number,season,image,url,releaseDate);

@override
String toString() {
  return 'EpisodeModel(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
}


}

/// @nodoc
abstract mixin class _$EpisodeModelCopyWith<$Res> implements $EpisodeModelCopyWith<$Res> {
  factory _$EpisodeModelCopyWith(_EpisodeModel value, $Res Function(_EpisodeModel) _then) = __$EpisodeModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String id,@HiveField(1) String title,@HiveField(2)@AnyToStringNullableConverter() String? description,@HiveField(3)@JsonKey(name: 'episode')@StringToIntConverterRequired() int number,@HiveField(4)@StringToIntConverter() int? season,@HiveField(5)@EpisodeImageConverter() String? image,@HiveField(6)@AnyToStringNullableConverter() String? url,@HiveField(7) DateTime? releaseDate
});




}
/// @nodoc
class __$EpisodeModelCopyWithImpl<$Res>
    implements _$EpisodeModelCopyWith<$Res> {
  __$EpisodeModelCopyWithImpl(this._self, this._then);

  final _EpisodeModel _self;
  final $Res Function(_EpisodeModel) _then;

/// Create a copy of EpisodeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? number = null,Object? season = freezed,Object? image = freezed,Object? url = freezed,Object? releaseDate = freezed,}) {
  return _then(_EpisodeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as int?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
