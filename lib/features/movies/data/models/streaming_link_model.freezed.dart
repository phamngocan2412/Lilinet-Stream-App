// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamingLinkModel {

@HiveField(0)@AnyToStringConverter() String get url;@HiveField(1)@AnyToStringConverter() String get quality;@HiveField(2) bool get isM3U8;@HiveField(3) Map<String, String>? get headers;
/// Create a copy of StreamingLinkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreamingLinkModelCopyWith<StreamingLinkModel> get copyWith => _$StreamingLinkModelCopyWithImpl<StreamingLinkModel>(this as StreamingLinkModel, _$identity);

  /// Serializes this StreamingLinkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreamingLinkModel&&(identical(other.url, url) || other.url == url)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8)&&const DeepCollectionEquality().equals(other.headers, headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,quality,isM3U8,const DeepCollectionEquality().hash(headers));

@override
String toString() {
  return 'StreamingLinkModel(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $StreamingLinkModelCopyWith<$Res>  {
  factory $StreamingLinkModelCopyWith(StreamingLinkModel value, $Res Function(StreamingLinkModel) _then) = _$StreamingLinkModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String url,@HiveField(1)@AnyToStringConverter() String quality,@HiveField(2) bool isM3U8,@HiveField(3) Map<String, String>? headers
});




}
/// @nodoc
class _$StreamingLinkModelCopyWithImpl<$Res>
    implements $StreamingLinkModelCopyWith<$Res> {
  _$StreamingLinkModelCopyWithImpl(this._self, this._then);

  final StreamingLinkModel _self;
  final $Res Function(StreamingLinkModel) _then;

/// Create a copy of StreamingLinkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? quality = null,Object? isM3U8 = null,Object? headers = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,isM3U8: null == isM3U8 ? _self.isM3U8 : isM3U8 // ignore: cast_nullable_to_non_nullable
as bool,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreamingLinkModel].
extension StreamingLinkModelPatterns on StreamingLinkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreamingLinkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreamingLinkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreamingLinkModel value)  $default,){
final _that = this;
switch (_that) {
case _StreamingLinkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreamingLinkModel value)?  $default,){
final _that = this;
switch (_that) {
case _StreamingLinkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String quality, @HiveField(2)  bool isM3U8, @HiveField(3)  Map<String, String>? headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreamingLinkModel() when $default != null:
return $default(_that.url,_that.quality,_that.isM3U8,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String quality, @HiveField(2)  bool isM3U8, @HiveField(3)  Map<String, String>? headers)  $default,) {final _that = this;
switch (_that) {
case _StreamingLinkModel():
return $default(_that.url,_that.quality,_that.isM3U8,_that.headers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String quality, @HiveField(2)  bool isM3U8, @HiveField(3)  Map<String, String>? headers)?  $default,) {final _that = this;
switch (_that) {
case _StreamingLinkModel() when $default != null:
return $default(_that.url,_that.quality,_that.isM3U8,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreamingLinkModel extends StreamingLinkModel {
  const _StreamingLinkModel({@HiveField(0)@AnyToStringConverter() required this.url, @HiveField(1)@AnyToStringConverter() required this.quality, @HiveField(2) required this.isM3U8, @HiveField(3) final  Map<String, String>? headers}): _headers = headers,super._();
  factory _StreamingLinkModel.fromJson(Map<String, dynamic> json) => _$StreamingLinkModelFromJson(json);

@override@HiveField(0)@AnyToStringConverter() final  String url;
@override@HiveField(1)@AnyToStringConverter() final  String quality;
@override@HiveField(2) final  bool isM3U8;
 final  Map<String, String>? _headers;
@override@HiveField(3) Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of StreamingLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreamingLinkModelCopyWith<_StreamingLinkModel> get copyWith => __$StreamingLinkModelCopyWithImpl<_StreamingLinkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreamingLinkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreamingLinkModel&&(identical(other.url, url) || other.url == url)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8)&&const DeepCollectionEquality().equals(other._headers, _headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,quality,isM3U8,const DeepCollectionEquality().hash(_headers));

@override
String toString() {
  return 'StreamingLinkModel(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$StreamingLinkModelCopyWith<$Res> implements $StreamingLinkModelCopyWith<$Res> {
  factory _$StreamingLinkModelCopyWith(_StreamingLinkModel value, $Res Function(_StreamingLinkModel) _then) = __$StreamingLinkModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String url,@HiveField(1)@AnyToStringConverter() String quality,@HiveField(2) bool isM3U8,@HiveField(3) Map<String, String>? headers
});




}
/// @nodoc
class __$StreamingLinkModelCopyWithImpl<$Res>
    implements _$StreamingLinkModelCopyWith<$Res> {
  __$StreamingLinkModelCopyWithImpl(this._self, this._then);

  final _StreamingLinkModel _self;
  final $Res Function(_StreamingLinkModel) _then;

/// Create a copy of StreamingLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? quality = null,Object? isM3U8 = null,Object? headers = freezed,}) {
  return _then(_StreamingLinkModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,isM3U8: null == isM3U8 ? _self.isM3U8 : isM3U8 // ignore: cast_nullable_to_non_nullable
as bool,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}


/// @nodoc
mixin _$SubtitleModel {

@HiveField(0)@AnyToStringConverter() String get url;@HiveField(1)@AnyToStringConverter() String get lang;
/// Create a copy of SubtitleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleModelCopyWith<SubtitleModel> get copyWith => _$SubtitleModelCopyWithImpl<SubtitleModel>(this as SubtitleModel, _$identity);

  /// Serializes this SubtitleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtitleModel&&(identical(other.url, url) || other.url == url)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,lang);

@override
String toString() {
  return 'SubtitleModel(url: $url, lang: $lang)';
}


}

/// @nodoc
abstract mixin class $SubtitleModelCopyWith<$Res>  {
  factory $SubtitleModelCopyWith(SubtitleModel value, $Res Function(SubtitleModel) _then) = _$SubtitleModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String url,@HiveField(1)@AnyToStringConverter() String lang
});




}
/// @nodoc
class _$SubtitleModelCopyWithImpl<$Res>
    implements $SubtitleModelCopyWith<$Res> {
  _$SubtitleModelCopyWithImpl(this._self, this._then);

  final SubtitleModel _self;
  final $Res Function(SubtitleModel) _then;

/// Create a copy of SubtitleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? lang = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtitleModel].
extension SubtitleModelPatterns on SubtitleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtitleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtitleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtitleModel value)  $default,){
final _that = this;
switch (_that) {
case _SubtitleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtitleModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubtitleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String lang)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtitleModel() when $default != null:
return $default(_that.url,_that.lang);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String lang)  $default,) {final _that = this;
switch (_that) {
case _SubtitleModel():
return $default(_that.url,_that.lang);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@AnyToStringConverter()  String url, @HiveField(1)@AnyToStringConverter()  String lang)?  $default,) {final _that = this;
switch (_that) {
case _SubtitleModel() when $default != null:
return $default(_that.url,_that.lang);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtitleModel extends SubtitleModel {
  const _SubtitleModel({@HiveField(0)@AnyToStringConverter() required this.url, @HiveField(1)@AnyToStringConverter() required this.lang}): super._();
  factory _SubtitleModel.fromJson(Map<String, dynamic> json) => _$SubtitleModelFromJson(json);

@override@HiveField(0)@AnyToStringConverter() final  String url;
@override@HiveField(1)@AnyToStringConverter() final  String lang;

/// Create a copy of SubtitleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleModelCopyWith<_SubtitleModel> get copyWith => __$SubtitleModelCopyWithImpl<_SubtitleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtitleModel&&(identical(other.url, url) || other.url == url)&&(identical(other.lang, lang) || other.lang == lang));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,lang);

@override
String toString() {
  return 'SubtitleModel(url: $url, lang: $lang)';
}


}

/// @nodoc
abstract mixin class _$SubtitleModelCopyWith<$Res> implements $SubtitleModelCopyWith<$Res> {
  factory _$SubtitleModelCopyWith(_SubtitleModel value, $Res Function(_SubtitleModel) _then) = __$SubtitleModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String url,@HiveField(1)@AnyToStringConverter() String lang
});




}
/// @nodoc
class __$SubtitleModelCopyWithImpl<$Res>
    implements _$SubtitleModelCopyWith<$Res> {
  __$SubtitleModelCopyWithImpl(this._self, this._then);

  final _SubtitleModel _self;
  final $Res Function(_SubtitleModel) _then;

/// Create a copy of SubtitleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? lang = null,}) {
  return _then(_SubtitleModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StreamingResponseModel {

@HiveField(0) List<StreamingLinkModel> get sources;@HiveField(1) Map<String, String>? get headers;@HiveField(2) List<SubtitleModel>? get subtitles;
/// Create a copy of StreamingResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreamingResponseModelCopyWith<StreamingResponseModel> get copyWith => _$StreamingResponseModelCopyWithImpl<StreamingResponseModel>(this as StreamingResponseModel, _$identity);

  /// Serializes this StreamingResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreamingResponseModel&&const DeepCollectionEquality().equals(other.sources, sources)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.subtitles, subtitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sources),const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(subtitles));

@override
String toString() {
  return 'StreamingResponseModel(sources: $sources, headers: $headers, subtitles: $subtitles)';
}


}

/// @nodoc
abstract mixin class $StreamingResponseModelCopyWith<$Res>  {
  factory $StreamingResponseModelCopyWith(StreamingResponseModel value, $Res Function(StreamingResponseModel) _then) = _$StreamingResponseModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) List<StreamingLinkModel> sources,@HiveField(1) Map<String, String>? headers,@HiveField(2) List<SubtitleModel>? subtitles
});




}
/// @nodoc
class _$StreamingResponseModelCopyWithImpl<$Res>
    implements $StreamingResponseModelCopyWith<$Res> {
  _$StreamingResponseModelCopyWithImpl(this._self, this._then);

  final StreamingResponseModel _self;
  final $Res Function(StreamingResponseModel) _then;

/// Create a copy of StreamingResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sources = null,Object? headers = freezed,Object? subtitles = freezed,}) {
  return _then(_self.copyWith(
sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<StreamingLinkModel>,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,subtitles: freezed == subtitles ? _self.subtitles : subtitles // ignore: cast_nullable_to_non_nullable
as List<SubtitleModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreamingResponseModel].
extension StreamingResponseModelPatterns on StreamingResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreamingResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreamingResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreamingResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _StreamingResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreamingResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _StreamingResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  List<StreamingLinkModel> sources, @HiveField(1)  Map<String, String>? headers, @HiveField(2)  List<SubtitleModel>? subtitles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreamingResponseModel() when $default != null:
return $default(_that.sources,_that.headers,_that.subtitles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  List<StreamingLinkModel> sources, @HiveField(1)  Map<String, String>? headers, @HiveField(2)  List<SubtitleModel>? subtitles)  $default,) {final _that = this;
switch (_that) {
case _StreamingResponseModel():
return $default(_that.sources,_that.headers,_that.subtitles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  List<StreamingLinkModel> sources, @HiveField(1)  Map<String, String>? headers, @HiveField(2)  List<SubtitleModel>? subtitles)?  $default,) {final _that = this;
switch (_that) {
case _StreamingResponseModel() when $default != null:
return $default(_that.sources,_that.headers,_that.subtitles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreamingResponseModel implements StreamingResponseModel {
  const _StreamingResponseModel({@HiveField(0) required final  List<StreamingLinkModel> sources, @HiveField(1) final  Map<String, String>? headers, @HiveField(2) final  List<SubtitleModel>? subtitles}): _sources = sources,_headers = headers,_subtitles = subtitles;
  factory _StreamingResponseModel.fromJson(Map<String, dynamic> json) => _$StreamingResponseModelFromJson(json);

 final  List<StreamingLinkModel> _sources;
@override@HiveField(0) List<StreamingLinkModel> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

 final  Map<String, String>? _headers;
@override@HiveField(1) Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<SubtitleModel>? _subtitles;
@override@HiveField(2) List<SubtitleModel>? get subtitles {
  final value = _subtitles;
  if (value == null) return null;
  if (_subtitles is EqualUnmodifiableListView) return _subtitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StreamingResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreamingResponseModelCopyWith<_StreamingResponseModel> get copyWith => __$StreamingResponseModelCopyWithImpl<_StreamingResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreamingResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreamingResponseModel&&const DeepCollectionEquality().equals(other._sources, _sources)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._subtitles, _subtitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sources),const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_subtitles));

@override
String toString() {
  return 'StreamingResponseModel(sources: $sources, headers: $headers, subtitles: $subtitles)';
}


}

/// @nodoc
abstract mixin class _$StreamingResponseModelCopyWith<$Res> implements $StreamingResponseModelCopyWith<$Res> {
  factory _$StreamingResponseModelCopyWith(_StreamingResponseModel value, $Res Function(_StreamingResponseModel) _then) = __$StreamingResponseModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) List<StreamingLinkModel> sources,@HiveField(1) Map<String, String>? headers,@HiveField(2) List<SubtitleModel>? subtitles
});




}
/// @nodoc
class __$StreamingResponseModelCopyWithImpl<$Res>
    implements _$StreamingResponseModelCopyWith<$Res> {
  __$StreamingResponseModelCopyWithImpl(this._self, this._then);

  final _StreamingResponseModel _self;
  final $Res Function(_StreamingResponseModel) _then;

/// Create a copy of StreamingResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sources = null,Object? headers = freezed,Object? subtitles = freezed,}) {
  return _then(_StreamingResponseModel(
sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<StreamingLinkModel>,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,subtitles: freezed == subtitles ? _self._subtitles : subtitles // ignore: cast_nullable_to_non_nullable
as List<SubtitleModel>?,
  ));
}


}


