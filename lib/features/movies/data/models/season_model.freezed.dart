// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) {
  return _SeasonModel.fromJson(json);
}

/// @nodoc
mixin _$SeasonModel {
  @HiveField(0)
  @StringToIntConverterRequired()
  int get season => throw _privateConstructorUsedError;
  @HiveField(1)
  List<EpisodeModel> get episodes => throw _privateConstructorUsedError;

  /// Serializes this SeasonModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonModelCopyWith<SeasonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonModelCopyWith<$Res> {
  factory $SeasonModelCopyWith(
    SeasonModel value,
    $Res Function(SeasonModel) then,
  ) = _$SeasonModelCopyWithImpl<$Res, SeasonModel>;
  @useResult
  $Res call({
    @HiveField(0) @StringToIntConverterRequired() int season,
    @HiveField(1) List<EpisodeModel> episodes,
  });
}

/// @nodoc
class _$SeasonModelCopyWithImpl<$Res, $Val extends SeasonModel>
    implements $SeasonModelCopyWith<$Res> {
  _$SeasonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? season = null, Object? episodes = null}) {
    return _then(
      _value.copyWith(
        season: null == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                as int,
        episodes: null == episodes
            ? _value.episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                as List<EpisodeModel>,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeasonModelImplCopyWith<$Res>
    implements $SeasonModelCopyWith<$Res> {
  factory _$$SeasonModelImplCopyWith(
    _$SeasonModelImpl value,
    $Res Function(_$SeasonModelImpl) then,
  ) = __$$SeasonModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) @StringToIntConverterRequired() int season,
    @HiveField(1) List<EpisodeModel> episodes,
  });
}

/// @nodoc
class __$$SeasonModelImplCopyWithImpl<$Res>
    extends _$SeasonModelCopyWithImpl<$Res, _$SeasonModelImpl>
    implements _$$SeasonModelImplCopyWith<$Res> {
  __$$SeasonModelImplCopyWithImpl(
    _$SeasonModelImpl _value,
    $Res Function(_$SeasonModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? season = null, Object? episodes = null}) {
    return _then(
      _$SeasonModelImpl(
        season: null == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                as int,
        episodes: null == episodes
            ? _value._episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                as List<EpisodeModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonModelImpl implements _SeasonModel {
  const _$SeasonModelImpl({
    @HiveField(0) @StringToIntConverterRequired() required this.season,
    @HiveField(1) final List<EpisodeModel> episodes = const [],
  }) : _episodes = episodes;

  factory _$SeasonModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonModelImplFromJson(json);

  @override
  @HiveField(0)
  @StringToIntConverterRequired()
  final int season;
  final List<EpisodeModel> _episodes;
  @override
  @JsonKey()
  @HiveField(1)
  List<EpisodeModel> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'SeasonModel(season: $season, episodes: $episodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonModelImpl &&
            (identical(other.season, season) || other.season == season) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        season,
        const DeepCollectionEquality().hash(_episodes),
      );

  /// Create a copy of SeasonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonModelImplCopyWith<_$SeasonModelImpl> get copyWith =>
      __$$SeasonModelImplCopyWithImpl<_$SeasonModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonModelImplToJson(this);
  }
}

abstract class _SeasonModel implements SeasonModel {
  const factory _SeasonModel({
    @HiveField(0) @StringToIntConverterRequired() required final int season,
    @HiveField(1) final List<EpisodeModel> episodes,
  }) = _$SeasonModelImpl;

  factory _SeasonModel.fromJson(Map<String, dynamic> json) =
      _$SeasonModelImpl.fromJson;

  @override
  @HiveField(0)
  @StringToIntConverterRequired()
  int get season;
  @override
  @HiveField(1)
  List<EpisodeModel> get episodes;

  /// Create a copy of SeasonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonModelImplCopyWith<_$SeasonModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
