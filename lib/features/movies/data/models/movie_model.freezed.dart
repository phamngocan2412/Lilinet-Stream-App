// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MovieModel {

@HiveField(0)@AnyToStringConverter() String get id;@HiveField(1) String get title;@HiveField(2)@AnyToStringNullableConverter() String? get poster;@HiveField(3)@AnyToStringNullableConverter() String? get cover;@HiveField(4)@AnyToStringNullableConverter() String? get description;@HiveField(5)@StringToDoubleConverter() double? get rating;@HiveField(6)@AnyToStringNullableConverter() String? get releaseDate;@HiveField(7) String get type;@HiveField(8)@AnyToStringNullableConverter() String? get episodeId;@HiveField(9) List<String> get genres;@HiveField(10)@StringToIntConverter() int? get totalEpisodes;@HiveField(11)@AnyToStringNullableConverter() String? get duration;@HiveField(12) List<EpisodeModel>? get episodes;@HiveField(13) List<SeasonModel>? get seasons;@HiveField(14) List<MovieModel>? get recommendations;@HiveField(15)@AnyToStringNullableConverter() String? get country;@HiveField(16)@AnyToStringNullableConverter() String? get production;@HiveField(17) List<String>? get casts;@HiveField(18) List<String>? get tags;@HiveField(19)@AnyToStringNullableConverter() String? get image;
/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieModelCopyWith<MovieModel> get copyWith => _$MovieModelCopyWithImpl<MovieModel>(this as MovieModel, _$identity);

  /// Serializes this MovieModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.type, type) || other.type == type)&&(identical(other.episodeId, episodeId) || other.episodeId == episodeId)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.totalEpisodes, totalEpisodes) || other.totalEpisodes == totalEpisodes)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.episodes, episodes)&&const DeepCollectionEquality().equals(other.seasons, seasons)&&const DeepCollectionEquality().equals(other.recommendations, recommendations)&&(identical(other.country, country) || other.country == country)&&(identical(other.production, production) || other.production == production)&&const DeepCollectionEquality().equals(other.casts, casts)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,poster,cover,description,rating,releaseDate,type,episodeId,const DeepCollectionEquality().hash(genres),totalEpisodes,duration,const DeepCollectionEquality().hash(episodes),const DeepCollectionEquality().hash(seasons),const DeepCollectionEquality().hash(recommendations),country,production,const DeepCollectionEquality().hash(casts),const DeepCollectionEquality().hash(tags),image]);

@override
String toString() {
  return 'MovieModel(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, seasons: $seasons, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, image: $image)';
}


}

/// @nodoc
abstract mixin class $MovieModelCopyWith<$Res>  {
  factory $MovieModelCopyWith(MovieModel value, $Res Function(MovieModel) _then) = _$MovieModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String id,@HiveField(1) String title,@HiveField(2)@AnyToStringNullableConverter() String? poster,@HiveField(3)@AnyToStringNullableConverter() String? cover,@HiveField(4)@AnyToStringNullableConverter() String? description,@HiveField(5)@StringToDoubleConverter() double? rating,@HiveField(6)@AnyToStringNullableConverter() String? releaseDate,@HiveField(7) String type,@HiveField(8)@AnyToStringNullableConverter() String? episodeId,@HiveField(9) List<String> genres,@HiveField(10)@StringToIntConverter() int? totalEpisodes,@HiveField(11)@AnyToStringNullableConverter() String? duration,@HiveField(12) List<EpisodeModel>? episodes,@HiveField(13) List<SeasonModel>? seasons,@HiveField(14) List<MovieModel>? recommendations,@HiveField(15)@AnyToStringNullableConverter() String? country,@HiveField(16)@AnyToStringNullableConverter() String? production,@HiveField(17) List<String>? casts,@HiveField(18) List<String>? tags,@HiveField(19)@AnyToStringNullableConverter() String? image
});




}
/// @nodoc
class _$MovieModelCopyWithImpl<$Res>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._self, this._then);

  final MovieModel _self;
  final $Res Function(MovieModel) _then;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? poster = freezed,Object? cover = freezed,Object? description = freezed,Object? rating = freezed,Object? releaseDate = freezed,Object? type = null,Object? episodeId = freezed,Object? genres = null,Object? totalEpisodes = freezed,Object? duration = freezed,Object? episodes = freezed,Object? seasons = freezed,Object? recommendations = freezed,Object? country = freezed,Object? production = freezed,Object? casts = freezed,Object? tags = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,episodeId: freezed == episodeId ? _self.episodeId : episodeId // ignore: cast_nullable_to_non_nullable
