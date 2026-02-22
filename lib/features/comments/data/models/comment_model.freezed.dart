// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  String get id => throw _privateConstructorUsedError;
  String get videoId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  int get dislikes => throw _privateConstructorUsedError;
  int get repliesCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<DateTime> get likeTimestamps => throw _privateConstructorUsedError;
  List<CommentModel> get replies => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String? get mediaType => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
    CommentModel value,
    $Res Function(CommentModel) then,
  ) = _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call({
    String id,
    String videoId,
    String userName,
    String avatarUrl,
    String content,
    int likes,
    int dislikes,
    int repliesCount,
    DateTime createdAt,
    DateTime? updatedAt,
    List<DateTime> likeTimestamps,
    List<CommentModel> replies,
    String? parentId,
    String? mediaType,
    bool isEdited,
    bool isDeleted,
    bool isPinned,
  });
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoId = null,
    Object? userName = null,
    Object? avatarUrl = null,
    Object? content = null,
    Object? likes = null,
    Object? dislikes = null,
    Object? repliesCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? likeTimestamps = null,
    Object? replies = null,
    Object? parentId = freezed,
    Object? mediaType = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? isPinned = null,
  }) {
    return _then(
      _value.copyWith(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
        videoId: null == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                as String,
        likes: null == likes
            ? _value.likes
            : likes // ignore: cast_nullable_to_non_nullable
                as int,
        dislikes: null == dislikes
            ? _value.dislikes
            : dislikes // ignore: cast_nullable_to_non_nullable
                as int,
        repliesCount: null == repliesCount
            ? _value.repliesCount
            : repliesCount // ignore: cast_nullable_to_non_nullable
                as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                as DateTime?,
        likeTimestamps: null == likeTimestamps
            ? _value.likeTimestamps
            : likeTimestamps // ignore: cast_nullable_to_non_nullable
                as List<DateTime>,
        replies: null == replies
            ? _value.replies
            : replies // ignore: cast_nullable_to_non_nullable
                as List<CommentModel>,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                as String?,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                as String?,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                as bool,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                as bool,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                as bool,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
    _$CommentModelImpl value,
    $Res Function(_$CommentModelImpl) then,
  ) = __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String videoId,
    String userName,
    String avatarUrl,
    String content,
    int likes,
    int dislikes,
    int repliesCount,
    DateTime createdAt,
    DateTime? updatedAt,
    List<DateTime> likeTimestamps,
    List<CommentModel> replies,
    String? parentId,
    String? mediaType,
    bool isEdited,
    bool isDeleted,
    bool isPinned,
  });
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
    _$CommentModelImpl _value,
    $Res Function(_$CommentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoId = null,
    Object? userName = null,
    Object? avatarUrl = null,
    Object? content = null,
    Object? likes = null,
    Object? dislikes = null,
    Object? repliesCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? likeTimestamps = null,
    Object? replies = null,
    Object? parentId = freezed,
    Object? mediaType = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? isPinned = null,
  }) {
    return _then(
      _$CommentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
        videoId: null == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                as String,
        likes: null == likes
            ? _value.likes
            : likes // ignore: cast_nullable_to_non_nullable
                as int,
        dislikes: null == dislikes
            ? _value.dislikes
            : dislikes // ignore: cast_nullable_to_non_nullable
                as int,
        repliesCount: null == repliesCount
            ? _value.repliesCount
            : repliesCount // ignore: cast_nullable_to_non_nullable
                as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                as DateTime?,
        likeTimestamps: null == likeTimestamps
            ? _value._likeTimestamps
            : likeTimestamps // ignore: cast_nullable_to_non_nullable
                as List<DateTime>,
        replies: null == replies
            ? _value._replies
            : replies // ignore: cast_nullable_to_non_nullable
                as List<CommentModel>,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                as String?,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                as String?,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                as bool,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                as bool,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelImpl extends _CommentModel {
  const _$CommentModelImpl({
    required this.id,
    required this.videoId,
    required this.userName,
    required this.avatarUrl,
    required this.content,
    this.likes = 0,
    this.dislikes = 0,
    this.repliesCount = 0,
    required this.createdAt,
    this.updatedAt,
    final List<DateTime> likeTimestamps = const [],
    final List<CommentModel> replies = const [],
    this.parentId,
    this.mediaType,
    this.isEdited = false,
    this.isDeleted = false,
    this.isPinned = false,
  })  : _likeTimestamps = likeTimestamps,
        _replies = replies,
        super._();

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String videoId;
  @override
  final String userName;
  @override
  final String avatarUrl;
  @override
  final String content;
  @override
  @JsonKey()
  final int likes;
  @override
  @JsonKey()
  final int dislikes;
  @override
  @JsonKey()
  final int repliesCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  final List<DateTime> _likeTimestamps;
  @override
  @JsonKey()
  List<DateTime> get likeTimestamps {
    if (_likeTimestamps is EqualUnmodifiableListView) return _likeTimestamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeTimestamps);
  }

  final List<CommentModel> _replies;
  @override
  @JsonKey()
  List<CommentModel> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  final String? parentId;
  @override
  final String? mediaType;
  @override
  @JsonKey()
  final bool isEdited;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final bool isPinned;

  @override
  String toString() {
    return 'CommentModel(id: $id, videoId: $videoId, userName: $userName, avatarUrl: $avatarUrl, content: $content, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, createdAt: $createdAt, updatedAt: $updatedAt, likeTimestamps: $likeTimestamps, replies: $replies, parentId: $parentId, mediaType: $mediaType, isEdited: $isEdited, isDeleted: $isDeleted, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.dislikes, dislikes) ||
                other.dislikes == dislikes) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._likeTimestamps,
              _likeTimestamps,
            ) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        videoId,
        userName,
        avatarUrl,
        content,
        likes,
        dislikes,
        repliesCount,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_likeTimestamps),
        const DeepCollectionEquality().hash(_replies),
        parentId,
        mediaType,
        isEdited,
        isDeleted,
        isPinned,
      );

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(this);
  }
}

abstract class _CommentModel extends CommentModel {
  const factory _CommentModel({
    required final String id,
    required final String videoId,
    required final String userName,
    required final String avatarUrl,
    required final String content,
    final int likes,
    final int dislikes,
    final int repliesCount,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final List<DateTime> likeTimestamps,
    final List<CommentModel> replies,
    final String? parentId,
    final String? mediaType,
    final bool isEdited,
    final bool isDeleted,
    final bool isPinned,
  }) = _$CommentModelImpl;
  const _CommentModel._() : super._();

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get videoId;
  @override
  String get userName;
  @override
  String get avatarUrl;
  @override
  String get content;
  @override
  int get likes;
  @override
  int get dislikes;
  @override
  int get repliesCount;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<DateTime> get likeTimestamps;
  @override
  List<CommentModel> get replies;
  @override
  String? get parentId;
  @override
  String? get mediaType;
  @override
  bool get isEdited;
  @override
  bool get isDeleted;
  @override
  bool get isPinned;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
