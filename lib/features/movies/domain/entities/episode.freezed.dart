// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Episode {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int? get season => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  DateTime? get releaseDate => throw _privateConstructorUsedError;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res, Episode>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    int number,
    int? season,
    String? image,
    String? url,
    DateTime? releaseDate,
  });
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            season: freezed == season
                ? _value.season
                : season // ignore: cast_nullable_to_non_nullable
                      as int?,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            releaseDate: freezed == releaseDate
                ? _value.releaseDate
                : releaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EpisodeImplCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$EpisodeImplCopyWith(
    _$EpisodeImpl value,
    $Res Function(_$EpisodeImpl) then,
  ) = __$$EpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    int number,
    int? season,
    String? image,
    String? url,
    DateTime? releaseDate,
  });
}

/// @nodoc
class __$$EpisodeImplCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$EpisodeImpl>
    implements _$$EpisodeImplCopyWith<$Res> {
  __$$EpisodeImplCopyWithImpl(
    _$EpisodeImpl _value,
    $Res Function(_$EpisodeImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$EpisodeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        season: freezed == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                  as int?,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        releaseDate: freezed == releaseDate
            ? _value.releaseDate
            : releaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$EpisodeImpl implements _Episode {
  const _$EpisodeImpl({
    required this.id,
    required this.title,
    this.description,
    required this.number,
    this.season,
    this.image,
    this.url,
    this.releaseDate,
  });

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

  @override
  String toString() {
    return 'Episode(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeImpl &&
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
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    number,
    season,
    image,
    url,
    releaseDate,
  );

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      __$$EpisodeImplCopyWithImpl<_$EpisodeImpl>(this, _$identity);
}

abstract class _Episode implements Episode {
  const factory _Episode({
    required final String id,
    required final String title,
    final String? description,
    required final int number,
    final int? season,
    final String? image,
    final String? url,
    final DateTime? releaseDate,
  }) = _$EpisodeImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get number;
  @override
  int? get season;
  @override
  String? get image;
  @override
  String? get url;
  @override
  DateTime? get releaseDate;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
