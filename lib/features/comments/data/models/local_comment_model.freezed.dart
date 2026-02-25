// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalCommentModel _$LocalCommentModelFromJson(Map<String, dynamic> json) {
  return _LocalCommentModel.fromJson(json);
}

/// @nodoc
mixin _$LocalCommentModel {
  @HiveField(0)
  String get localId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get serverId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get videoId => throw _privateConstructorUsedError;
  @HiveField(3)
  String get content => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isSynced => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get isGuest => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get tempUserName => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get tempAvatarUrl => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get userId => throw _privateConstructorUsedError;
  @HiveField(10)
  int get likes => throw _privateConstructorUsedError;
  @HiveField(11)
  int get dislikes => throw _privateConstructorUsedError;
  @HiveField(12)
  int get repliesCount => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get parentId => throw _privateConstructorUsedError;
  @HiveField(14)
  List<DateTime> get likeTimestamps => throw _privateConstructorUsedError;
  @HiveField(15)
  String? get mediaType => throw _privateConstructorUsedError;

  /// Serializes this LocalCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalCommentModelCopyWith<LocalCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalCommentModelCopyWith<$Res> {
  factory $LocalCommentModelCopyWith(
    LocalCommentModel value,
    $Res Function(LocalCommentModel) then,
  ) = _$LocalCommentModelCopyWithImpl<$Res, LocalCommentModel>;
  @useResult
  $Res call({
    @HiveField(0) String localId,
    @HiveField(1) String? serverId,
    @HiveField(2) String videoId,
    @HiveField(3) String content,
    @HiveField(4) DateTime createdAt,
    @HiveField(5) bool isSynced,
    @HiveField(6) bool isGuest,
    @HiveField(7) String? tempUserName,
    @HiveField(8) String? tempAvatarUrl,
    @HiveField(9) String? userId,
    @HiveField(10) int likes,
    @HiveField(11) int dislikes,
    @HiveField(12) int repliesCount,
    @HiveField(13) String? parentId,
    @HiveField(14) List<DateTime> likeTimestamps,
    @HiveField(15) String? mediaType,
  });
}

