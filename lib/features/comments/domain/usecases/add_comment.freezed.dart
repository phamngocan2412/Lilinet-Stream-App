// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddCommentParams {
  String get videoId;
  String get content;
  String? get parentId;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddCommentParamsCopyWith<AddCommentParams> get copyWith =>
      _$AddCommentParamsCopyWithImpl<AddCommentParams>(
          this as AddCommentParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddCommentParams &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoId, content, parentId);

  @override
  String toString() {
    return 'AddCommentParams(videoId: $videoId, content: $content, parentId: $parentId)';
  }
}

/// @nodoc
abstract mixin class $AddCommentParamsCopyWith<$Res> {
  factory $AddCommentParamsCopyWith(
          AddCommentParams value, $Res Function(AddCommentParams) _then) =
      _$AddCommentParamsCopyWithImpl;
  @useResult
  $Res call({String videoId, String content, String? parentId});
}

/// @nodoc
class _$AddCommentParamsCopyWithImpl<$Res>
    implements $AddCommentParamsCopyWith<$Res> {
  _$AddCommentParamsCopyWithImpl(this._self, this._then);

  final AddCommentParams _self;
  final $Res Function(AddCommentParams) _then;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? content = null,
    Object? parentId = freezed,
  }) {
    return _then(_self.copyWith(
      videoId: null == videoId
          ? _self.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AddCommentParams].
extension AddCommentParamsPatterns on AddCommentParams {
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
    TResult Function(_AddCommentParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams() when $default != null:
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
    TResult Function(_AddCommentParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams():
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
    TResult? Function(_AddCommentParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams() when $default != null:
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
    TResult Function(String videoId, String content, String? parentId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams() when $default != null:
        return $default(_that.videoId, _that.content, _that.parentId);
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
    TResult Function(String videoId, String content, String? parentId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams():
        return $default(_that.videoId, _that.content, _that.parentId);
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
    TResult? Function(String videoId, String content, String? parentId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AddCommentParams() when $default != null:
        return $default(_that.videoId, _that.content, _that.parentId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AddCommentParams implements AddCommentParams {
  const _AddCommentParams(
      {required this.videoId, required this.content, this.parentId});

  @override
  final String videoId;
  @override
  final String content;
  @override
  final String? parentId;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddCommentParamsCopyWith<_AddCommentParams> get copyWith =>
      __$AddCommentParamsCopyWithImpl<_AddCommentParams>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddCommentParams &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoId, content, parentId);

  @override
  String toString() {
    return 'AddCommentParams(videoId: $videoId, content: $content, parentId: $parentId)';
  }
}

/// @nodoc
abstract mixin class _$AddCommentParamsCopyWith<$Res>
    implements $AddCommentParamsCopyWith<$Res> {
  factory _$AddCommentParamsCopyWith(
          _AddCommentParams value, $Res Function(_AddCommentParams) _then) =
      __$AddCommentParamsCopyWithImpl;
  @override
  @useResult
  $Res call({String videoId, String content, String? parentId});
}

/// @nodoc
class __$AddCommentParamsCopyWithImpl<$Res>
    implements _$AddCommentParamsCopyWith<$Res> {
  __$AddCommentParamsCopyWithImpl(this._self, this._then);

  final _AddCommentParams _self;
  final $Res Function(_AddCommentParams) _then;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? videoId = null,
    Object? content = null,
    Object? parentId = freezed,
  }) {
    return _then(_AddCommentParams(
      videoId: null == videoId
          ? _self.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
