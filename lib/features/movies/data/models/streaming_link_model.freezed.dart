// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StreamingLinkModel _$StreamingLinkModelFromJson(Map<String, dynamic> json) {
  return _StreamingLinkModel.fromJson(json);
}

/// @nodoc
mixin _$StreamingLinkModel {
  @HiveField(0)
  @AnyToStringConverter()
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  @AnyToStringConverter()
  String get quality => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get isM3U8 => throw _privateConstructorUsedError;
  @HiveField(3)
  Map<String, String>? get headers => throw _privateConstructorUsedError;

  /// Serializes this StreamingLinkModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamingLinkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamingLinkModelCopyWith<StreamingLinkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingLinkModelCopyWith<$Res> {
  factory $StreamingLinkModelCopyWith(
          StreamingLinkModel value, $Res Function(StreamingLinkModel) then) =
      _$StreamingLinkModelCopyWithImpl<$Res, StreamingLinkModel>;
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String url,
      @HiveField(1) @AnyToStringConverter() String quality,
      @HiveField(2) bool isM3U8,
      @HiveField(3) Map<String, String>? headers});
}

/// @nodoc
class _$StreamingLinkModelCopyWithImpl<$Res, $Val extends StreamingLinkModel>
    implements $StreamingLinkModelCopyWith<$Res> {
  _$StreamingLinkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingLinkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? quality = null,
    Object? isM3U8 = null,
    Object? headers = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      isM3U8: null == isM3U8
          ? _value.isM3U8
          : isM3U8 // ignore: cast_nullable_to_non_nullable
              as bool,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamingLinkModelImplCopyWith<$Res>
    implements $StreamingLinkModelCopyWith<$Res> {
  factory _$$StreamingLinkModelImplCopyWith(_$StreamingLinkModelImpl value,
          $Res Function(_$StreamingLinkModelImpl) then) =
      __$$StreamingLinkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String url,
      @HiveField(1) @AnyToStringConverter() String quality,
      @HiveField(2) bool isM3U8,
      @HiveField(3) Map<String, String>? headers});
}

/// @nodoc
class __$$StreamingLinkModelImplCopyWithImpl<$Res>
    extends _$StreamingLinkModelCopyWithImpl<$Res, _$StreamingLinkModelImpl>
    implements _$$StreamingLinkModelImplCopyWith<$Res> {
  __$$StreamingLinkModelImplCopyWithImpl(_$StreamingLinkModelImpl _value,
      $Res Function(_$StreamingLinkModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamingLinkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? quality = null,
    Object? isM3U8 = null,
    Object? headers = freezed,
  }) {
    return _then(_$StreamingLinkModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      isM3U8: null == isM3U8
          ? _value.isM3U8
          : isM3U8 // ignore: cast_nullable_to_non_nullable
              as bool,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamingLinkModelImpl extends _StreamingLinkModel {
  const _$StreamingLinkModelImpl(
      {@HiveField(0) @AnyToStringConverter() required this.url,
      @HiveField(1) @AnyToStringConverter() required this.quality,
      @HiveField(2) required this.isM3U8,
      @HiveField(3) final Map<String, String>? headers})
      : _headers = headers,
        super._();

  factory _$StreamingLinkModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamingLinkModelImplFromJson(json);

  @override
  @HiveField(0)
  @AnyToStringConverter()
  final String url;
  @override
  @HiveField(1)
  @AnyToStringConverter()
  final String quality;
  @override
  @HiveField(2)
  final bool isM3U8;
  final Map<String, String>? _headers;
  @override
  @HiveField(3)
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StreamingLinkModel(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingLinkModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, quality, isM3U8,
      const DeepCollectionEquality().hash(_headers));

  /// Create a copy of StreamingLinkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingLinkModelImplCopyWith<_$StreamingLinkModelImpl> get copyWith =>
      __$$StreamingLinkModelImplCopyWithImpl<_$StreamingLinkModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamingLinkModelImplToJson(
      this,
    );
  }
}

abstract class _StreamingLinkModel extends StreamingLinkModel {
  const factory _StreamingLinkModel(
          {@HiveField(0) @AnyToStringConverter() required final String url,
          @HiveField(1) @AnyToStringConverter() required final String quality,
          @HiveField(2) required final bool isM3U8,
          @HiveField(3) final Map<String, String>? headers}) =
      _$StreamingLinkModelImpl;
  const _StreamingLinkModel._() : super._();

  factory _StreamingLinkModel.fromJson(Map<String, dynamic> json) =
      _$StreamingLinkModelImpl.fromJson;

  @override
  @HiveField(0)
  @AnyToStringConverter()
  String get url;
  @override
  @HiveField(1)
  @AnyToStringConverter()
  String get quality;
  @override
  @HiveField(2)
  bool get isM3U8;
  @override
  @HiveField(3)
  Map<String, String>? get headers;

  /// Create a copy of StreamingLinkModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingLinkModelImplCopyWith<_$StreamingLinkModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubtitleModel _$SubtitleModelFromJson(Map<String, dynamic> json) {
  return _SubtitleModel.fromJson(json);
}

/// @nodoc
mixin _$SubtitleModel {
  @HiveField(0)
  @AnyToStringConverter()
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  @AnyToStringConverter()
  String get lang => throw _privateConstructorUsedError;

  /// Serializes this SubtitleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubtitleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtitleModelCopyWith<SubtitleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitleModelCopyWith<$Res> {
  factory $SubtitleModelCopyWith(
          SubtitleModel value, $Res Function(SubtitleModel) then) =
      _$SubtitleModelCopyWithImpl<$Res, SubtitleModel>;
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String url,
      @HiveField(1) @AnyToStringConverter() String lang});
}