/// @nodoc
class _$LocalCommentModelCopyWithImpl<$Res, $Val extends LocalCommentModel>
    implements $LocalCommentModelCopyWith<$Res> {
  _$LocalCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? videoId = null,
    Object? content = null,
    Object? createdAt = null,
    Object? isSynced = null,
    Object? isGuest = null,
    Object? tempUserName = freezed,
    Object? tempAvatarUrl = freezed,
    Object? userId = freezed,
    Object? likes = null,
    Object? dislikes = null,
    Object? repliesCount = null,
    Object? parentId = freezed,
    Object? likeTimestamps = null,
    Object? mediaType = freezed,
  }) {
    return _then(
      _value.copyWith(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                as String,
        serverId: freezed == serverId
            ? _value.serverId
            : serverId // ignore: cast_nullable_to_non_nullable
                as String?,
        videoId: null == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                as DateTime,
        isSynced: null == isSynced
            ? _value.isSynced
            : isSynced // ignore: cast_nullable_to_non_nullable
                as bool,
        isGuest: null == isGuest
            ? _value.isGuest
            : isGuest // ignore: cast_nullable_to_non_nullable
                as bool,
        tempUserName: freezed == tempUserName
            ? _value.tempUserName
            : tempUserName // ignore: cast_nullable_to_non_nullable
                as String?,
        tempAvatarUrl: freezed == tempAvatarUrl
            ? _value.tempAvatarUrl
            : tempAvatarUrl // ignore: cast_nullable_to_non_nullable
                as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                as String?,
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
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                as String?,
        likeTimestamps: null == likeTimestamps
            ? _value.likeTimestamps
            : likeTimestamps // ignore: cast_nullable_to_non_nullable
                as List<DateTime>,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                as String?,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalCommentModelImplCopyWith<$Res>
    implements $LocalCommentModelCopyWith<$Res> {
  factory _$$LocalCommentModelImplCopyWith(
    _$LocalCommentModelImpl value,
    $Res Function(_$LocalCommentModelImpl) then,
  ) = __$$LocalCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String localId,
    @HiveField(1) String? serverId,
    @HiveField(2) String videoId,
    @HiveField(3) String content,
    @HiveField(4) DateTime createdAt,
    @HiveField(5) bool isSynced,
    @HiveField(6) bool isGuest,
    @HiveField(7) String? tempUserName,
    @HiveField(8) String? tempAvatarUrl,
    @HiveField(9) String? userId,
    @HiveField(10) int likes,
    @HiveField(11) int dislikes,
    @HiveField(12) int repliesCount,
    @HiveField(13) String? parentId,
    @HiveField(14) List<DateTime> likeTimestamps,
    @HiveField(15) String? mediaType,
  });
}

/// @nodoc
class __$$LocalCommentModelImplCopyWithImpl<$Res>
    extends _$LocalCommentModelCopyWithImpl<$Res, _$LocalCommentModelImpl>
    implements _$$LocalCommentModelImplCopyWith<$Res> {
  __$$LocalCommentModelImplCopyWithImpl(
    _$LocalCommentModelImpl _value,
    $Res Function(_$LocalCommentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? videoId = null,
    Object? content = null,
    Object? createdAt = null,
    Object? isSynced = null,
    Object? isGuest = null,
    Object? tempUserName = freezed,
    Object? tempAvatarUrl = freezed,
    Object? userId = freezed,
    Object? likes = null,
    Object? dislikes = null,
    Object? repliesCount = null,
    Object? parentId = freezed,
    Object? likeTimestamps = null,
    Object? mediaType = freezed,
  }) {
    return _then(
      _$LocalCommentModelImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                as String,
        serverId: freezed == serverId
            ? _value.serverId
            : serverId // ignore: cast_nullable_to_non_nullable
                as String?,
        videoId: null == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                as DateTime,
        isSynced: null == isSynced
            ? _value.isSynced
            : isSynced // ignore: cast_nullable_to_non_nullable
                as bool,
        isGuest: null == isGuest
            ? _value.isGuest
            : isGuest // ignore: cast_nullable_to_non_nullable
                as bool,
        tempUserName: freezed == tempUserName
            ? _value.tempUserName
            : tempUserName // ignore: cast_nullable_to_non_nullable
                as String?,
        tempAvatarUrl: freezed == tempAvatarUrl
            ? _value.tempAvatarUrl
            : tempAvatarUrl // ignore: cast_nullable_to_non_nullable
                as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                as String?,
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
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                as String?,
        likeTimestamps: null == likeTimestamps
            ? _value._likeTimestamps
            : likeTimestamps // ignore: cast_nullable_to_non_nullable
                as List<DateTime>,
        mediaType: freezed == mediaType
            ? _value.mediaType
            : mediaType // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalCommentModelImpl extends _LocalCommentModel {
  const _$LocalCommentModelImpl({
    @HiveField(0) required this.localId,
    @HiveField(1) this.serverId,
    @HiveField(2) required this.videoId,
    @HiveField(3) required this.content,
    @HiveField(4) required this.createdAt,
    @HiveField(5) this.isSynced = false,
    @HiveField(6) this.isGuest = false,
    @HiveField(7) this.tempUserName,
    @HiveField(8) this.tempAvatarUrl,
    @HiveField(9) this.userId,
    @HiveField(10) this.likes = 0,
    @HiveField(11) this.dislikes = 0,
    @HiveField(12) this.repliesCount = 0,
    @HiveField(13) this.parentId,
    @HiveField(14) final List<DateTime> likeTimestamps = const [],
    @HiveField(15) this.mediaType,
  })  : _likeTimestamps = likeTimestamps,
        super._();

  factory _$LocalCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalCommentModelImplFromJson(json);

  @override
  @HiveField(0)
  final String localId;
  @override
  @HiveField(1)
  final String? serverId;
  @override
  @HiveField(2)
  final String videoId;
  @override
  @HiveField(3)
  final String content;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @JsonKey()
  @HiveField(5)
  final bool isSynced;
  @override
  @JsonKey()
  @HiveField(6)
  final bool isGuest;
  @override
  @HiveField(7)
  final String? tempUserName;
  @override
  @HiveField(8)
  final String? tempAvatarUrl;
  @override
  @HiveField(9)
  final String? userId;
  @override
  @JsonKey()
  @HiveField(10)
  final int likes;
  @override
  @JsonKey()
  @HiveField(11)
  final int dislikes;
  @override
  @JsonKey()
  @HiveField(12)
  final int repliesCount;
  @override
  @HiveField(13)
  final String? parentId;
  final List<DateTime> _likeTimestamps;
  @override
  @JsonKey()
  @HiveField(14)
  List<DateTime> get likeTimestamps {
    if (_likeTimestamps is EqualUnmodifiableListView) return _likeTimestamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likeTimestamps);
  }

  @override
  @HiveField(15)
  final String? mediaType;

  @override
  String toString() {
    return 'LocalCommentModel(localId: $localId, serverId: $serverId, videoId: $videoId, content: $content, createdAt: $createdAt, isSynced: $isSynced, isGuest: $isGuest, tempUserName: $tempUserName, tempAvatarUrl: $tempAvatarUrl, userId: $userId, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, parentId: $parentId, likeTimestamps: $likeTimestamps, mediaType: $mediaType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalCommentModelImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.isGuest, isGuest) || other.isGuest == isGuest) &&
            (identical(other.tempUserName, tempUserName) ||
                other.tempUserName == tempUserName) &&
            (identical(other.tempAvatarUrl, tempAvatarUrl) ||
                other.tempAvatarUrl == tempAvatarUrl) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.dislikes, dislikes) ||
                other.dislikes == dislikes) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality().equals(
              other._likeTimestamps,
              _likeTimestamps,
            ) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        localId,
        serverId,
        videoId,
        content,
        createdAt,
        isSynced,
        isGuest,
        tempUserName,
        tempAvatarUrl,
        userId,
        likes,
        dislikes,
        repliesCount,
        parentId,
        const DeepCollectionEquality().hash(_likeTimestamps),
        mediaType,
      );

  /// Create a copy of LocalCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalCommentModelImplCopyWith<_$LocalCommentModelImpl> get copyWith =>
      __$$LocalCommentModelImplCopyWithImpl<_$LocalCommentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalCommentModelImplToJson(this);
  }
}

