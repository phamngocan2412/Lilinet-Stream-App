// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalCommentModel {

@HiveField(0) String get localId;@HiveField(1) String? get serverId;@HiveField(2) String get videoId;@HiveField(3) String get content;@HiveField(4) DateTime get createdAt;@HiveField(5) bool get isSynced;@HiveField(6) bool get isGuest;@HiveField(7) String? get tempUserName;@HiveField(8) String? get tempAvatarUrl;@HiveField(9) String? get userId;@HiveField(10) int get likes;@HiveField(11) int get dislikes;@HiveField(12) int get repliesCount;@HiveField(13) String? get parentId;@HiveField(14) List<DateTime> get likeTimestamps;@HiveField(15) String? get mediaType;
/// Create a copy of LocalCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalCommentModelCopyWith<LocalCommentModel> get copyWith => _$LocalCommentModelCopyWithImpl<LocalCommentModel>(this as LocalCommentModel, _$identity);

  /// Serializes this LocalCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalCommentModel&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.tempUserName, tempUserName) || other.tempUserName == tempUserName)&&(identical(other.tempAvatarUrl, tempAvatarUrl) || other.tempAvatarUrl == tempAvatarUrl)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&const DeepCollectionEquality().equals(other.likeTimestamps, likeTimestamps)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,localId,serverId,videoId,content,createdAt,isSynced,isGuest,tempUserName,tempAvatarUrl,userId,likes,dislikes,repliesCount,parentId,const DeepCollectionEquality().hash(likeTimestamps),mediaType);

@override
String toString() {
  return 'LocalCommentModel(localId: $localId, serverId: $serverId, videoId: $videoId, content: $content, createdAt: $createdAt, isSynced: $isSynced, isGuest: $isGuest, tempUserName: $tempUserName, tempAvatarUrl: $tempAvatarUrl, userId: $userId, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, parentId: $parentId, likeTimestamps: $likeTimestamps, mediaType: $mediaType)';
}


}

