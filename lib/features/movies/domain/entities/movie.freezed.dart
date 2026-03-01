// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Movie {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get poster => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get releaseDate => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'Movie' or 'TV Series'
  String? get episodeId => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  int? get totalEpisodes => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  List<Episode>? get episodes => throw _privateConstructorUsedError;
  List<Movie>? get recommendations => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get production => throw _privateConstructorUsedError;
  List<String>? get casts => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
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
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      episodeId: freezed == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalEpisodes: freezed == totalEpisodes
          ? _value.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      recommendations: freezed == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      production: freezed == production
          ? _value.production
          : production // ignore: cast_nullable_to_non_nullable
              as String?,
      casts: freezed == casts
          ? _value.casts
          : casts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieImplCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$MovieImplCopyWith(
          _$MovieImpl value, $Res Function(_$MovieImpl) then) =
      __$$MovieImplCopyWithImpl<$Res>;
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
class __$$MovieImplCopyWithImpl<$Res>
    extends _$MovieCopyWithImpl<$Res, _$MovieImpl>
    implements _$$MovieImplCopyWith<$Res> {
  __$$MovieImplCopyWithImpl(
      _$MovieImpl _value, $Res Function(_$MovieImpl) _then)
      : super(_value, _then);

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
    return _then(_$MovieImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      poster: freezed == poster
          ? _value.poster
          : poster // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      episodeId: freezed == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalEpisodes: freezed == totalEpisodes
          ? _value.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      recommendations: freezed == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      production: freezed == production
          ? _value.production
          : production // ignore: cast_nullable_to_non_nullable
              as String?,
      casts: freezed == casts
          ? _value._casts
          : casts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MovieImpl implements _Movie {
  const _$MovieImpl(
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

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImpl &&
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

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      __$$MovieImplCopyWithImpl<_$MovieImpl>(this, _$identity);
}

abstract class _Movie implements Movie {
  const factory _Movie(
      {required final String id,
      required final String title,
      final String? poster,
      final String? cover,
      final String? description,
      final double? rating,
      final String? releaseDate,
      required final String type,
      final String? episodeId,
      final List<String> genres,
      final int? totalEpisodes,
      final String? duration,
      final List<Episode>? episodes,
      final List<Movie>? recommendations,
      final String? country,
      final String? production,
      final List<String>? casts,
      final List<String>? tags,
      final String? provider}) = _$MovieImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get poster;
  @override
  String? get cover;
  @override
  String? get description;
  @override
  double? get rating;
  @override
  String? get releaseDate;
  @override
  String get type; // 'Movie' or 'TV Series'
  @override
  String? get episodeId;
  @override
  List<String> get genres;
  @override
  int? get totalEpisodes;
  @override
  String? get duration;
  @override
  List<Episode>? get episodes;
  @override
  List<Movie>? get recommendations;
  @override
  String? get country;
  @override
  String? get production;
  @override
  List<String>? get casts;
  @override
  List<String>? get tags;
  @override
  String? get provider;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
