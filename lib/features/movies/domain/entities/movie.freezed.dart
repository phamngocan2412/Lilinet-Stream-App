// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Movie {
  String get id;
  String get title;
  String? get poster;
  String? get cover;
  String? get description;
  double? get rating;
  String? get releaseDate;
  String get type; // 'Movie' or 'TV Series'
  String? get episodeId;
  List<String> get genres;
  int? get totalEpisodes;
  String? get duration;
  List<Episode>? get episodes;
  List<Movie>? get recommendations;
  String? get country;
  String? get production;
  List<String>? get casts;
  List<String>? get tags;
  String? get provider;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MovieCopyWith<Movie> get copyWith =>
      _$MovieCopyWithImpl<Movie>(this as Movie, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Movie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            const DeepCollectionEquality().equals(other.genres, genres) &&
            (identical(other.totalEpisodes, totalEpisodes) ||
                other.totalEpisodes == totalEpisodes) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other.episodes, episodes) &&
            const DeepCollectionEquality()
                .equals(other.recommendations, recommendations) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.production, production) ||
                other.production == production) &&
            const DeepCollectionEquality().equals(other.casts, casts) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        poster,
        cover,
        description,
        rating,
        releaseDate,
        type,
        episodeId,
        const DeepCollectionEquality().hash(genres),
        totalEpisodes,
        duration,
        const DeepCollectionEquality().hash(episodes),
        const DeepCollectionEquality().hash(recommendations),
        country,
        production,
        const DeepCollectionEquality().hash(casts),
        const DeepCollectionEquality().hash(tags),
        provider
      ]);

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, provider: $provider)';
  }
}

/// @nodoc
abstract mixin class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) _then) =
      _$MovieCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String? poster,
      String? cover,
      String? description,
      double? rating,
      String? releaseDate,
      String type,
      String? episodeId,
      List<String> genres,
      int? totalEpisodes,
      String? duration,
      List<Episode>? episodes,
      List<Movie>? recommendations,
      String? country,
      String? production,
      List<String>? casts,
      List<String>? tags,
      String? provider});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res> implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._self, this._then);

  final Movie _self;
  final $Res Function(Movie) _then;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? poster = freezed,
    Object? cover = freezed,
    Object? description = freezed,
    Object? rating = freezed,
    Object? releaseDate = freezed,
    Object? type = null,
    Object? episodeId = freezed,
    Object? genres = null,
    Object? totalEpisodes = freezed,
    Object? duration = freezed,
    Object? episodes = freezed,
    Object? recommendations = freezed,
    Object? country = freezed,
    Object? production = freezed,
    Object? casts = freezed,
    Object? tags = freezed,
    Object? provider = freezed,
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
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: freezed == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalEpisodes: freezed == totalEpisodes
          ? _self.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _self.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      recommendations: freezed == recommendations
          ? _self.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as String?,
      casts: freezed == casts
          ? _self.casts
          : casts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      provider: freezed == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Movie].