/// @nodoc
abstract mixin class $LocalCommentModelCopyWith<$Res>  {
  factory $LocalCommentModelCopyWith(LocalCommentModel value, $Res Function(LocalCommentModel) _then) = _$LocalCommentModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String localId,@HiveField(1) String? serverId,@HiveField(2) String videoId,@HiveField(3) String content,@HiveField(4) DateTime createdAt,@HiveField(5) bool isSynced,@HiveField(6) bool isGuest,@HiveField(7) String? tempUserName,@HiveField(8) String? tempAvatarUrl,@HiveField(9) String? userId,@HiveField(10) int likes,@HiveField(11) int dislikes,@HiveField(12) int repliesCount,@HiveField(13) String? parentId,@HiveField(14) List<DateTime> likeTimestamps,@HiveField(15) String? mediaType
});




}
/// @nodoc
class _$LocalCommentModelCopyWithImpl<$Res>
    implements $LocalCommentModelCopyWith<$Res> {
  _$LocalCommentModelCopyWithImpl(this._self, this._then);

  final LocalCommentModel _self;
  final $Res Function(LocalCommentModel) _then;

/// Create a copy of LocalCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? serverId = freezed,Object? videoId = null,Object? content = null,Object? createdAt = null,Object? isSynced = null,Object? isGuest = null,Object? tempUserName = freezed,Object? tempAvatarUrl = freezed,Object? userId = freezed,Object? likes = null,Object? dislikes = null,Object? repliesCount = null,Object? parentId = freezed,Object? likeTimestamps = null,Object? mediaType = freezed,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,tempUserName: freezed == tempUserName ? _self.tempUserName : tempUserName // ignore: cast_nullable_to_non_nullable
as String?,tempAvatarUrl: freezed == tempAvatarUrl ? _self.tempAvatarUrl : tempAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,likeTimestamps: null == likeTimestamps ? _self.likeTimestamps : likeTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalCommentModel].
extension LocalCommentModelPatterns on LocalCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _LocalCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _LocalCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String localId, @HiveField(1)  String? serverId, @HiveField(2)  String videoId, @HiveField(3)  String content, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool isSynced, @HiveField(6)  bool isGuest, @HiveField(7)  String? tempUserName, @HiveField(8)  String? tempAvatarUrl, @HiveField(9)  String? userId, @HiveField(10)  int likes, @HiveField(11)  int dislikes, @HiveField(12)  int repliesCount, @HiveField(13)  String? parentId, @HiveField(14)  List<DateTime> likeTimestamps, @HiveField(15)  String? mediaType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalCommentModel() when $default != null:
return $default(_that.localId,_that.serverId,_that.videoId,_that.content,_that.createdAt,_that.isSynced,_that.isGuest,_that.tempUserName,_that.tempAvatarUrl,_that.userId,_that.likes,_that.dislikes,_that.repliesCount,_that.parentId,_that.likeTimestamps,_that.mediaType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String localId, @HiveField(1)  String? serverId, @HiveField(2)  String videoId, @HiveField(3)  String content, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool isSynced, @HiveField(6)  bool isGuest, @HiveField(7)  String? tempUserName, @HiveField(8)  String? tempAvatarUrl, @HiveField(9)  String? userId, @HiveField(10)  int likes, @HiveField(11)  int dislikes, @HiveField(12)  int repliesCount, @HiveField(13)  String? parentId, @HiveField(14)  List<DateTime> likeTimestamps, @HiveField(15)  String? mediaType)  $default,) {final _that = this;
switch (_that) {
case _LocalCommentModel():
return $default(_that.localId,_that.serverId,_that.videoId,_that.content,_that.createdAt,_that.isSynced,_that.isGuest,_that.tempUserName,_that.tempAvatarUrl,_that.userId,_that.likes,_that.dislikes,_that.repliesCount,_that.parentId,_that.likeTimestamps,_that.mediaType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String localId, @HiveField(1)  String? serverId, @HiveField(2)  String videoId, @HiveField(3)  String content, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool isSynced, @HiveField(6)  bool isGuest, @HiveField(7)  String? tempUserName, @HiveField(8)  String? tempAvatarUrl, @HiveField(9)  String? userId, @HiveField(10)  int likes, @HiveField(11)  int dislikes, @HiveField(12)  int repliesCount, @HiveField(13)  String? parentId, @HiveField(14)  List<DateTime> likeTimestamps, @HiveField(15)  String? mediaType)?  $default,) {final _that = this;
switch (_that) {
case _LocalCommentModel() when $default != null:
return $default(_that.localId,_that.serverId,_that.videoId,_that.content,_that.createdAt,_that.isSynced,_that.isGuest,_that.tempUserName,_that.tempAvatarUrl,_that.userId,_that.likes,_that.dislikes,_that.repliesCount,_that.parentId,_that.likeTimestamps,_that.mediaType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalCommentModel extends LocalCommentModel {
  const _LocalCommentModel({@HiveField(0) required this.localId, @HiveField(1) this.serverId, @HiveField(2) required this.videoId, @HiveField(3) required this.content, @HiveField(4) required this.createdAt, @HiveField(5) this.isSynced = false, @HiveField(6) this.isGuest = false, @HiveField(7) this.tempUserName, @HiveField(8) this.tempAvatarUrl, @HiveField(9) this.userId, @HiveField(10) this.likes = 0, @HiveField(11) this.dislikes = 0, @HiveField(12) this.repliesCount = 0, @HiveField(13) this.parentId, @HiveField(14) final  List<DateTime> likeTimestamps = const [], @HiveField(15) this.mediaType}): _likeTimestamps = likeTimestamps,super._();
  factory _LocalCommentModel.fromJson(Map<String, dynamic> json) => _$LocalCommentModelFromJson(json);

@override@HiveField(0) final  String localId;
@override@HiveField(1) final  String? serverId;
@override@HiveField(2) final  String videoId;
@override@HiveField(3) final  String content;
@override@HiveField(4) final  DateTime createdAt;
@override@JsonKey()@HiveField(5) final  bool isSynced;
@override@JsonKey()@HiveField(6) final  bool isGuest;
@override@HiveField(7) final  String? tempUserName;
@override@HiveField(8) final  String? tempAvatarUrl;
@override@HiveField(9) final  String? userId;
@override@JsonKey()@HiveField(10) final  int likes;
@override@JsonKey()@HiveField(11) final  int dislikes;
@override@JsonKey()@HiveField(12) final  int repliesCount;
@override@HiveField(13) final  String? parentId;
 final  List<DateTime> _likeTimestamps;
@override@JsonKey()@HiveField(14) List<DateTime> get likeTimestamps {
  if (_likeTimestamps is EqualUnmodifiableListView) return _likeTimestamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likeTimestamps);
}

@override@HiveField(15) final  String? mediaType;

/// Create a copy of LocalCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalCommentModelCopyWith<_LocalCommentModel> get copyWith => __$LocalCommentModelCopyWithImpl<_LocalCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalCommentModel&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.tempUserName, tempUserName) || other.tempUserName == tempUserName)&&(identical(other.tempAvatarUrl, tempAvatarUrl) || other.tempAvatarUrl == tempAvatarUrl)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&const DeepCollectionEquality().equals(other._likeTimestamps, _likeTimestamps)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,localId,serverId,videoId,content,createdAt,isSynced,isGuest,tempUserName,tempAvatarUrl,userId,likes,dislikes,repliesCount,parentId,const DeepCollectionEquality().hash(_likeTimestamps),mediaType);

@override
String toString() {
  return 'LocalCommentModel(localId: $localId, serverId: $serverId, videoId: $videoId, content: $content, createdAt: $createdAt, isSynced: $isSynced, isGuest: $isGuest, tempUserName: $tempUserName, tempAvatarUrl: $tempAvatarUrl, userId: $userId, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, parentId: $parentId, likeTimestamps: $likeTimestamps, mediaType: $mediaType)';
}


}

/// @nodoc
abstract mixin class _$LocalCommentModelCopyWith<$Res> implements $LocalCommentModelCopyWith<$Res> {
  factory _$LocalCommentModelCopyWith(_LocalCommentModel value, $Res Function(_LocalCommentModel) _then) = __$LocalCommentModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String localId,@HiveField(1) String? serverId,@HiveField(2) String videoId,@HiveField(3) String content,@HiveField(4) DateTime createdAt,@HiveField(5) bool isSynced,@HiveField(6) bool isGuest,@HiveField(7) String? tempUserName,@HiveField(8) String? tempAvatarUrl,@HiveField(9) String? userId,@HiveField(10) int likes,@HiveField(11) int dislikes,@HiveField(12) int repliesCount,@HiveField(13) String? parentId,@HiveField(14) List<DateTime> likeTimestamps,@HiveField(15) String? mediaType
});




}
/// @nodoc
class __$LocalCommentModelCopyWithImpl<$Res>
    implements _$LocalCommentModelCopyWith<$Res> {
  __$LocalCommentModelCopyWithImpl(this._self, this._then);

  final _LocalCommentModel _self;
  final $Res Function(_LocalCommentModel) _then;

/// Create a copy of LocalCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? serverId = freezed,Object? videoId = null,Object? content = null,Object? createdAt = null,Object? isSynced = null,Object? isGuest = null,Object? tempUserName = freezed,Object? tempAvatarUrl = freezed,Object? userId = freezed,Object? likes = null,Object? dislikes = null,Object? repliesCount = null,Object? parentId = freezed,Object? likeTimestamps = null,Object? mediaType = freezed,}) {
  return _then(_LocalCommentModel(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,tempUserName: freezed == tempUserName ? _self.tempUserName : tempUserName // ignore: cast_nullable_to_non_nullable
as String?,tempAvatarUrl: freezed == tempAvatarUrl ? _self.tempAvatarUrl : tempAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,likeTimestamps: null == likeTimestamps ? _self._likeTimestamps : likeTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