as String?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,totalEpisodes: freezed == totalEpisodes ? _self.totalEpisodes : totalEpisodes // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,episodes: freezed == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<EpisodeModel>?,seasons: freezed == seasons ? _self.seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonModel>?,recommendations: freezed == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<MovieModel>?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,production: freezed == production ? _self.production : production // ignore: cast_nullable_to_non_nullable
as String?,casts: freezed == casts ? _self.casts : casts // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieModel].
extension MovieModelPatterns on MovieModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieModel value)  $default,){
final _that = this;
switch (_that) {
case _MovieModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieModel value)?  $default,){
final _that = this;
switch (_that) {
case _MovieModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? poster, @HiveField(3)@AnyToStringNullableConverter()  String? cover, @HiveField(4)@AnyToStringNullableConverter()  String? description, @HiveField(5)@StringToDoubleConverter()  double? rating, @HiveField(6)@AnyToStringNullableConverter()  String? releaseDate, @HiveField(7)  String type, @HiveField(8)@AnyToStringNullableConverter()  String? episodeId, @HiveField(9)  List<String> genres, @HiveField(10)@StringToIntConverter()  int? totalEpisodes, @HiveField(11)@AnyToStringNullableConverter()  String? duration, @HiveField(12)  List<EpisodeModel>? episodes, @HiveField(13)  List<SeasonModel>? seasons, @HiveField(14)  List<MovieModel>? recommendations, @HiveField(15)@AnyToStringNullableConverter()  String? country, @HiveField(16)@AnyToStringNullableConverter()  String? production, @HiveField(17)  List<String>? casts, @HiveField(18)  List<String>? tags, @HiveField(19)@AnyToStringNullableConverter()  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieModel() when $default != null:
return $default(_that.id,_that.title,_that.poster,_that.cover,_that.description,_that.rating,_that.releaseDate,_that.type,_that.episodeId,_that.genres,_that.totalEpisodes,_that.duration,_that.episodes,_that.seasons,_that.recommendations,_that.country,_that.production,_that.casts,_that.tags,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? poster, @HiveField(3)@AnyToStringNullableConverter()  String? cover, @HiveField(4)@AnyToStringNullableConverter()  String? description, @HiveField(5)@StringToDoubleConverter()  double? rating, @HiveField(6)@AnyToStringNullableConverter()  String? releaseDate, @HiveField(7)  String type, @HiveField(8)@AnyToStringNullableConverter()  String? episodeId, @HiveField(9)  List<String> genres, @HiveField(10)@StringToIntConverter()  int? totalEpisodes, @HiveField(11)@AnyToStringNullableConverter()  String? duration, @HiveField(12)  List<EpisodeModel>? episodes, @HiveField(13)  List<SeasonModel>? seasons, @HiveField(14)  List<MovieModel>? recommendations, @HiveField(15)@AnyToStringNullableConverter()  String? country, @HiveField(16)@AnyToStringNullableConverter()  String? production, @HiveField(17)  List<String>? casts, @HiveField(18)  List<String>? tags, @HiveField(19)@AnyToStringNullableConverter()  String? image)  $default,) {final _that = this;
switch (_that) {
case _MovieModel():
return $default(_that.id,_that.title,_that.poster,_that.cover,_that.description,_that.rating,_that.releaseDate,_that.type,_that.episodeId,_that.genres,_that.totalEpisodes,_that.duration,_that.episodes,_that.seasons,_that.recommendations,_that.country,_that.production,_that.casts,_that.tags,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@AnyToStringConverter()  String id, @HiveField(1)  String title, @HiveField(2)@AnyToStringNullableConverter()  String? poster, @HiveField(3)@AnyToStringNullableConverter()  String? cover, @HiveField(4)@AnyToStringNullableConverter()  String? description, @HiveField(5)@StringToDoubleConverter()  double? rating, @HiveField(6)@AnyToStringNullableConverter()  String? releaseDate, @HiveField(7)  String type, @HiveField(8)@AnyToStringNullableConverter()  String? episodeId, @HiveField(9)  List<String> genres, @HiveField(10)@StringToIntConverter()  int? totalEpisodes, @HiveField(11)@AnyToStringNullableConverter()  String? duration, @HiveField(12)  List<EpisodeModel>? episodes, @HiveField(13)  List<SeasonModel>? seasons, @HiveField(14)  List<MovieModel>? recommendations, @HiveField(15)@AnyToStringNullableConverter()  String? country, @HiveField(16)@AnyToStringNullableConverter()  String? production, @HiveField(17)  List<String>? casts, @HiveField(18)  List<String>? tags, @HiveField(19)@AnyToStringNullableConverter()  String? image)?  $default,) {final _that = this;
switch (_that) {
case _MovieModel() when $default != null:
return $default(_that.id,_that.title,_that.poster,_that.cover,_that.description,_that.rating,_that.releaseDate,_that.type,_that.episodeId,_that.genres,_that.totalEpisodes,_that.duration,_that.episodes,_that.seasons,_that.recommendations,_that.country,_that.production,_that.casts,_that.tags,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovieModel extends MovieModel {
  const _MovieModel({@HiveField(0)@AnyToStringConverter() required this.id, @HiveField(1) required this.title, @HiveField(2)@AnyToStringNullableConverter() this.poster, @HiveField(3)@AnyToStringNullableConverter() this.cover, @HiveField(4)@AnyToStringNullableConverter() this.description, @HiveField(5)@StringToDoubleConverter() this.rating, @HiveField(6)@AnyToStringNullableConverter() this.releaseDate, @HiveField(7) required this.type, @HiveField(8)@AnyToStringNullableConverter() this.episodeId, @HiveField(9) final  List<String> genres = const [], @HiveField(10)@StringToIntConverter() this.totalEpisodes, @HiveField(11)@AnyToStringNullableConverter() this.duration, @HiveField(12) final  List<EpisodeModel>? episodes, @HiveField(13) final  List<SeasonModel>? seasons, @HiveField(14) final  List<MovieModel>? recommendations, @HiveField(15)@AnyToStringNullableConverter() this.country, @HiveField(16)@AnyToStringNullableConverter() this.production, @HiveField(17) final  List<String>? casts, @HiveField(18) final  List<String>? tags, @HiveField(19)@AnyToStringNullableConverter() this.image}): _genres = genres,_episodes = episodes,_seasons = seasons,_recommendations = recommendations,_casts = casts,_tags = tags,super._();
  factory _MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

@override@HiveField(0)@AnyToStringConverter() final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2)@AnyToStringNullableConverter() final  String? poster;
@override@HiveField(3)@AnyToStringNullableConverter() final  String? cover;
@override@HiveField(4)@AnyToStringNullableConverter() final  String? description;
@override@HiveField(5)@StringToDoubleConverter() final  double? rating;
@override@HiveField(6)@AnyToStringNullableConverter() final  String? releaseDate;
@override@HiveField(7) final  String type;
@override@HiveField(8)@AnyToStringNullableConverter() final  String? episodeId;
 final  List<String> _genres;
@override@JsonKey()@HiveField(9) List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override@HiveField(10)@StringToIntConverter() final  int? totalEpisodes;
@override@HiveField(11)@AnyToStringNullableConverter() final  String? duration;
 final  List<EpisodeModel>? _episodes;
@override@HiveField(12) List<EpisodeModel>? get episodes {
  final value = _episodes;
  if (value == null) return null;
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<SeasonModel>? _seasons;
@override@HiveField(13) List<SeasonModel>? get seasons {
  final value = _seasons;
  if (value == null) return null;
  if (_seasons is EqualUnmodifiableListView) return _seasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<MovieModel>? _recommendations;
@override@HiveField(14) List<MovieModel>? get recommendations {
  final value = _recommendations;
  if (value == null) return null;
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(15)@AnyToStringNullableConverter() final  String? country;
@override@HiveField(16)@AnyToStringNullableConverter() final  String? production;
 final  List<String>? _casts;
@override@HiveField(17) List<String>? get casts {
  final value = _casts;
  if (value == null) return null;
  if (_casts is EqualUnmodifiableListView) return _casts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tags;
@override@HiveField(18) List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(19)@AnyToStringNullableConverter() final  String? image;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieModelCopyWith<_MovieModel> get copyWith => __$MovieModelCopyWithImpl<_MovieModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovieModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.type, type) || other.type == type)&&(identical(other.episodeId, episodeId) || other.episodeId == episodeId)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.totalEpisodes, totalEpisodes) || other.totalEpisodes == totalEpisodes)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._episodes, _episodes)&&const DeepCollectionEquality().equals(other._seasons, _seasons)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations)&&(identical(other.country, country) || other.country == country)&&(identical(other.production, production) || other.production == production)&&const DeepCollectionEquality().equals(other._casts, _casts)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,poster,cover,description,rating,releaseDate,type,episodeId,const DeepCollectionEquality().hash(_genres),totalEpisodes,duration,const DeepCollectionEquality().hash(_episodes),const DeepCollectionEquality().hash(_seasons),const DeepCollectionEquality().hash(_recommendations),country,production,const DeepCollectionEquality().hash(_casts),const DeepCollectionEquality().hash(_tags),image]);

@override
String toString() {
  return 'MovieModel(id: $id, title: $title, poster: $poster, cover: $cover, description: $description, rating: $rating, releaseDate: $releaseDate, type: $type, episodeId: $episodeId, genres: $genres, totalEpisodes: $totalEpisodes, duration: $duration, episodes: $episodes, seasons: $seasons, recommendations: $recommendations, country: $country, production: $production, casts: $casts, tags: $tags, image: $image)';
}


}

