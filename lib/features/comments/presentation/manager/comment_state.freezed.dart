// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState()';
}


}

/// @nodoc
class $CommentStateCopyWith<$Res>  {
$CommentStateCopyWith(CommentState _, $Res Function(CommentState) __);
}


/// Adds pattern-matching-related methods to [CommentState].
extension CommentStatePatterns on CommentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Comment> comments,  CommentSortType sortType,  Map<String, List<Comment>> expandedReplies,  bool isAddingComment,  String? errorMessage,  Set<String> likedCommentIds,  Set<String> likingInProgress)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.comments,_that.sortType,_that.expandedReplies,_that.isAddingComment,_that.errorMessage,_that.likedCommentIds,_that.likingInProgress);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Comment> comments,  CommentSortType sortType,  Map<String, List<Comment>> expandedReplies,  bool isAddingComment,  String? errorMessage,  Set<String> likedCommentIds,  Set<String> likingInProgress)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.comments,_that.sortType,_that.expandedReplies,_that.isAddingComment,_that.errorMessage,_that.likedCommentIds,_that.likingInProgress);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Comment> comments,  CommentSortType sortType,  Map<String, List<Comment>> expandedReplies,  bool isAddingComment,  String? errorMessage,  Set<String> likedCommentIds,  Set<String> likingInProgress)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.comments,_that.sortType,_that.expandedReplies,_that.isAddingComment,_that.errorMessage,_that.likedCommentIds,_that.likingInProgress);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CommentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState.initial()';
}


}




/// @nodoc


class _Loading implements CommentState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommentState.loading()';
}


}




/// @nodoc


class _Loaded implements CommentState {
  const _Loaded({required final  List<Comment> comments, required this.sortType, final  Map<String, List<Comment>> expandedReplies = const {}, this.isAddingComment = false, this.errorMessage, final  Set<String> likedCommentIds = const {}, final  Set<String> likingInProgress = const {}}): _comments = comments,_expandedReplies = expandedReplies,_likedCommentIds = likedCommentIds,_likingInProgress = likingInProgress;
  

 final  List<Comment> _comments;
 List<Comment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  CommentSortType sortType;
 final  Map<String, List<Comment>> _expandedReplies;
@JsonKey() Map<String, List<Comment>> get expandedReplies {
  if (_expandedReplies is EqualUnmodifiableMapView) return _expandedReplies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_expandedReplies);
}

@JsonKey() final  bool isAddingComment;
 final  String? errorMessage;
 final  Set<String> _likedCommentIds;
@JsonKey() Set<String> get likedCommentIds {
  if (_likedCommentIds is EqualUnmodifiableSetView) return _likedCommentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_likedCommentIds);
}

 final  Set<String> _likingInProgress;
@JsonKey() Set<String> get likingInProgress {
  if (_likingInProgress is EqualUnmodifiableSetView) return _likingInProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_likingInProgress);
}


/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.sortType, sortType) || other.sortType == sortType)&&const DeepCollectionEquality().equals(other._expandedReplies, _expandedReplies)&&(identical(other.isAddingComment, isAddingComment) || other.isAddingComment == isAddingComment)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._likedCommentIds, _likedCommentIds)&&const DeepCollectionEquality().equals(other._likingInProgress, _likingInProgress));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_comments),sortType,const DeepCollectionEquality().hash(_expandedReplies),isAddingComment,errorMessage,const DeepCollectionEquality().hash(_likedCommentIds),const DeepCollectionEquality().hash(_likingInProgress));

@override
String toString() {
  return 'CommentState.loaded(comments: $comments, sortType: $sortType, expandedReplies: $expandedReplies, isAddingComment: $isAddingComment, errorMessage: $errorMessage, likedCommentIds: $likedCommentIds, likingInProgress: $likingInProgress)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Comment> comments, CommentSortType sortType, Map<String, List<Comment>> expandedReplies, bool isAddingComment, String? errorMessage, Set<String> likedCommentIds, Set<String> likingInProgress
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? comments = null,Object? sortType = null,Object? expandedReplies = null,Object? isAddingComment = null,Object? errorMessage = freezed,Object? likedCommentIds = null,Object? likingInProgress = null,}) {
  return _then(_Loaded(
comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as CommentSortType,expandedReplies: null == expandedReplies ? _self._expandedReplies : expandedReplies // ignore: cast_nullable_to_non_nullable
as Map<String, List<Comment>>,isAddingComment: null == isAddingComment ? _self.isAddingComment : isAddingComment // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,likedCommentIds: null == likedCommentIds ? _self._likedCommentIds : likedCommentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,likingInProgress: null == likingInProgress ? _self._likingInProgress : likingInProgress // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class _Error implements CommentState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CommentState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
