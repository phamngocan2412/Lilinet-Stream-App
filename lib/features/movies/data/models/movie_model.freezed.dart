// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
mixin _$MovieModel {
  @HiveField(0)
  @AnyToStringConverter()
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  @AnyToStringNullableConverter()
  String? get poster => throw _privateConstructorUsedError;
  @HiveField(3)
  @AnyToStringNullableConverter()
  String? get cover => throw _privateConstructorUsedError;
  @HiveField(4)
  @AnyToStringNullableConverter()
  String? get description => throw _privateConstructorUsedError;
  @HiveField(5)
  @StringToDoubleConverter()
  double? get rating => throw _privateConstructorUsedError;
  @HiveField(6)
  @AnyToStringNullableConverter()
  String? get releaseDate => throw _privateConstructorUsedError;
  @HiveField(7)
  String get type => throw _privateConstructorUsedError;
  @HiveField(8)
  @AnyToStringNullableConverter()
  String? get episodeId => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String> get genres => throw _privateConstructorUsedError;
  @HiveField(10)
  @StringToIntConverter()
  int? get totalEpisodes => throw _privateConstructorUsedError;
  @HiveField(11)
  @AnyToStringNullableConverter()
  String? get duration => throw _privateConstructorUsedError;
  @HiveField(12)
  List<EpisodeModel>? get episodes => throw _privateConstructorUsedError;
  @HiveField(13)
  List<SeasonModel>? get seasons => throw _privateConstructorUsedError;
  @HiveField(14)
  List<MovieModel>? get recommendations => throw _privateConstructorUsedError;
  @HiveField(15)
  @AnyToStringNullableConverter()
  String? get country => throw _privateConstructorUsedError;
  @HiveField(16)
  @AnyToStringNullableConverter()
  String? get production => throw _privateConstructorUsedError;
  @HiveField(17)
  List<String>? get casts => throw _privateConstructorUsedError;
  @HiveField(18)
  List<String>? get tags => throw _privateConstructorUsedError;
  @HiveField(19)
  @AnyToStringNullableConverter()
  String? get image => throw _privateConstructorUsedError;
  @HiveField(20)
  @AnyToStringNullableConverter()
  String? get provider => throw _privateConstructorUsedError;

  /// Serializes this MovieModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
    MovieModel value,
    $Res Function(MovieModel) then,
  ) = _$MovieModelCopyWithImpl<$Res, MovieModel>;
  @useResult
  $Res call({
    @HiveField(0) @AnyToStringConverter() String id,
    @HiveField(1) String title,
    @HiveField(2) @AnyToStringNullableConverter() String? poster,
    @HiveField(3) @AnyToStringNullableConverter() String? cover,
    @HiveField(4) @AnyToStringNullableConverter() String? description,
    @HiveField(5) @StringToDoubleConverter() double? rating,
    @HiveField(6) @AnyToStringNullableConverter() String? releaseDate,
    @HiveField(7) String type,
    @HiveField(8) @AnyToStringNullableConverter() String? episodeId,
    @HiveField(9) List<String> genres,
    @HiveField(10) @StringToIntConverter() int? totalEpisodes,
    @HiveField(11) @AnyToStringNullableConverter() String? duration,
    @HiveField(12) List<EpisodeModel>? episodes,
    @HiveField(13) List<SeasonModel>? seasons,
    @HiveField(14) List<MovieModel>? recommendations,
    @HiveField(15) @AnyToStringNullableConverter() String? country,
    @HiveField(16) @AnyToStringNullableConverter() String? production,
    @HiveField(17) List<String>? casts,
    @HiveField(18) List<String>? tags,
    @HiveField(19) @AnyToStringNullableConverter() String? image,
    @HiveField(20) @AnyToStringNullableConverter() String? provider,
  });
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res, $Val extends MovieModel>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieModel
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
    Object? seasons = freezed,
    Object? recommendations = freezed,
    Object? country = freezed,
    Object? production = freezed,
    Object? casts = freezed,
    Object? tags = freezed,
    Object? image = freezed,
    Object? provider = freezed,
  }) {
    return _then(
      _value.copyWith(
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
                      as List<EpisodeModel>?,
            seasons: freezed == seasons
                ? _value.seasons
                : seasons // ignore: cast_nullable_to_non_nullable
                      as List<SeasonModel>?,
            recommendations: freezed == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<MovieModel>?,
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
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            provider: freezed == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieModelImplCopyWith<$Res>
    implements $MovieModelCopyWith<$Res> {
  factory _$$MovieModelImplCopyWith(
    _$MovieModelImpl value,
    $Res Function(_$MovieModelImpl) then,
  ) = __$$MovieModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) @AnyToStringConverter() String id,
    @HiveField(1) String title,
    @HiveField(2) @AnyToStringNullableConverter() String? poster,
    @HiveField(3) @AnyToStringNullableConverter() String? cover,
    @HiveField(4) @AnyToStringNullableConverter() String? description,
    @HiveField(5) @StringToDoubleConverter() double? rating,
    @HiveField(6) @AnyToStringNullableConverter() String? releaseDate,
    @HiveField(7) String type,
    @HiveField(8) @AnyToStringNullableConverter() String? episodeId,
    @HiveField(9) List<String> genres,
    @HiveField(10) @StringToIntConverter() int? totalEpisodes,
    @HiveField(11) @AnyToStringNullableConverter() String? duration,
    @HiveField(12) List<EpisodeModel>? episodes,
    @HiveField(13) List<SeasonModel>? seasons,
    @HiveField(14) List<MovieModel>? recommendations,
    @HiveField(15) @AnyToStringNullableConverter() String? country,
    @HiveField(16) @AnyToStringNullableConverter() String? production,
    @HiveField(17) List<String>? casts,
    @HiveField(18) List<String>? tags,
    @HiveField(19) @AnyToStringNullableConverter() String? image,
    @HiveField(20) @AnyToStringNullableConverter() String? provider,
  });
}