abstract class _LocalCommentModel extends LocalCommentModel {
  const factory _LocalCommentModel({
    @HiveField(0) required final String localId,
    @HiveField(1) final String? serverId,
    @HiveField(2) required final String videoId,
    @HiveField(3) required final String content,
    @HiveField(4) required final DateTime createdAt,
    @HiveField(5) final bool isSynced,
    @HiveField(6) final bool isGuest,
    @HiveField(7) final String? tempUserName,
    @HiveField(8) final String? tempAvatarUrl,
    @HiveField(9) final String? userId,
    @HiveField(10) final int likes,
    @HiveField(11) final int dislikes,
    @HiveField(12) final int repliesCount,
    @HiveField(13) final String? parentId,
    @HiveField(14) final List<DateTime> likeTimestamps,
    @HiveField(15) final String? mediaType,
  }) = _$LocalCommentModelImpl;
  const _LocalCommentModel._() : super._();

  factory _LocalCommentModel.fromJson(Map<String, dynamic> json) =
      _$LocalCommentModelImpl.fromJson;

  @override
  @HiveField(0)
  String get localId;
  @override
  @HiveField(1)
  String? get serverId;
  @override
  @HiveField(2)
  String get videoId;
  @override
  @HiveField(3)
  String get content;
  @override
  @HiveField(4)
  DateTime get createdAt;
  @override
  @HiveField(5)
  bool get isSynced;
  @override
  @HiveField(6)
  bool get isGuest;
  @override
  @HiveField(7)
  String? get tempUserName;
  @override
  @HiveField(8)
  String? get tempAvatarUrl;
  @override
  @HiveField(9)
  String? get userId;
  @override
  @HiveField(10)
  int get likes;
  @override
  @HiveField(11)
  int get dislikes;
  @override
  @HiveField(12)
  int get repliesCount;
  @override
  @HiveField(13)
  String? get parentId;
  @override
  @HiveField(14)
  List<DateTime> get likeTimestamps;
  @override
  @HiveField(15)
  String? get mediaType;

  /// Create a copy of LocalCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalCommentModelImplCopyWith<_$LocalCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
