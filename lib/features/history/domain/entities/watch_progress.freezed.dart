// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchProgress {
  String get mediaId;
  String get title;
  String? get posterUrl;
  String? get episodeId;
  String? get episodeTitle;
  int get positionSeconds;
  int get durationSeconds;
  DateTime get lastUpdated;
  bool get isFinished;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<WatchProgress> get copyWith =>
      _$WatchProgressCopyWithImpl<WatchProgress>(
          this as WatchProgress, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatchProgress &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            (identical(other.episodeTitle, episodeTitle) ||
                other.episodeTitle == episodeTitle) &&
            (identical(other.positionSeconds, positionSeconds) ||
                other.positionSeconds == positionSeconds) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mediaId,
      title,
      posterUrl,
      episodeId,
      episodeTitle,
      positionSeconds,
      durationSeconds,
      lastUpdated,
      isFinished);

  @override
  String toString() {
    return 'WatchProgress(mediaId: $mediaId, title: $title, posterUrl: $posterUrl, episodeId: $episodeId, episodeTitle: $episodeTitle, positionSeconds: $positionSeconds, durationSeconds: $durationSeconds, lastUpdated: $lastUpdated, isFinished: $isFinished)';
  }
}

/// @nodoc
abstract mixin class $WatchProgressCopyWith<$Res> {
  factory $WatchProgressCopyWith(
          WatchProgress value, $Res Function(WatchProgress) _then) =
      _$WatchProgressCopyWithImpl;
  @useResult
  $Res call(
      {String mediaId,
      String title,
      String? posterUrl,
      String? episodeId,
      String? episodeTitle,
      int positionSeconds,
      int durationSeconds,
      DateTime lastUpdated,
      bool isFinished});
}

/// @nodoc
class _$WatchProgressCopyWithImpl<$Res>
    implements $WatchProgressCopyWith<$Res> {
  _$WatchProgressCopyWithImpl(this._self, this._then);

  final WatchProgress _self;
  final $Res Function(WatchProgress) _then;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? title = null,
    Object? posterUrl = freezed,
    Object? episodeId = freezed,
    Object? episodeTitle = freezed,
    Object? positionSeconds = null,
    Object? durationSeconds = null,
    Object? lastUpdated = null,
    Object? isFinished = null,
  }) {
    return _then(_self.copyWith(
      mediaId: null == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _self.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      positionSeconds: null == positionSeconds
          ? _self.positionSeconds
          : positionSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinished: null == isFinished
          ? _self.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [WatchProgress].
extension WatchProgressPatterns on WatchProgress {
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
    TResult Function(_WatchProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
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
    TResult Function(_WatchProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress():
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
    TResult? Function(_WatchProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
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
    TResult Function(
            String mediaId,
            String title,
            String? posterUrl,
            String? episodeId,
            String? episodeTitle,
            int positionSeconds,
            int durationSeconds,
            DateTime lastUpdated,
            bool isFinished)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeId,
            _that.episodeTitle,
            _that.positionSeconds,
            _that.durationSeconds,
            _that.lastUpdated,
            _that.isFinished);
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
    TResult Function(
            String mediaId,
            String title,
            String? posterUrl,
            String? episodeId,
            String? episodeTitle,
            int positionSeconds,
            int durationSeconds,
            DateTime lastUpdated,
            bool isFinished)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress():
        return $default(
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeId,
            _that.episodeTitle,
            _that.positionSeconds,
            _that.durationSeconds,
            _that.lastUpdated,
            _that.isFinished);
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
    TResult? Function(
            String mediaId,
            String title,
            String? posterUrl,
            String? episodeId,
            String? episodeTitle,
            int positionSeconds,
            int durationSeconds,
            DateTime lastUpdated,
            bool isFinished)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeId,
            _that.episodeTitle,
            _that.positionSeconds,
            _that.durationSeconds,
            _that.lastUpdated,
            _that.isFinished);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WatchProgress implements WatchProgress {
  const _WatchProgress(
      {required this.mediaId,
      required this.title,
      this.posterUrl,
      this.episodeId,
      this.episodeTitle,
      required this.positionSeconds,
      required this.durationSeconds,
      required this.lastUpdated,
      required this.isFinished});

  @override
  final String mediaId;
  @override
  final String title;
  @override
  final String? posterUrl;
  @override
  final String? episodeId;
  @override
  final String? episodeTitle;
  @override
  final int positionSeconds;
  @override
  final int durationSeconds;
  @override
  final DateTime lastUpdated;
  @override
  final bool isFinished;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WatchProgressCopyWith<_WatchProgress> get copyWith =>
      __$WatchProgressCopyWithImpl<_WatchProgress>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WatchProgress &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            (identical(other.episodeTitle, episodeTitle) ||
                other.episodeTitle == episodeTitle) &&
            (identical(other.positionSeconds, positionSeconds) ||
                other.positionSeconds == positionSeconds) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mediaId,
      title,
      posterUrl,
      episodeId,
      episodeTitle,
      positionSeconds,
      durationSeconds,
      lastUpdated,
      isFinished);

  @override
  String toString() {
    return 'WatchProgress(mediaId: $mediaId, title: $title, posterUrl: $posterUrl, episodeId: $episodeId, episodeTitle: $episodeTitle, positionSeconds: $positionSeconds, durationSeconds: $durationSeconds, lastUpdated: $lastUpdated, isFinished: $isFinished)';
  }
}

/// @nodoc
abstract mixin class _$WatchProgressCopyWith<$Res>
    implements $WatchProgressCopyWith<$Res> {
  factory _$WatchProgressCopyWith(
          _WatchProgress value, $Res Function(_WatchProgress) _then) =
      __$WatchProgressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String mediaId,
      String title,
      String? posterUrl,
      String? episodeId,
      String? episodeTitle,
      int positionSeconds,
      int durationSeconds,
      DateTime lastUpdated,
      bool isFinished});
}

/// @nodoc
class __$WatchProgressCopyWithImpl<$Res>
    implements _$WatchProgressCopyWith<$Res> {
  __$WatchProgressCopyWithImpl(this._self, this._then);

  final _WatchProgress _self;
  final $Res Function(_WatchProgress) _then;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? title = null,
    Object? posterUrl = freezed,
    Object? episodeId = freezed,
    Object? episodeTitle = freezed,
    Object? positionSeconds = null,
    Object? durationSeconds = null,
    Object? lastUpdated = null,
    Object? isFinished = null,
  }) {
    return _then(_WatchProgress(
      mediaId: null == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _self.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      positionSeconds: null == positionSeconds
          ? _self.positionSeconds
          : positionSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinished: null == isFinished
          ? _self.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