/// @nodoc
class __$$MovieModelImplCopyWithImpl<$Res>
    extends _$MovieModelCopyWithImpl<$Res, _$MovieModelImpl>
    implements _$$MovieModelImplCopyWith<$Res> {
  __$$MovieModelImplCopyWithImpl(
    _$MovieModelImpl _value,
    $Res Function(_$MovieModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieModel
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
    Object? seasons = freezed,
    Object? recommendations = freezed,
    Object? country = freezed,
    Object? production = freezed,
    Object? casts = freezed,
    Object? tags = freezed,
    Object? image = freezed,
    Object? provider = freezed,
  }) {
    return _then(
      _$MovieModelImpl(
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
                  as List<EpisodeModel>?,
        seasons: freezed == seasons
            ? _value._seasons
            : seasons // ignore: cast_nullable_to_non_nullable
                  as List<SeasonModel>?,
        recommendations: freezed == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<MovieModel>?,
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
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        provider: freezed == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieModelImpl extends _MovieModel {
  const _$MovieModelImpl({
    @HiveField(0) @AnyToStringConverter() required this.id,
    @HiveField(1) required this.title,
    @HiveField(2) @AnyToStringNullableConverter() this.poster,
    @HiveField(3) @AnyToStringNullableConverter() this.cover,
    @HiveField(4) @AnyToStringNullableConverter() this.description,
    @HiveField(5) @StringToDoubleConverter() this.rating,
    @HiveField(6) @AnyToStringNullableConverter() this.releaseDate,
    @HiveField(7) required this.type,
    @HiveField(8) @AnyToStringNullableConverter() this.episodeId,
    @HiveField(9) final List<String> genres = const [],
    @HiveField(10) @StringToIntConverter() this.totalEpisodes,
    @HiveField(11) @AnyToStringNullableConverter() this.duration,
    @HiveField(12) final List<EpisodeModel>? episodes,
    @HiveField(13) final List<SeasonModel>? seasons,
    @HiveField(14) final List<MovieModel>? recommendations,
    @HiveField(15) @AnyToStringNullableConverter() this.country,
    @HiveField(16) @AnyToStringNullableConverter() this.production,
    @HiveField(17) final List<String>? casts,
    @HiveField(18) final List<String>? tags,
    @HiveField(19) @AnyToStringNullableConverter() this.image,
    @HiveField(20) @AnyToStringNullableConverter() this.provider,
  }) : _genres = genres,
       _episodes = episodes,
       _seasons = seasons,
       _recommendations = recommendations,
       _casts = casts,
       _tags = tags,
       super._();

  factory _$MovieModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieModelImplFromJson(json);

  @override
  @HiveField(0)
  @AnyToStringConverter()
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  @AnyToStringNullableConverter()
  final String? poster;
  @override
  @HiveField(3)
  @AnyToStringNullableConverter()
  final String? cover;
  @override
  @HiveField(4)
  @AnyToStringNullableConverter()
  final String? description;
  @override
  @HiveField(5)
  @StringToDoubleConverter()
  final double? rating;
  @override
  @HiveField(6)
  @AnyToStringNullableConverter()
  final String? releaseDate;
  @override
  @HiveField(7)
  final String type;
  @override
  @HiveField(8)
  @AnyToStringNullableConverter()
  final String? episodeId;
  final List<String> _genres;
  @override
  @JsonKey()
  @HiveField(9)
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  @HiveField(10)
  @StringToIntConverter()
  final int? totalEpisodes;
  @override
  @HiveField(11)
  @AnyToStringNullableConverter()
  final String? duration;
  final List<EpisodeModel>? _episodes;
  @override
  @HiveField(12)
  List<EpisodeModel>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SeasonModel>? _seasons;
  @override
  @HiveField(13)
  List<SeasonModel>? get seasons {
    final value = _seasons;
    if (value == null) return null;
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MovieModel>? _recommendations;
  @override
  @HiveField(14)
  List<MovieModel>? get recommendations {
    final value = _recommendations;
    if (value == null) return null;
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(15)
  @AnyToStringNullableConverter()
  final String? country;
  @override
  @HiveField(16)
  @AnyToStringNullableConverter()
  final String? production;
  final List<String>? _casts;
  @override
  @HiveField(17)
  List<String>? get casts {
    final value = _casts;
    if (value == null) return null;
    if (_casts is EqualUnmodifiableListView) return _casts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  @HiveField(18)
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(19)
  @AnyToStringNullableConverter()
  final String? image;
  @override
  @HiveField(20)
  @AnyToStringNullableConverter()
  final String? provider;

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, seasons: $seasons, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, image: $image, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieModelImpl &&
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
            const DeepCollectionEquality().equals(other._seasons, _seasons) &&
            const DeepCollectionEquality().equals(
              other._recommendations,
              _recommendations,
            ) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.production, production) ||
                other.production == production) &&
            const DeepCollectionEquality().equals(other._casts, _casts) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    const DeepCollectionEquality().hash(_seasons),
    const DeepCollectionEquality().hash(_recommendations),
    country,
    production,
    const DeepCollectionEquality().hash(_casts),
    const DeepCollectionEquality().hash(_tags),
    image,
    provider,
  ]);

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      __$$MovieModelImplCopyWithImpl<_$MovieModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieModelImplToJson(this);
  }
}

abstract class _MovieModel extends MovieModel {
  const factory _MovieModel({
    @HiveField(0) @AnyToStringConverter() required final String id,
    @HiveField(1) required final String title,
    @HiveField(2) @AnyToStringNullableConverter() final String? poster,
    @HiveField(3) @AnyToStringNullableConverter() final String? cover,
    @HiveField(4) @AnyToStringNullableConverter() final String? description,
    @HiveField(5) @StringToDoubleConverter() final double? rating,
    @HiveField(6) @AnyToStringNullableConverter() final String? releaseDate,
    @HiveField(7) required final String type,
    @HiveField(8) @AnyToStringNullableConverter() final String? episodeId,
    @HiveField(9) final List<String> genres,
    @HiveField(10) @StringToIntConverter() final int? totalEpisodes,
    @HiveField(11) @AnyToStringNullableConverter() final String? duration,
    @HiveField(12) final List<EpisodeModel>? episodes,
    @HiveField(13) final List<SeasonModel>? seasons,
    @HiveField(14) final List<MovieModel>? recommendations,
    @HiveField(15) @AnyToStringNullableConverter() final String? country,
    @HiveField(16) @AnyToStringNullableConverter() final String? production,
    @HiveField(17) final List<String>? casts,
    @HiveField(18) final List<String>? tags,
    @HiveField(19) @AnyToStringNullableConverter() final String? image,
    @HiveField(20) @AnyToStringNullableConverter() final String? provider,
  }) = _$MovieModelImpl;
  const _MovieModel._() : super._();

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$MovieModelImpl.fromJson;

  @override
  @HiveField(0)
  @AnyToStringConverter()
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  @AnyToStringNullableConverter()
  String? get poster;
  @override
  @HiveField(3)
  @AnyToStringNullableConverter()
  String? get cover;
  @override
  @HiveField(4)
  @AnyToStringNullableConverter()
  String? get description;
  @override
  @HiveField(5)
  @StringToDoubleConverter()
  double? get rating;
  @override
  @HiveField(6)
  @AnyToStringNullableConverter()
  String? get releaseDate;
  @override
  @HiveField(7)
  String get type;
  @override
  @HiveField(8)
  @AnyToStringNullableConverter()
  String? get episodeId;
  @override
  @HiveField(9)
  List<String> get genres;
  @override
  @HiveField(10)
  @StringToIntConverter()
  int? get totalEpisodes;
  @override
  @HiveField(11)
  @AnyToStringNullableConverter()
  String? get duration;
  @override
  @HiveField(12)
  List<EpisodeModel>? get episodes;
  @override
  @HiveField(13)
  List<SeasonModel>? get seasons;
  @override
  @HiveField(14)
  List<MovieModel>? get recommendations;
  @override
  @HiveField(15)
  @AnyToStringNullableConverter()
  String? get country;
  @override
  @HiveField(16)
  @AnyToStringNullableConverter()
  String? get production;
  @override
  @HiveField(17)
  List<String>? get casts;
  @override
  @HiveField(18)
  List<String>? get tags;
  @override
  @HiveField(19)
  @AnyToStringNullableConverter()
  String? get image;
  @override
  @HiveField(20)
  @AnyToStringNullableConverter()
  String? get provider;

  /// Create a copy of MovieModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) {
  return _MovieListResponse.fromJson(json);
}

/// @nodoc
mixin _$MovieListResponse {
  @HiveField(0)
  @StringToIntConverterRequired()
  int get currentPage => throw _privateConstructorUsedError;
  @HiveField(1)
  bool get hasNextPage => throw _privateConstructorUsedError;
  @HiveField(2)
  List<MovieModel> get results => throw _privateConstructorUsedError;

  /// Serializes this MovieListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieListResponseCopyWith<MovieListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieListResponseCopyWith<$Res> {
  factory $MovieListResponseCopyWith(
    MovieListResponse value,
    $Res Function(MovieListResponse) then,
  ) = _$MovieListResponseCopyWithImpl<$Res, MovieListResponse>;
  @useResult
  $Res call({
    @HiveField(0) @StringToIntConverterRequired() int currentPage,
    @HiveField(1) bool hasNextPage,
    @HiveField(2) List<MovieModel> results,
  });
}

/// @nodoc
class _$MovieListResponseCopyWithImpl<$Res, $Val extends MovieListResponse>
    implements $MovieListResponseCopyWith<$Res> {
  _$MovieListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? hasNextPage = null,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<MovieModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MovieListResponseImplCopyWith<$Res>
    implements $MovieListResponseCopyWith<$Res> {
  factory _$$MovieListResponseImplCopyWith(
    _$MovieListResponseImpl value,
    $Res Function(_$MovieListResponseImpl) then,
  ) = __$$MovieListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) @StringToIntConverterRequired() int currentPage,
    @HiveField(1) bool hasNextPage,
    @HiveField(2) List<MovieModel> results,
  });
}

