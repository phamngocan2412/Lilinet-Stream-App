// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Episode {
  String get id;
  String get title;
  String? get description;
  int get number;
  int? get season;
  String? get image;
  String? get url;
  DateTime? get releaseDate;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EpisodeCopyWith<Episode> get copyWith =>
      _$EpisodeCopyWithImpl<Episode>(this as Episode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Episode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, number,
      season, image, url, releaseDate);

  @override
  String toString() {
    return 'Episode(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
  }
}

/// @nodoc
abstract mixin class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) _then) =
      _$EpisodeCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      int number,
      int? season,
      String? image,
      String? url,
      DateTime? releaseDate});
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res> implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._self, this._then);

  final Episode _self;
  final $Res Function(Episode) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? number = null,
    Object? season = freezed,
    Object? image = freezed,
    Object? url = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      season: freezed == season
          ? _self.season
          : season // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Episode].
extension EpisodePatterns on Episode {
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
    TResult Function(_Episode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
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
    TResult Function(_Episode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode():
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
    TResult? Function(_Episode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
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
    TResult Function(String id, String title, String? description, int number,
            int? season, String? image, String? url, DateTime? releaseDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.number,
            _that.season, _that.image, _that.url, _that.releaseDate);
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
    TResult Function(String id, String title, String? description, int number,
            int? season, String? image, String? url, DateTime? releaseDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode():
        return $default(_that.id, _that.title, _that.description, _that.number,
            _that.season, _that.image, _that.url, _that.releaseDate);
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
    TResult? Function(String id, String title, String? description, int number,
            int? season, String? image, String? url, DateTime? releaseDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.number,
            _that.season, _that.image, _that.url, _that.releaseDate);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Episode implements Episode {
  const _Episode(
      {required this.id,
      required this.title,
      this.description,
      required this.number,
      this.season,
      this.image,
      this.url,
      this.releaseDate});

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int number;
  @override
  final int? season;
  @override
  final String? image;
  @override
  final String? url;
  @override
  final DateTime? releaseDate;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EpisodeCopyWith<_Episode> get copyWith =>
      __$EpisodeCopyWithImpl<_Episode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Episode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, number,
      season, image, url, releaseDate);

  @override
  String toString() {
    return 'Episode(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
  }
}

/// @nodoc
abstract mixin class _$EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$EpisodeCopyWith(_Episode value, $Res Function(_Episode) _then) =
      __$EpisodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      int number,
      int? season,
      String? image,
      String? url,
      DateTime? releaseDate});
}

/// @nodoc
class __$EpisodeCopyWithImpl<$Res> implements _$EpisodeCopyWith<$Res> {
  __$EpisodeCopyWithImpl(this._self, this._then);

  final _Episode _self;
  final $Res Function(_Episode) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? number = null,
    Object? season = freezed,
    Object? image = freezed,
    Object? url = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_Episode(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      season: freezed == season
          ? _self.season
          : season // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