/// @nodoc
abstract mixin class _$MovieModelCopyWith<$Res> implements $MovieModelCopyWith<$Res> {
  factory _$MovieModelCopyWith(_MovieModel value, $Res Function(_MovieModel) _then) = __$MovieModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@AnyToStringConverter() String id,@HiveField(1) String title,@HiveField(2)@AnyToStringNullableConverter() String? poster,@HiveField(3)@AnyToStringNullableConverter() String? cover,@HiveField(4)@AnyToStringNullableConverter() String? description,@HiveField(5)@StringToDoubleConverter() double? rating,@HiveField(6)@AnyToStringNullableConverter() String? releaseDate,@HiveField(7) String type,@HiveField(8)@AnyToStringNullableConverter() String? episodeId,@HiveField(9) List<String> genres,@HiveField(10)@StringToIntConverter() int? totalEpisodes,@HiveField(11)@AnyToStringNullableConverter() String? duration,@HiveField(12) List<EpisodeModel>? episodes,@HiveField(13) List<SeasonModel>? seasons,@HiveField(14) List<MovieModel>? recommendations,@HiveField(15)@AnyToStringNullableConverter() String? country,@HiveField(16)@AnyToStringNullableConverter() String? production,@HiveField(17) List<String>? casts,@HiveField(18) List<String>? tags,@HiveField(19)@AnyToStringNullableConverter() String? image
});




}
/// @nodoc
class __$MovieModelCopyWithImpl<$Res>
    implements _$MovieModelCopyWith<$Res> {
  __$MovieModelCopyWithImpl(this._self, this._then);

  final _MovieModel _self;
  final $Res Function(_MovieModel) _then;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? poster = freezed,Object? cover = freezed,Object? description = freezed,Object? rating = freezed,Object? releaseDate = freezed,Object? type = null,Object? episodeId = freezed,Object? genres = null,Object? totalEpisodes = freezed,Object? duration = freezed,Object? episodes = freezed,Object? seasons = freezed,Object? recommendations = freezed,Object? country = freezed,Object? production = freezed,Object? casts = freezed,Object? tags = freezed,Object? image = freezed,}) {
  return _then(_MovieModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,episodeId: freezed == episodeId ? _self.episodeId : episodeId // ignore: cast_nullable_to_non_nullable
as String?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,totalEpisodes: freezed == totalEpisodes ? _self.totalEpisodes : totalEpisodes // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,episodes: freezed == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<EpisodeModel>?,seasons: freezed == seasons ? _self._seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonModel>?,recommendations: freezed == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<MovieModel>?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,production: freezed == production ? _self.production : production // ignore: cast_nullable_to_non_nullable
as String?,casts: freezed == casts ? _self._casts : casts // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MovieListResponse {

@HiveField(0)@StringToIntConverterRequired() int get currentPage;@HiveField(1) bool get hasNextPage;@HiveField(2) List<MovieModel> get results;
/// Create a copy of MovieListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieListResponseCopyWith<MovieListResponse> get copyWith => _$MovieListResponseCopyWithImpl<MovieListResponse>(this as MovieListResponse, _$identity);

  /// Serializes this MovieListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieListResponse&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,hasNextPage,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'MovieListResponse(currentPage: $currentPage, hasNextPage: $hasNextPage, results: $results)';
}


}

