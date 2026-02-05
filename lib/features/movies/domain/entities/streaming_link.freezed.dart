// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streaming_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamingLink {
  String get url;
  String get quality;
  bool get isM3U8;
  Map<String, String>? get headers;

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StreamingLinkCopyWith<StreamingLink> get copyWith =>
      _$StreamingLinkCopyWithImpl<StreamingLink>(
          this as StreamingLink, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreamingLink &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8) &&
            const DeepCollectionEquality().equals(other.headers, headers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, quality, isM3U8,
      const DeepCollectionEquality().hash(headers));

  @override
  String toString() {
    return 'StreamingLink(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
  }
}

/// @nodoc
abstract mixin class $StreamingLinkCopyWith<$Res> {
  factory $StreamingLinkCopyWith(
          StreamingLink value, $Res Function(StreamingLink) _then) =
      _$StreamingLinkCopyWithImpl;
  @useResult
  $Res call(
      {String url, String quality, bool isM3U8, Map<String, String>? headers});
}

/// @nodoc
class _$StreamingLinkCopyWithImpl<$Res>
    implements $StreamingLinkCopyWith<$Res> {
  _$StreamingLinkCopyWithImpl(this._self, this._then);

  final StreamingLink _self;
  final $Res Function(StreamingLink) _then;

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
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      isM3U8: null == isM3U8
          ? _self.isM3U8
          : isM3U8 // ignore: cast_nullable_to_non_nullable
              as bool,
      headers: freezed == headers
          ? _self.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StreamingLink].
extension StreamingLinkPatterns on StreamingLink {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_StreamingLink value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StreamingLink() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_StreamingLink value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StreamingLink():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_StreamingLink value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StreamingLink() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String url, String quality, bool isM3U8,
            Map<String, String>? headers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StreamingLink() when $default != null:
        return $default(_that.url, _that.quality, _that.isM3U8, _that.headers);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url, String quality, bool isM3U8,
            Map<String, String>? headers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StreamingLink():
        return $default(_that.url, _that.quality, _that.isM3U8, _that.headers);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String url, String quality, bool isM3U8,
            Map<String, String>? headers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StreamingLink() when $default != null:
        return $default(_that.url, _that.quality, _that.isM3U8, _that.headers);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _StreamingLink implements StreamingLink {
  const _StreamingLink(
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

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StreamingLinkCopyWith<_StreamingLink> get copyWith =>
      __$StreamingLinkCopyWithImpl<_StreamingLink>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StreamingLink &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.isM3U8, isM3U8) || other.isM3U8 == isM3U8) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, quality, isM3U8,
      const DeepCollectionEquality().hash(_headers));

  @override
  String toString() {
    return 'StreamingLink(url: $url, quality: $quality, isM3U8: $isM3U8, headers: $headers)';
  }
}

/// @nodoc
abstract mixin class _$StreamingLinkCopyWith<$Res>
    implements $StreamingLinkCopyWith<$Res> {
  factory _$StreamingLinkCopyWith(
          _StreamingLink value, $Res Function(_StreamingLink) _then) =
      __$StreamingLinkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url, String quality, bool isM3U8, Map<String, String>? headers});
}

/// @nodoc
class __$StreamingLinkCopyWithImpl<$Res>
    implements _$StreamingLinkCopyWith<$Res> {
  __$StreamingLinkCopyWithImpl(this._self, this._then);

  final _StreamingLink _self;
  final $Res Function(_StreamingLink) _then;

  /// Create a copy of StreamingLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? quality = null,
    Object? isM3U8 = null,
    Object? headers = freezed,
  }) {
    return _then(_StreamingLink(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _self.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      isM3U8: null == isM3U8
          ? _self.isM3U8
          : isM3U8 // ignore: cast_nullable_to_non_nullable
              as bool,
      headers: freezed == headers
          ? _self._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

// dart format on
