// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentStateCopyWith<$Res> {
  factory $CommentStateCopyWith(
    CommentState value,
    $Res Function(CommentState) then,
  ) = _$CommentStateCopyWithImpl<$Res, CommentState>;
}

/// @nodoc
class _$CommentStateCopyWithImpl<$Res, $Val extends CommentState>
    implements $CommentStateCopyWith<$Res> {
  _$CommentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CommentState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CommentState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CommentState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CommentState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Comment> comments,
    CommentSortType sortType,
    Map<String, List<Comment>> expandedReplies,
    bool isAddingComment,
    String? errorMessage,
    Set<String> likedCommentIds,
    Set<String> likingInProgress,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? sortType = null,
    Object? expandedReplies = null,
    Object? isAddingComment = null,
    Object? errorMessage = freezed,
    Object? likedCommentIds = null,
    Object? likingInProgress = null,
  }) {
    return _then(
      _$LoadedImpl(
        comments: null == comments
            ? _value._comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as List<Comment>,
        sortType: null == sortType
            ? _value.sortType
            : sortType // ignore: cast_nullable_to_non_nullable
                  as CommentSortType,
        expandedReplies: null == expandedReplies
            ? _value._expandedReplies
            : expandedReplies // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<Comment>>,
        isAddingComment: null == isAddingComment
            ? _value.isAddingComment
            : isAddingComment // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        likedCommentIds: null == likedCommentIds
            ? _value._likedCommentIds
            : likedCommentIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        likingInProgress: null == likingInProgress
            ? _value._likingInProgress
            : likingInProgress // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<Comment> comments,
    required this.sortType,
    final Map<String, List<Comment>> expandedReplies = const {},
    this.isAddingComment = false,
    this.errorMessage,
    final Set<String> likedCommentIds = const {},
    final Set<String> likingInProgress = const {},
  }) : _comments = comments,
       _expandedReplies = expandedReplies,
       _likedCommentIds = likedCommentIds,
       _likingInProgress = likingInProgress;

  final List<Comment> _comments;
  @override
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final CommentSortType sortType;
  final Map<String, List<Comment>> _expandedReplies;
  @override
  @JsonKey()
  Map<String, List<Comment>> get expandedReplies {
    if (_expandedReplies is EqualUnmodifiableMapView) return _expandedReplies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expandedReplies);
  }

  @override
  @JsonKey()
  final bool isAddingComment;
  @override
  final String? errorMessage;
  final Set<String> _likedCommentIds;
  @override
  @JsonKey()
  Set<String> get likedCommentIds {
    if (_likedCommentIds is EqualUnmodifiableSetView) return _likedCommentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_likedCommentIds);
  }

  final Set<String> _likingInProgress;
  @override
  @JsonKey()
  Set<String> get likingInProgress {
    if (_likingInProgress is EqualUnmodifiableSetView) return _likingInProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_likingInProgress);
  }

  @override
  String toString() {
    return 'CommentState.loaded(comments: $comments, sortType: $sortType, expandedReplies: $expandedReplies, isAddingComment: $isAddingComment, errorMessage: $errorMessage, likedCommentIds: $likedCommentIds, likingInProgress: $likingInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            const DeepCollectionEquality().equals(
              other._expandedReplies,
              _expandedReplies,
            ) &&
            (identical(other.isAddingComment, isAddingComment) ||
                other.isAddingComment == isAddingComment) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._likedCommentIds,
              _likedCommentIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._likingInProgress,
              _likingInProgress,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_comments),
    sortType,
    const DeepCollectionEquality().hash(_expandedReplies),
    isAddingComment,
    errorMessage,
    const DeepCollectionEquality().hash(_likedCommentIds),
    const DeepCollectionEquality().hash(_likingInProgress),
  );

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      comments,
      sortType,
      expandedReplies,
      isAddingComment,
      errorMessage,
      likedCommentIds,
      likingInProgress,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      comments,
      sortType,
      expandedReplies,
      isAddingComment,
      errorMessage,
      likedCommentIds,
      likingInProgress,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        comments,
        sortType,
        expandedReplies,
        isAddingComment,
        errorMessage,
        likedCommentIds,
        likingInProgress,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements CommentState {
  const factory _Loaded({
    required final List<Comment> comments,
    required final CommentSortType sortType,
    final Map<String, List<Comment>> expandedReplies,
    final bool isAddingComment,
    final String? errorMessage,
    final Set<String> likedCommentIds,
    final Set<String> likingInProgress,
  }) = _$LoadedImpl;

  List<Comment> get comments;
  CommentSortType get sortType;
  Map<String, List<Comment>> get expandedReplies;
  bool get isAddingComment;
  String? get errorMessage;
  Set<String> get likedCommentIds;
  Set<String> get likingInProgress;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$CommentStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CommentState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Comment> comments,
      CommentSortType sortType,
      Map<String, List<Comment>> expandedReplies,
      bool isAddingComment,
      String? errorMessage,
      Set<String> likedCommentIds,
      Set<String> likingInProgress,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CommentState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
