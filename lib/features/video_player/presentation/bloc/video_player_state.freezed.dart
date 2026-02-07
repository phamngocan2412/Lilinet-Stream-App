// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoPlayerState {
  VideoPlayerStatus get status;
  String? get episodeId;
  String? get mediaId;
  String? get title;
  String? get posterUrl;
  String? get episodeTitle;
  Duration? get startPosition;
  String? get mediaType;
  Movie? get movie;
  StreamingState get streamingState;
  List<String>? get availableServers;
  String? get currentServer;
  String? get currentQuality;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VideoPlayerStateCopyWith<VideoPlayerState> get copyWith =>
      _$VideoPlayerStateCopyWithImpl<VideoPlayerState>(
          this as VideoPlayerState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VideoPlayerState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.episodeTitle, episodeTitle) ||
                other.episodeTitle == episodeTitle) &&
            (identical(other.startPosition, startPosition) ||
                other.startPosition == startPosition) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.movie, movie) || other.movie == movie) &&
            (identical(other.streamingState, streamingState) ||
                other.streamingState == streamingState) &&
            const DeepCollectionEquality()
                .equals(other.availableServers, availableServers) &&
            (identical(other.currentServer, currentServer) ||
                other.currentServer == currentServer) &&
            (identical(other.currentQuality, currentQuality) ||
                other.currentQuality == currentQuality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      episodeId,
      mediaId,
      title,
      posterUrl,
      episodeTitle,
      startPosition,
      mediaType,
      movie,
      streamingState,
      const DeepCollectionEquality().hash(availableServers),
      currentServer,
      currentQuality);

  @override
  String toString() {
    return 'VideoPlayerState(status: $status, episodeId: $episodeId, mediaId: $mediaId, title: $title, posterUrl: $posterUrl, episodeTitle: $episodeTitle, startPosition: $startPosition, mediaType: $mediaType, movie: $movie, streamingState: $streamingState, availableServers: $availableServers, currentServer: $currentServer, currentQuality: $currentQuality)';
  }
}

/// @nodoc
abstract mixin class $VideoPlayerStateCopyWith<$Res> {
  factory $VideoPlayerStateCopyWith(
          VideoPlayerState value, $Res Function(VideoPlayerState) _then) =
      _$VideoPlayerStateCopyWithImpl;
  @useResult
  $Res call(
      {VideoPlayerStatus status,
      String? episodeId,
      String? mediaId,
      String? title,
      String? posterUrl,
      String? episodeTitle,
      Duration? startPosition,
      String? mediaType,
      Movie? movie,
      StreamingState streamingState,
      List<String>? availableServers,
      String? currentServer,
      String? currentQuality});

  $MovieCopyWith<$Res>? get movie;
  $StreamingStateCopyWith<$Res> get streamingState;
}

