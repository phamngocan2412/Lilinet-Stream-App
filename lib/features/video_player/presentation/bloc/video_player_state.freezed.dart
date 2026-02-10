// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoPlayerState {
  VideoPlayerStatus get status => throw _privateConstructorUsedError;
  String? get episodeId => throw _privateConstructorUsedError;
  String? get mediaId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get posterUrl => throw _privateConstructorUsedError;
  String? get episodeTitle => throw _privateConstructorUsedError;
  Duration? get startPosition => throw _privateConstructorUsedError;
  String? get mediaType => throw _privateConstructorUsedError;
  Movie? get movie => throw _privateConstructorUsedError;
  StreamingState get streamingState => throw _privateConstructorUsedError;
  List<String>? get availableServers => throw _privateConstructorUsedError;
  String? get currentServer => throw _privateConstructorUsedError;
  String? get currentQuality => throw _privateConstructorUsedError;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoPlayerStateCopyWith<VideoPlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoPlayerStateCopyWith<$Res> {
  factory $VideoPlayerStateCopyWith(
          VideoPlayerState value, $Res Function(VideoPlayerState) then) =
      _$VideoPlayerStateCopyWithImpl<$Res, VideoPlayerState>;
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
class _$VideoPlayerStateCopyWithImpl<$Res, $Val extends VideoPlayerState>
    implements $VideoPlayerStateCopyWith<$Res> {
  _$VideoPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoPlayerStatus,
      episodeId: freezed == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: freezed == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      startPosition: freezed == startPosition
          ? _value.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      streamingState: null == streamingState
          ? _value.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      availableServers: freezed == availableServers
          ? _value.availableServers
          : availableServers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentServer: freezed == currentServer
          ? _value.currentServer
          : currentServer // ignore: cast_nullable_to_non_nullable
              as String?,
      currentQuality: freezed == currentQuality
          ? _value.currentQuality
          : currentQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res>? get movie {
    if (_value.movie == null) {
      return null;
    }

    return $MovieCopyWith<$Res>(_value.movie!, (value) {
      return _then(_value.copyWith(movie: value) as $Val);
    });
  }

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreamingStateCopyWith<$Res> get streamingState {
    return $StreamingStateCopyWith<$Res>(_value.streamingState, (value) {
      return _then(_value.copyWith(streamingState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoPlayerStateImplCopyWith<$Res>
    implements $VideoPlayerStateCopyWith<$Res> {
  factory _$$VideoPlayerStateImplCopyWith(_$VideoPlayerStateImpl value,
          $Res Function(_$VideoPlayerStateImpl) then) =
      __$$VideoPlayerStateImplCopyWithImpl<$Res>;
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
class __$$VideoPlayerStateImplCopyWithImpl<$Res>
    extends _$VideoPlayerStateCopyWithImpl<$Res, _$VideoPlayerStateImpl>
    implements _$$VideoPlayerStateImplCopyWith<$Res> {
  __$$VideoPlayerStateImplCopyWithImpl(_$VideoPlayerStateImpl _value,
      $Res Function(_$VideoPlayerStateImpl) _then)
      : super(_value, _then);

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
    return _then(_$VideoPlayerStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VideoPlayerStatus,
      episodeId: freezed == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaId: freezed == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeTitle: freezed == episodeTitle
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      startPosition: freezed == startPosition
          ? _value.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as Duration?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      streamingState: null == streamingState
          ? _value.streamingState
          : streamingState // ignore: cast_nullable_to_non_nullable
              as StreamingState,
      availableServers: freezed == availableServers
          ? _value._availableServers
          : availableServers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentServer: freezed == currentServer
          ? _value.currentServer
          : currentServer // ignore: cast_nullable_to_non_nullable
              as String?,
      currentQuality: freezed == currentQuality
          ? _value.currentQuality
          : currentQuality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VideoPlayerStateImpl implements _VideoPlayerState {
  const _$VideoPlayerStateImpl(
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

  @override
  String toString() {
    return 'VideoPlayerState(status: $status, episodeId: $episodeId, mediaId: $mediaId, title: $title, posterUrl: $posterUrl, episodeTitle: $episodeTitle, startPosition: $startPosition, mediaType: $mediaType, movie: $movie, streamingState: $streamingState, availableServers: $availableServers, currentServer: $currentServer, currentQuality: $currentQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoPlayerStateImpl &&
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

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoPlayerStateImplCopyWith<_$VideoPlayerStateImpl> get copyWith =>
      __$$VideoPlayerStateImplCopyWithImpl<_$VideoPlayerStateImpl>(
          this, _$identity);
}

abstract class _VideoPlayerState implements VideoPlayerState {
  const factory _VideoPlayerState(
      {final VideoPlayerStatus status,
      final String? episodeId,
      final String? mediaId,
      final String? title,
      final String? posterUrl,
      final String? episodeTitle,
      final Duration? startPosition,
      final String? mediaType,
      final Movie? movie,
      final StreamingState streamingState,
      final List<String>? availableServers,
      final String? currentServer,
      final String? currentQuality}) = _$VideoPlayerStateImpl;

  @override
  VideoPlayerStatus get status;
  @override
  String? get episodeId;
  @override
  String? get mediaId;
  @override
  String? get title;
  @override
  String? get posterUrl;
  @override
  String? get episodeTitle;
  @override
  Duration? get startPosition;
  @override
  String? get mediaType;
  @override
  Movie? get movie;
  @override
  StreamingState get streamingState;
  @override
  List<String>? get availableServers;
  @override
  String? get currentServer;
  @override
  String? get currentQuality;

  /// Create a copy of VideoPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoPlayerStateImplCopyWith<_$VideoPlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