/// @nodoc
class _$SubtitleModelCopyWithImpl<$Res, $Val extends SubtitleModel>
    implements $SubtitleModelCopyWith<$Res> {
  _$SubtitleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtitleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? lang = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubtitleModelImplCopyWith<$Res>
    implements $SubtitleModelCopyWith<$Res> {
  factory _$$SubtitleModelImplCopyWith(
          _$SubtitleModelImpl value, $Res Function(_$SubtitleModelImpl) then) =
      __$$SubtitleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String url,
      @HiveField(1) @AnyToStringConverter() String lang});
}

/// @nodoc
class __$$SubtitleModelImplCopyWithImpl<$Res>
    extends _$SubtitleModelCopyWithImpl<$Res, _$SubtitleModelImpl>
    implements _$$SubtitleModelImplCopyWith<$Res> {
  __$$SubtitleModelImplCopyWithImpl(
      _$SubtitleModelImpl _value, $Res Function(_$SubtitleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? lang = null,
  }) {
    return _then(_$SubtitleModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtitleModelImpl extends _SubtitleModel {
  const _$SubtitleModelImpl(
      {@HiveField(0) @AnyToStringConverter() required this.url,
      @HiveField(1) @AnyToStringConverter() required this.lang})
      : super._();

  factory _$SubtitleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtitleModelImplFromJson(json);

  @override
  @HiveField(0)
  @AnyToStringConverter()
  final String url;
  @override
  @HiveField(1)
  @AnyToStringConverter()
  final String lang;

  @override
  String toString() {
    return 'SubtitleModel(url: $url, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtitleModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.lang, lang) || other.lang == lang));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, lang);

  /// Create a copy of SubtitleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtitleModelImplCopyWith<_$SubtitleModelImpl> get copyWith =>
      __$$SubtitleModelImplCopyWithImpl<_$SubtitleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtitleModelImplToJson(
      this,
    );
  }
}

abstract class _SubtitleModel extends SubtitleModel {
  const factory _SubtitleModel(
          {@HiveField(0) @AnyToStringConverter() required final String url,
          @HiveField(1) @AnyToStringConverter() required final String lang}) =
      _$SubtitleModelImpl;
  const _SubtitleModel._() : super._();

  factory _SubtitleModel.fromJson(Map<String, dynamic> json) =
      _$SubtitleModelImpl.fromJson;

  @override
  @HiveField(0)
  @AnyToStringConverter()
  String get url;
  @override
  @HiveField(1)
  @AnyToStringConverter()
  String get lang;

  /// Create a copy of SubtitleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtitleModelImplCopyWith<_$SubtitleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreamingResponseModel _$StreamingResponseModelFromJson(
    Map<String, dynamic> json) {
  return _StreamingResponseModel.fromJson(json);
}

/// @nodoc
mixin _$StreamingResponseModel {
  @HiveField(0)
  List<StreamingLinkModel> get sources => throw _privateConstructorUsedError;
  @HiveField(1)
  Map<String, String>? get headers => throw _privateConstructorUsedError;
  @HiveField(2)
  List<SubtitleModel>? get subtitles => throw _privateConstructorUsedError;

  /// Serializes this StreamingResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamingResponseModelCopyWith<StreamingResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingResponseModelCopyWith<$Res> {
  factory $StreamingResponseModelCopyWith(StreamingResponseModel value,
          $Res Function(StreamingResponseModel) then) =
      _$StreamingResponseModelCopyWithImpl<$Res, StreamingResponseModel>;
  @useResult
  $Res call(
      {@HiveField(0) List<StreamingLinkModel> sources,
      @HiveField(1) Map<String, String>? headers,
      @HiveField(2) List<SubtitleModel>? subtitles});
}

/// @nodoc
class _$StreamingResponseModelCopyWithImpl<$Res,
        $Val extends StreamingResponseModel>
    implements $StreamingResponseModelCopyWith<$Res> {
  _$StreamingResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sources = null,
    Object? headers = freezed,
    Object? subtitles = freezed,
  }) {
    return _then(_value.copyWith(
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<StreamingLinkModel>,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitles: freezed == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubtitleModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamingResponseModelImplCopyWith<$Res>
    implements $StreamingResponseModelCopyWith<$Res> {
  factory _$$StreamingResponseModelImplCopyWith(
          _$StreamingResponseModelImpl value,
          $Res Function(_$StreamingResponseModelImpl) then) =
      __$$StreamingResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<StreamingLinkModel> sources,
      @HiveField(1) Map<String, String>? headers,
      @HiveField(2) List<SubtitleModel>? subtitles});
}

/// @nodoc
class __$$StreamingResponseModelImplCopyWithImpl<$Res>
    extends _$StreamingResponseModelCopyWithImpl<$Res,
        _$StreamingResponseModelImpl>
    implements _$$StreamingResponseModelImplCopyWith<$Res> {
  __$$StreamingResponseModelImplCopyWithImpl(
      _$StreamingResponseModelImpl _value,
      $Res Function(_$StreamingResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sources = null,
    Object? headers = freezed,
    Object? subtitles = freezed,
  }) {
    return _then(_$StreamingResponseModelImpl(
      sources: null == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<StreamingLinkModel>,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      subtitles: freezed == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubtitleModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamingResponseModelImpl implements _StreamingResponseModel {
  const _$StreamingResponseModelImpl(
      {@HiveField(0) required final List<StreamingLinkModel> sources,
      @HiveField(1) final Map<String, String>? headers,
      @HiveField(2) final List<SubtitleModel>? subtitles})
      : _sources = sources,
        _headers = headers,
        _subtitles = subtitles;

  factory _$StreamingResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamingResponseModelImplFromJson(json);

  final List<StreamingLinkModel> _sources;
  @override
  @HiveField(0)
  List<StreamingLinkModel> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final Map<String, String>? _headers;
  @override
  @HiveField(1)
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<SubtitleModel>? _subtitles;
  @override
  @HiveField(2)
  List<SubtitleModel>? get subtitles {
    final value = _subtitles;
    if (value == null) return null;
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StreamingResponseModel(sources: $sources, headers: $headers, subtitles: $subtitles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingResponseModelImpl &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sources),
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(_subtitles));

  /// Create a copy of StreamingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingResponseModelImplCopyWith<_$StreamingResponseModelImpl>
      get copyWith => __$$StreamingResponseModelImplCopyWithImpl<
          _$StreamingResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamingResponseModelImplToJson(
      this,
    );
  }
}

abstract class _StreamingResponseModel implements StreamingResponseModel {
  const factory _StreamingResponseModel(
          {@HiveField(0) required final List<StreamingLinkModel> sources,
          @HiveField(1) final Map<String, String>? headers,
          @HiveField(2) final List<SubtitleModel>? subtitles}) =
      _$StreamingResponseModelImpl;

  factory _StreamingResponseModel.fromJson(Map<String, dynamic> json) =
      _$StreamingResponseModelImpl.fromJson;

  @override
  @HiveField(0)
  List<StreamingLinkModel> get sources;
  @override
  @HiveField(1)
  Map<String, String>? get headers;
  @override
  @HiveField(2)
  List<SubtitleModel>? get subtitles;

  /// Create a copy of StreamingResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingResponseModelImplCopyWith<_$StreamingResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ServerInfoModel _$ServerInfoModelFromJson(Map<String, dynamic> json) {
  return _ServerInfoModel.fromJson(json);
}

/// @nodoc
mixin _$ServerInfoModel {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this ServerInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerInfoModelCopyWith<ServerInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerInfoModelCopyWith<$Res> {
  factory $ServerInfoModelCopyWith(
          ServerInfoModel value, $Res Function(ServerInfoModel) then) =
      _$ServerInfoModelCopyWithImpl<$Res, ServerInfoModel>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$ServerInfoModelCopyWithImpl<$Res, $Val extends ServerInfoModel>
    implements $ServerInfoModelCopyWith<$Res> {
  _$ServerInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerInfoModelImplCopyWith<$Res>
    implements $ServerInfoModelCopyWith<$Res> {
  factory _$$ServerInfoModelImplCopyWith(_$ServerInfoModelImpl value,
          $Res Function(_$ServerInfoModelImpl) then) =
      __$$ServerInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$ServerInfoModelImplCopyWithImpl<$Res>
    extends _$ServerInfoModelCopyWithImpl<$Res, _$ServerInfoModelImpl>
    implements _$$ServerInfoModelImplCopyWith<$Res> {
  __$$ServerInfoModelImplCopyWithImpl(
      _$ServerInfoModelImpl _value, $Res Function(_$ServerInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_$ServerInfoModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerInfoModelImpl implements _ServerInfoModel {
  const _$ServerInfoModelImpl({required this.name, required this.url});

  factory _$ServerInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerInfoModelImplFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'ServerInfoModel(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerInfoModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  /// Create a copy of ServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerInfoModelImplCopyWith<_$ServerInfoModelImpl> get copyWith =>
      __$$ServerInfoModelImplCopyWithImpl<_$ServerInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerInfoModelImplToJson(
      this,
    );
  }
}

abstract class _ServerInfoModel implements ServerInfoModel {
  const factory _ServerInfoModel(
      {required final String name,
      required final String url}) = _$ServerInfoModelImpl;

  factory _ServerInfoModel.fromJson(Map<String, dynamic> json) =
      _$ServerInfoModelImpl.fromJson;

  @override
  String get name;
  @override
  String get url;

  /// Create a copy of ServerInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerInfoModelImplCopyWith<_$ServerInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