/// @nodoc
class _$VideoPlayerStateCopyWithImpl<$Res>
    implements $VideoPlayerStateCopyWith<$Res> {
  _$VideoPlayerStateCopyWithImpl(this._self, this._then);

  final VideoPlayerState _self;
  final $Res Function(VideoPlayerState) _then;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? episodeId = freezed,
    Object? mediaId = freezed,
    Object? title = freezed,
    Object? posterUrl = freezed,
    Object? episodeTitle = freezed,
    Object? startPosition = freezed,
    Object? mediaType = freezed,
    Object? movie = freezed,
    Object? streamingState = null,
    Object? availableServers = freezed,
    Object? currentServer = freezed,
    Object? currentQuality = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoPlayerStatus,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: freezed == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _self.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      startPosition: freezed == startPosition
          ? _self.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      mediaType: freezed == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _self.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      streamingState: null == streamingState
          ? _self.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      availableServers: freezed == availableServers
          ? _self.availableServers
          : availableServers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentServer: freezed == currentServer
          ? _self.currentServer
          : currentServer // ignore: cast_nullable_to_non_nullable
              as String?,
      currentQuality: freezed == currentQuality
          ? _self.currentQuality
          : currentQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res>? get movie {
    if (_self.movie == null) {
      return null;
    }

    return $MovieCopyWith<$Res>(_self.movie!, (value) {
      return _then(_self.copyWith(movie: value));
    });
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingStateCopyWith<$Res> get streamingState {
    return $StreamingStateCopyWith<$Res>(_self.streamingState, (value) {
      return _then(_self.copyWith(streamingState: value));
    });
  }
}

/// Adds pattern-matching-related methods to [VideoPlayerState].
extension VideoPlayerStatePatterns on VideoPlayerState {
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
    TResult Function(_VideoPlayerState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState() when $default != null:
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
    TResult Function(_VideoPlayerState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState():
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
    TResult? Function(_VideoPlayerState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState() when $default != null:
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
            VideoPlayerStatus status,
            String? episodeId,
            String? mediaId,
            String? title,
            String? posterUrl,
            String? episodeTitle,
            Duration? startPosition,
            String? mediaType,
            Movie? movie,
            StreamingState streamingState,
            List<String>? availableServers,
            String? currentServer,
            String? currentQuality)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState() when $default != null:
        return $default(
            _that.status,
            _that.episodeId,
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeTitle,
            _that.startPosition,
            _that.mediaType,
            _that.movie,
            _that.streamingState,
            _that.availableServers,
            _that.currentServer,
            _that.currentQuality);
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
            VideoPlayerStatus status,
            String? episodeId,
            String? mediaId,
            String? title,
            String? posterUrl,
            String? episodeTitle,
            Duration? startPosition,
            String? mediaType,
            Movie? movie,
            StreamingState streamingState,
            List<String>? availableServers,
            String? currentServer,
            String? currentQuality)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState():
        return $default(
            _that.status,
            _that.episodeId,
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeTitle,
            _that.startPosition,
            _that.mediaType,
            _that.movie,
            _that.streamingState,
            _that.availableServers,
            _that.currentServer,
            _that.currentQuality);
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
            VideoPlayerStatus status,
            String? episodeId,
            String? mediaId,
            String? title,
            String? posterUrl,
            String? episodeTitle,
            Duration? startPosition,
            String? mediaType,
            Movie? movie,
            StreamingState streamingState,
            List<String>? availableServers,
            String? currentServer,
            String? currentQuality)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoPlayerState() when $default != null:
        return $default(
            _that.status,
            _that.episodeId,
            _that.mediaId,
            _that.title,
            _that.posterUrl,
            _that.episodeTitle,
            _that.startPosition,
            _that.mediaType,
            _that.movie,
            _that.streamingState,
            _that.availableServers,
            _that.currentServer,
            _that.currentQuality);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VideoPlayerState implements VideoPlayerState {
  const _VideoPlayerState(
      {this.status = VideoPlayerStatus.closed,
      this.episodeId,
      this.mediaId,
      this.title,
      this.posterUrl,
      this.episodeTitle,
      this.startPosition,
      this.mediaType,
      this.movie,
      this.streamingState = const StreamingState.initial(),
      final List<String>? availableServers,
      this.currentServer,
      this.currentQuality})
      : _availableServers = availableServers;

  @override
  @JsonKey()
  final VideoPlayerStatus status;
  @override
  final String? episodeId;
  @override
  final String? mediaId;
  @override
  final String? title;
  @override
  final String? posterUrl;
  @override
  final String? episodeTitle;
  @override
  final Duration? startPosition;
  @override
  final String? mediaType;
  @override
  final Movie? movie;
  @override
  @JsonKey()
  final StreamingState streamingState;
  final List<String>? _availableServers;
  @override
  List<String>? get availableServers {
    final value = _availableServers;
    if (value == null) return null;
    if (_availableServers is EqualUnmodifiableListView)
      return _availableServers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? currentServer;
  @override
  final String? currentQuality;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VideoPlayerStateCopyWith<_VideoPlayerState> get copyWith =>
      __$VideoPlayerStateCopyWithImpl<_VideoPlayerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VideoPlayerState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.episodeTitle, episodeTitle) ||
                other.episodeTitle == episodeTitle) &&
            (identical(other.startPosition, startPosition) ||
                other.startPosition == startPosition) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.movie, movie) || other.movie == movie) &&
            (identical(other.streamingState, streamingState) ||
                other.streamingState == streamingState) &&
            const DeepCollectionEquality()
                .equals(other._availableServers, _availableServers) &&
            (identical(other.currentServer, currentServer) ||
                other.currentServer == currentServer) &&
            (identical(other.currentQuality, currentQuality) ||
                other.currentQuality == currentQuality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      episodeId,
      mediaId,
      title,
      posterUrl,
      episodeTitle,
      startPosition,
      mediaType,
      movie,
      streamingState,
      const DeepCollectionEquality().hash(_availableServers),
      currentServer,
      currentQuality);

  @override
  String toString() {
    return 'VideoPlayerState(status: $status, episodeId: $episodeId, mediaId: $mediaId, title: $title, posterUrl: $posterUrl, episodeTitle: $episodeTitle, startPosition: $startPosition, mediaType: $mediaType, movie: $movie, streamingState: $streamingState, availableServers: $availableServers, currentServer: $currentServer, currentQuality: $currentQuality)';
  }
}