/// @nodoc
abstract mixin class $MovieListResponseCopyWith<$Res>  {
  factory $MovieListResponseCopyWith(MovieListResponse value, $Res Function(MovieListResponse) _then) = _$MovieListResponseCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@StringToIntConverterRequired() int currentPage,@HiveField(1) bool hasNextPage,@HiveField(2) List<MovieModel> results
});




}
/// @nodoc
class _$MovieListResponseCopyWithImpl<$Res>
    implements $MovieListResponseCopyWith<$Res> {
  _$MovieListResponseCopyWithImpl(this._self, this._then);

  final MovieListResponse _self;
  final $Res Function(MovieListResponse) _then;

/// Create a copy of MovieListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? hasNextPage = null,Object? results = null,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<MovieModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieListResponse].
extension MovieListResponsePatterns on MovieListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieListResponse value)  $default,){
final _that = this;
switch (_that) {
case _MovieListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MovieListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@StringToIntConverterRequired()  int currentPage, @HiveField(1)  bool hasNextPage, @HiveField(2)  List<MovieModel> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieListResponse() when $default != null:
return $default(_that.currentPage,_that.hasNextPage,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@StringToIntConverterRequired()  int currentPage, @HiveField(1)  bool hasNextPage, @HiveField(2)  List<MovieModel> results)  $default,) {final _that = this;
switch (_that) {
case _MovieListResponse():
return $default(_that.currentPage,_that.hasNextPage,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@StringToIntConverterRequired()  int currentPage, @HiveField(1)  bool hasNextPage, @HiveField(2)  List<MovieModel> results)?  $default,) {final _that = this;
switch (_that) {
case _MovieListResponse() when $default != null:
return $default(_that.currentPage,_that.hasNextPage,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovieListResponse implements MovieListResponse {
  const _MovieListResponse({@HiveField(0)@StringToIntConverterRequired() this.currentPage = 1, @HiveField(1) this.hasNextPage = false, @HiveField(2) required final  List<MovieModel> results}): _results = results;
  factory _MovieListResponse.fromJson(Map<String, dynamic> json) => _$MovieListResponseFromJson(json);

@override@JsonKey()@HiveField(0)@StringToIntConverterRequired() final  int currentPage;
@override@JsonKey()@HiveField(1) final  bool hasNextPage;
 final  List<MovieModel> _results;
@override@HiveField(2) List<MovieModel> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of MovieListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieListResponseCopyWith<_MovieListResponse> get copyWith => __$MovieListResponseCopyWithImpl<_MovieListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovieListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieListResponse&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,hasNextPage,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'MovieListResponse(currentPage: $currentPage, hasNextPage: $hasNextPage, results: $results)';
}


}

/// @nodoc
abstract mixin class _$MovieListResponseCopyWith<$Res> implements $MovieListResponseCopyWith<$Res> {
  factory _$MovieListResponseCopyWith(_MovieListResponse value, $Res Function(_MovieListResponse) _then) = __$MovieListResponseCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@StringToIntConverterRequired() int currentPage,@HiveField(1) bool hasNextPage,@HiveField(2) List<MovieModel> results
});




}
/// @nodoc
class __$MovieListResponseCopyWithImpl<$Res>
    implements _$MovieListResponseCopyWith<$Res> {
  __$MovieListResponseCopyWithImpl(this._self, this._then);

  final _MovieListResponse _self;
  final $Res Function(_MovieListResponse) _then;

/// Create a copy of MovieListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? hasNextPage = null,Object? results = null,}) {
  return _then(_MovieListResponse(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<MovieModel>,
  ));
}


}

// dart format on