/// @nodoc
class __$$MovieListResponseImplCopyWithImpl<$Res>
    extends _$MovieListResponseCopyWithImpl<$Res, _$MovieListResponseImpl>
    implements _$$MovieListResponseImplCopyWith<$Res> {
  __$$MovieListResponseImplCopyWithImpl(
    _$MovieListResponseImpl _value,
    $Res Function(_$MovieListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? hasNextPage = null,
    Object? results = null,
  }) {
    return _then(
      _$MovieListResponseImpl(
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<MovieModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieListResponseImpl implements _MovieListResponse {
  const _$MovieListResponseImpl({
    @HiveField(0) @StringToIntConverterRequired() this.currentPage = 1,
    @HiveField(1) this.hasNextPage = false,
    @HiveField(2) required final List<MovieModel> results,
  }) : _results = results;

  factory _$MovieListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieListResponseImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  @StringToIntConverterRequired()
  final int currentPage;
  @override
  @JsonKey()
  @HiveField(1)
  final bool hasNextPage;
  final List<MovieModel> _results;
  @override
  @HiveField(2)
  List<MovieModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'MovieListResponse(currentPage: $currentPage, hasNextPage: $hasNextPage, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieListResponseImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentPage,
    hasNextPage,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of MovieListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieListResponseImplCopyWith<_$MovieListResponseImpl> get copyWith =>
      __$$MovieListResponseImplCopyWithImpl<_$MovieListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieListResponseImplToJson(this);
  }
}

abstract class _MovieListResponse implements MovieListResponse {
  const factory _MovieListResponse({
    @HiveField(0) @StringToIntConverterRequired() final int currentPage,
    @HiveField(1) final bool hasNextPage,
    @HiveField(2) required final List<MovieModel> results,
  }) = _$MovieListResponseImpl;

  factory _MovieListResponse.fromJson(Map<String, dynamic> json) =
      _$MovieListResponseImpl.fromJson;

  @override
  @HiveField(0)
  @StringToIntConverterRequired()
  int get currentPage;
  @override
  @HiveField(1)
  bool get hasNextPage;
  @override
  @HiveField(2)
  List<MovieModel> get results;

  /// Create a copy of MovieListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieListResponseImplCopyWith<_$MovieListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