/// @nodoc
mixin _$ServerInfoModel {

 String get name; String get url;
/// Create a copy of ServerInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerInfoModelCopyWith<ServerInfoModel> get copyWith => _$ServerInfoModelCopyWithImpl<ServerInfoModel>(this as ServerInfoModel, _$identity);

  /// Serializes this ServerInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerInfoModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'ServerInfoModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $ServerInfoModelCopyWith<$Res>  {
  factory $ServerInfoModelCopyWith(ServerInfoModel value, $Res Function(ServerInfoModel) _then) = _$ServerInfoModelCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$ServerInfoModelCopyWithImpl<$Res>
    implements $ServerInfoModelCopyWith<$Res> {
  _$ServerInfoModelCopyWithImpl(this._self, this._then);

  final ServerInfoModel _self;
  final $Res Function(ServerInfoModel) _then;

/// Create a copy of ServerInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerInfoModel].
extension ServerInfoModelPatterns on ServerInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _ServerInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServerInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerInfoModel() when $default != null:
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url)  $default,) {final _that = this;
switch (_that) {
case _ServerInfoModel():
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url)?  $default,) {final _that = this;
switch (_that) {
case _ServerInfoModel() when $default != null:
return $default(_that.name,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerInfoModel implements ServerInfoModel {
  const _ServerInfoModel({required this.name, required this.url});
  factory _ServerInfoModel.fromJson(Map<String, dynamic> json) => _$ServerInfoModelFromJson(json);

@override final  String name;
@override final  String url;

/// Create a copy of ServerInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerInfoModelCopyWith<_ServerInfoModel> get copyWith => __$ServerInfoModelCopyWithImpl<_ServerInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerInfoModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'ServerInfoModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ServerInfoModelCopyWith<$Res> implements $ServerInfoModelCopyWith<$Res> {
  factory _$ServerInfoModelCopyWith(_ServerInfoModel value, $Res Function(_ServerInfoModel) _then) = __$ServerInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$ServerInfoModelCopyWithImpl<$Res>
    implements _$ServerInfoModelCopyWith<$Res> {
  __$ServerInfoModelCopyWithImpl(this._self, this._then);

  final _ServerInfoModel _self;
  final $Res Function(_ServerInfoModel) _then;

/// Create a copy of ServerInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_ServerInfoModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