/// @nodoc
abstract mixin class _$VideoPlayerStateCopyWith<$Res>
    implements $VideoPlayerStateCopyWith<$Res> {
  factory _$VideoPlayerStateCopyWith(
          _VideoPlayerState value, $Res Function(_VideoPlayerState) _then) =
      __$VideoPlayerStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {VideoPlayerStatus status,
      String? episodeId,
      String? mediaId,
      String? title,
      String? posterUrl,
      String? episodeTitle,
      Duration? startPosition,
      String? mediaType,
      Movie? movie,
      StreamingState streamingState,
      List<String>? availableServers,
      String? currentServer,
      String? currentQuality});

  @override
  $MovieCopyWith<$Res>? get movie;
  @override
  $StreamingStateCopyWith<$Res> get streamingState;
}

/// @nodoc
class __$VideoPlayerStateCopyWithImpl<$Res>
    implements _$VideoPlayerStateCopyWith<$Res> {
  __$VideoPlayerStateCopyWithImpl(this._self, this._then);

  final _VideoPlayerState _self;
  final $Res Function(_VideoPlayerState) _then;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? episodeId = freezed,
    Object? mediaId = freezed,
    Object? title = freezed,
    Object? posterUrl = freezed,
    Object? episodeTitle = freezed,
    Object? startPosition = freezed,
    Object? mediaType = freezed,
    Object? movie = freezed,
    Object? streamingState = null,
    Object? availableServers = freezed,
    Object? currentServer = freezed,
    Object? currentQuality = freezed,
  }) {
    return _then(_VideoPlayerState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoPlayerStatus,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: freezed == mediaId
          ? _self.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _self.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      startPosition: freezed == startPosition
          ? _self.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      mediaType: freezed == mediaType
          ? _self.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _self.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      streamingState: null == streamingState
          ? _self.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      availableServers: freezed == availableServers
          ? _self._availableServers
          : availableServers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentServer: freezed == currentServer
          ? _self.currentServer
          : currentServer // ignore: cast_nullable_to_non_nullable
              as String?,
      currentQuality: freezed == currentQuality
          ? _self.currentQuality
          : currentQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res>? get movie {
    if (_self.movie == null) {
      return null;
    }

    return $MovieCopyWith<$Res>(_self.movie!, (value) {
      return _then(_self.copyWith(movie: value));
    });
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingStateCopyWith<$Res> get streamingState {
    return $StreamingStateCopyWith<$Res>(_self.streamingState, (value) {
      return _then(_self.copyWith(streamingState: value));
    });
  }
}

// dart format on
