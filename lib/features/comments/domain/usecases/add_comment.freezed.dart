// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddCommentParams {
  String get videoId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddCommentParamsCopyWith<AddCommentParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCommentParamsCopyWith<$Res> {
  factory $AddCommentParamsCopyWith(
          AddCommentParams value, $Res Function(AddCommentParams) then) =
      _$AddCommentParamsCopyWithImpl<$Res, AddCommentParams>;
  @useResult
  $Res call({String videoId, String content, String? parentId});
}

/// @nodoc
class _$AddCommentParamsCopyWithImpl<$Res, $Val extends AddCommentParams>
    implements $AddCommentParamsCopyWith<$Res> {
  _$AddCommentParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? content = null,
    Object? parentId = freezed,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCommentParamsImplCopyWith<$Res>
    implements $AddCommentParamsCopyWith<$Res> {
  factory _$$AddCommentParamsImplCopyWith(_$AddCommentParamsImpl value,
          $Res Function(_$AddCommentParamsImpl) then) =
      __$$AddCommentParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String videoId, String content, String? parentId});
}

/// @nodoc
class __$$AddCommentParamsImplCopyWithImpl<$Res>
    extends _$AddCommentParamsCopyWithImpl<$Res, _$AddCommentParamsImpl>
    implements _$$AddCommentParamsImplCopyWith<$Res> {
  __$$AddCommentParamsImplCopyWithImpl(_$AddCommentParamsImpl _value,
      $Res Function(_$AddCommentParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? content = null,
    Object? parentId = freezed,
  }) {
    return _then(_$AddCommentParamsImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddCommentParamsImpl implements _AddCommentParams {
  const _$AddCommentParamsImpl(
      {required this.videoId, required this.content, this.parentId});

  @override
  final String videoId;
  @override
  final String content;
  @override
  final String? parentId;

  @override
  String toString() {
    return 'AddCommentParams(videoId: $videoId, content: $content, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCommentParamsImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoId, content, parentId);

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCommentParamsImplCopyWith<_$AddCommentParamsImpl> get copyWith =>
      __$$AddCommentParamsImplCopyWithImpl<_$AddCommentParamsImpl>(
          this, _$identity);
}

abstract class _AddCommentParams implements AddCommentParams {
  const factory _AddCommentParams(
      {required final String videoId,
      required final String content,
      final String? parentId}) = _$AddCommentParamsImpl;

  @override
  String get videoId;
  @override
  String get content;
  @override
  String? get parentId;

  /// Create a copy of AddCommentParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCommentParamsImplCopyWith<_$AddCommentParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
