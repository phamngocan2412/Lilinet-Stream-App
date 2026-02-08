// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamingLink {
  String get url => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;
  bool get isM3U8 => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamingLinkCopyWith<StreamingLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamingLinkCopyWith<$Res> {
  factory $StreamingLinkCopyWith(
          StreamingLink value, $Res Function(StreamingLink) then) =
      _$StreamingLinkCopyWithImpl<$Res, StreamingLink>;
  @useResult
  $Res call(
      {String url, String quality, bool isM3U8, Map<String, String>? headers});
}

/// @nodoc
class _$StreamingLinkCopyWithImpl<$Res, $Val extends StreamingLink>
    implements $StreamingLinkCopyWith<$Res> {
  _$StreamingLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamingLink
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
abstract class _$$StreamingLinkImplCopyWith<$Res>
    implements $StreamingLinkCopyWith<$Res> {
  factory _$$StreamingLinkImplCopyWith(
          _$StreamingLinkImpl value, $Res Function(_$StreamingLinkImpl) then) =
      __$$StreamingLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String quality, bool isM3U8, Map<String, String>? headers});
}

/// @nodoc
class __$$StreamingLinkImplCopyWithImpl<$Res>
    extends _$StreamingLinkCopyWithImpl<$Res, _$StreamingLinkImpl>
    implements _$$StreamingLinkImplCopyWith<$Res> {
  __$$StreamingLinkImplCopyWithImpl(
      _$StreamingLinkImpl _value, $Res Function(_$StreamingLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? quality = null,
    Object? isM3U8 = null,
    Object? headers = freezed,
  }) {
    return _then(_$StreamingLinkImpl(
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

class _$StreamingLinkImpl implements _StreamingLink {
  const _$StreamingLinkImpl(
      {required this.url,
      required this.quality,
      required this.isM3U8,
      final Map<String, String>? headers})
      : _headers = headers;

  @override
  final String url;
  @override
  final String quality;
  @override
  final bool isM3U8;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StreamingLink(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamingLinkImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, quality, isM3U8,
      const DeepCollectionEquality().hash(_headers));

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamingLinkImplCopyWith<_$StreamingLinkImpl> get copyWith =>
      __$$StreamingLinkImplCopyWithImpl<_$StreamingLinkImpl>(this, _$identity);
}

abstract class _StreamingLink implements StreamingLink {
  const factory _StreamingLink(
      {required final String url,
      required final String quality,
      required final bool isM3U8,
      final Map<String, String>? headers}) = _$StreamingLinkImpl;

  @override
  String get url;
  @override
  String get quality;
  @override
  bool get isM3U8;
  @override
  Map<String, String>? get headers;

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamingLinkImplCopyWith<_$StreamingLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