extension MoviePatterns on Movie {
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
    TResult Function(_Movie value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Movie() when $default != null:
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
    TResult Function(_Movie value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Movie():
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
    TResult? Function(_Movie value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Movie() when $default != null:
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
            String id,
            String title,
            String? poster,
            String? cover,
            String? description,
            double? rating,
            String? releaseDate,
            String type,
            String? episodeId,
            List<String> genres,
            int? totalEpisodes,
            String? duration,
            List<Episode>? episodes,
            List<Movie>? recommendations,
            String? country,
            String? production,
            List<String>? casts,
            List<String>? tags,
            String? provider)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Movie() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.poster,
            _that.cover,
            _that.description,
            _that.rating,
            _that.releaseDate,
            _that.type,
            _that.episodeId,
            _that.genres,
            _that.totalEpisodes,
            _that.duration,
            _that.episodes,
            _that.recommendations,
            _that.country,
            _that.production,
            _that.casts,
            _that.tags,
            _that.provider);
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
            String id,
            String title,
            String? poster,
            String? cover,
            String? description,
            double? rating,
            String? releaseDate,
            String type,
            String? episodeId,
            List<String> genres,
            int? totalEpisodes,
            String? duration,
            List<Episode>? episodes,
            List<Movie>? recommendations,
            String? country,
            String? production,
            List<String>? casts,
            List<String>? tags,
            String? provider)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Movie():
        return $default(
            _that.id,
            _that.title,
            _that.poster,
            _that.cover,
            _that.description,
            _that.rating,
            _that.releaseDate,
            _that.type,
            _that.episodeId,
            _that.genres,
            _that.totalEpisodes,
            _that.duration,
            _that.episodes,
            _that.recommendations,
            _that.country,
            _that.production,
            _that.casts,
            _that.tags,
            _that.provider);
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
            String id,
            String title,
            String? poster,
            String? cover,
            String? description,
            double? rating,
            String? releaseDate,
            String type,
            String? episodeId,
            List<String> genres,
            int? totalEpisodes,
            String? duration,
            List<Episode>? episodes,
            List<Movie>? recommendations,
            String? country,
            String? production,
            List<String>? casts,
            List<String>? tags,
            String? provider)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Movie() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.poster,
            _that.cover,
            _that.description,
            _that.rating,
            _that.releaseDate,
            _that.type,
            _that.episodeId,
            _that.genres,
            _that.totalEpisodes,
            _that.duration,
            _that.episodes,
            _that.recommendations,
            _that.country,
            _that.production,
            _that.casts,
            _that.tags,
            _that.provider);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Movie implements Movie {
  const _Movie(
      {required this.id,
      required this.title,
      this.poster,
      this.cover,
      this.description,
      this.rating,
      this.releaseDate,
      required this.type,
      this.episodeId,
      final List<String> genres = const [],
      this.totalEpisodes,
      this.duration,
      final List<Episode>? episodes,
      final List<Movie>? recommendations,
      this.country,
      this.production,
      final List<String>? casts,
      final List<String>? tags,
      this.provider})
      : _genres = genres,
        _episodes = episodes,
        _recommendations = recommendations,
        _casts = casts,
        _tags = tags;

  @override
  final String id;
  @override
  final String title;
  @override
  final String? poster;
  @override
  final String? cover;
  @override
  final String? description;
  @override
  final double? rating;
  @override
  final String? releaseDate;
  @override
  final String type;
// 'Movie' or 'TV Series'
  @override
  final String? episodeId;
  final List<String> _genres;
  @override
  @JsonKey()
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  final int? totalEpisodes;
  @override
  final String? duration;
  final List<Episode>? _episodes;
  @override
  List<Episode>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Movie>? _recommendations;
  @override
  List<Movie>? get recommendations {
    final value = _recommendations;
    if (value == null) return null;
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? country;
  @override
  final String? production;
  final List<String>? _casts;
  @override
  List<String>? get casts {
    final value = _casts;
    if (value == null) return null;
    if (_casts is EqualUnmodifiableListView) return _casts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? provider;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MovieCopyWith<_Movie> get copyWith =>
      __$MovieCopyWithImpl<_Movie>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Movie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.poster, poster) || other.poster == poster) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.totalEpisodes, totalEpisodes) ||
                other.totalEpisodes == totalEpisodes) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.production, production) ||
                other.production == production) &&
            const DeepCollectionEquality().equals(other._casts, _casts) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        poster,
        cover,
        description,
        rating,
        releaseDate,
        type,
        episodeId,
        const DeepCollectionEquality().hash(_genres),
        totalEpisodes,
        duration,
        const DeepCollectionEquality().hash(_episodes),
        const DeepCollectionEquality().hash(_recommendations),
        country,
        production,
        const DeepCollectionEquality().hash(_casts),
        const DeepCollectionEquality().hash(_tags),
        provider
      ]);

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, provider: $provider)';
  }
}

/// @nodoc
abstract mixin class _$MovieCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$MovieCopyWith(_Movie value, $Res Function(_Movie) _then) =
      __$MovieCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? poster,
      String? cover,
      String? description,
      double? rating,
      String? releaseDate,
      String type,
      String? episodeId,
      List<String> genres,
      int? totalEpisodes,
      String? duration,
      List<Episode>? episodes,
      List<Movie>? recommendations,
      String? country,
      String? production,
      List<String>? casts,
      List<String>? tags,
      String? provider});
}

/// @nodoc
class __$MovieCopyWithImpl<$Res> implements _$MovieCopyWith<$Res> {
  __$MovieCopyWithImpl(this._self, this._then);

  final _Movie _self;
  final $Res Function(_Movie) _then;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? poster = freezed,
    Object? cover = freezed,
    Object? description = freezed,
    Object? rating = freezed,
    Object? releaseDate = freezed,
    Object? type = null,
    Object? episodeId = freezed,
    Object? genres = null,
    Object? totalEpisodes = freezed,
    Object? duration = freezed,
    Object? episodes = freezed,
    Object? recommendations = freezed,
    Object? country = freezed,
    Object? production = freezed,
    Object? casts = freezed,
    Object? tags = freezed,
    Object? provider = freezed,
  }) {
    return _then(_Movie(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      poster: freezed == poster
          ? _self.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: freezed == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      episodeId: freezed == episodeId
          ? _self.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalEpisodes: freezed == totalEpisodes
          ? _self.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _self._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      recommendations: freezed == recommendations
          ? _self._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      production: freezed == production
          ? _self.production
          : production // ignore: cast_nullable_to_non_nullable
              as String?,
      casts: freezed == casts
          ? _self._casts
          : casts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      provider: freezed == provider
          ? _self.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
