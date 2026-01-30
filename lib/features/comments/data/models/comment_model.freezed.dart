// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

 String get id; String get videoId; String get userName; String get avatarUrl; String get content; int get likes; int get dislikes; int get repliesCount; DateTime get createdAt; DateTime? get updatedAt; List<DateTime> get likeTimestamps; List<CommentModel> get replies; String? get parentId; String? get mediaType; bool get isEdited; bool get isDeleted; bool get isPinned;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.likeTimestamps, likeTimestamps)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,videoId,userName,avatarUrl,content,likes,dislikes,repliesCount,createdAt,updatedAt,const DeepCollectionEquality().hash(likeTimestamps),const DeepCollectionEquality().hash(replies),parentId,mediaType,isEdited,isDeleted,isPinned);

@override
String toString() {
  return 'CommentModel(id: $id, videoId: $videoId, userName: $userName, avatarUrl: $avatarUrl, content: $content, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, createdAt: $createdAt, updatedAt: $updatedAt, likeTimestamps: $likeTimestamps, replies: $replies, parentId: $parentId, mediaType: $mediaType, isEdited: $isEdited, isDeleted: $isDeleted, isPinned: $isPinned)';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String videoId, String userName, String avatarUrl, String content, int likes, int dislikes, int repliesCount, DateTime createdAt, DateTime? updatedAt, List<DateTime> likeTimestamps, List<CommentModel> replies, String? parentId, String? mediaType, bool isEdited, bool isDeleted, bool isPinned
});




}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? videoId = null,Object? userName = null,Object? avatarUrl = null,Object? content = null,Object? likes = null,Object? dislikes = null,Object? repliesCount = null,Object? createdAt = null,Object? updatedAt = freezed,Object? likeTimestamps = null,Object? replies = null,Object? parentId = freezed,Object? mediaType = freezed,Object? isEdited = null,Object? isDeleted = null,Object? isPinned = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likeTimestamps: null == likeTimestamps ? _self.likeTimestamps : likeTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String videoId,  String userName,  String avatarUrl,  String content,  int likes,  int dislikes,  int repliesCount,  DateTime createdAt,  DateTime? updatedAt,  List<DateTime> likeTimestamps,  List<CommentModel> replies,  String? parentId,  String? mediaType,  bool isEdited,  bool isDeleted,  bool isPinned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.videoId,_that.userName,_that.avatarUrl,_that.content,_that.likes,_that.dislikes,_that.repliesCount,_that.createdAt,_that.updatedAt,_that.likeTimestamps,_that.replies,_that.parentId,_that.mediaType,_that.isEdited,_that.isDeleted,_that.isPinned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String videoId,  String userName,  String avatarUrl,  String content,  int likes,  int dislikes,  int repliesCount,  DateTime createdAt,  DateTime? updatedAt,  List<DateTime> likeTimestamps,  List<CommentModel> replies,  String? parentId,  String? mediaType,  bool isEdited,  bool isDeleted,  bool isPinned)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.videoId,_that.userName,_that.avatarUrl,_that.content,_that.likes,_that.dislikes,_that.repliesCount,_that.createdAt,_that.updatedAt,_that.likeTimestamps,_that.replies,_that.parentId,_that.mediaType,_that.isEdited,_that.isDeleted,_that.isPinned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String videoId,  String userName,  String avatarUrl,  String content,  int likes,  int dislikes,  int repliesCount,  DateTime createdAt,  DateTime? updatedAt,  List<DateTime> likeTimestamps,  List<CommentModel> replies,  String? parentId,  String? mediaType,  bool isEdited,  bool isDeleted,  bool isPinned)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.videoId,_that.userName,_that.avatarUrl,_that.content,_that.likes,_that.dislikes,_that.repliesCount,_that.createdAt,_that.updatedAt,_that.likeTimestamps,_that.replies,_that.parentId,_that.mediaType,_that.isEdited,_that.isDeleted,_that.isPinned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel extends CommentModel {
  const _CommentModel({required this.id, required this.videoId, required this.userName, required this.avatarUrl, required this.content, this.likes = 0, this.dislikes = 0, this.repliesCount = 0, required this.createdAt, this.updatedAt, final  List<DateTime> likeTimestamps = const [], final  List<CommentModel> replies = const [], this.parentId, this.mediaType, this.isEdited = false, this.isDeleted = false, this.isPinned = false}): _likeTimestamps = likeTimestamps,_replies = replies,super._();
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override final  String id;
@override final  String videoId;
@override final  String userName;
@override final  String avatarUrl;
@override final  String content;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int dislikes;
@override@JsonKey() final  int repliesCount;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
 final  List<DateTime> _likeTimestamps;
@override@JsonKey() List<DateTime> get likeTimestamps {
  if (_likeTimestamps is EqualUnmodifiableListView) return _likeTimestamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likeTimestamps);
}

 final  List<CommentModel> _replies;
@override@JsonKey() List<CommentModel> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  String? parentId;
@override final  String? mediaType;
@override@JsonKey() final  bool isEdited;
@override@JsonKey() final  bool isDeleted;
@override@JsonKey() final  bool isPinned;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._likeTimestamps, _likeTimestamps)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,videoId,userName,avatarUrl,content,likes,dislikes,repliesCount,createdAt,updatedAt,const DeepCollectionEquality().hash(_likeTimestamps),const DeepCollectionEquality().hash(_replies),parentId,mediaType,isEdited,isDeleted,isPinned);

@override
String toString() {
  return 'CommentModel(id: $id, videoId: $videoId, userName: $userName, avatarUrl: $avatarUrl, content: $content, likes: $likes, dislikes: $dislikes, repliesCount: $repliesCount, createdAt: $createdAt, updatedAt: $updatedAt, likeTimestamps: $likeTimestamps, replies: $replies, parentId: $parentId, mediaType: $mediaType, isEdited: $isEdited, isDeleted: $isDeleted, isPinned: $isPinned)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String videoId, String userName, String avatarUrl, String content, int likes, int dislikes, int repliesCount, DateTime createdAt, DateTime? updatedAt, List<DateTime> likeTimestamps, List<CommentModel> replies, String? parentId, String? mediaType, bool isEdited, bool isDeleted, bool isPinned
});




}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? videoId = null,Object? userName = null,Object? avatarUrl = null,Object? content = null,Object? likes = null,Object? dislikes = null,Object? repliesCount = null,Object? createdAt = null,Object? updatedAt = freezed,Object? likeTimestamps = null,Object? replies = null,Object? parentId = freezed,Object? mediaType = freezed,Object? isEdited = null,Object? isDeleted = null,Object? isPinned = null,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likeTimestamps: null == likeTimestamps ? _self._likeTimestamps : likeTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
