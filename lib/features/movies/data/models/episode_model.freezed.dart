// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) {
  return _EpisodeModel.fromJson(json);
}

/// @nodoc
mixin _$EpisodeModel {
  @HiveField(0)
  @AnyToStringConverter()
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  @AnyToStringNullableConverter()
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: 'episode')
  @StringToIntConverterRequired()
  int get number => throw _privateConstructorUsedError;
  @HiveField(4)
  @StringToIntConverter()
  int? get season => throw _privateConstructorUsedError;
  @HiveField(5)
  @EpisodeImageConverter()
  String? get image => throw _privateConstructorUsedError;
  @HiveField(6)
  @AnyToStringNullableConverter()
  String? get url => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get releaseDate => throw _privateConstructorUsedError;

  /// Serializes this EpisodeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeModelCopyWith<EpisodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeModelCopyWith<$Res> {
  factory $EpisodeModelCopyWith(
          EpisodeModel value, $Res Function(EpisodeModel) then) =
      _$EpisodeModelCopyWithImpl<$Res, EpisodeModel>;
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String id,
      @HiveField(1) String title,
      @HiveField(2) @AnyToStringNullableConverter() String? description,
      @HiveField(3)
      @JsonKey(name: 'episode')
      @StringToIntConverterRequired()
      int number,
      @HiveField(4) @StringToIntConverter() int? season,
      @HiveField(5) @EpisodeImageConverter() String? image,
      @HiveField(6) @AnyToStringNullableConverter() String? url,
      @HiveField(7) DateTime? releaseDate});
}

/// @nodoc
class _$EpisodeModelCopyWithImpl<$Res, $Val extends EpisodeModel>
    implements $EpisodeModelCopyWith<$Res> {
  _$EpisodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpisodeModel
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
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EpisodeModelImplCopyWith<$Res>
    implements $EpisodeModelCopyWith<$Res> {
  factory _$$EpisodeModelImplCopyWith(
          _$EpisodeModelImpl value, $Res Function(_$EpisodeModelImpl) then) =
      __$$EpisodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @AnyToStringConverter() String id,
      @HiveField(1) String title,
      @HiveField(2) @AnyToStringNullableConverter() String? description,
      @HiveField(3)
      @JsonKey(name: 'episode')
      @StringToIntConverterRequired()
      int number,
      @HiveField(4) @StringToIntConverter() int? season,
      @HiveField(5) @EpisodeImageConverter() String? image,
      @HiveField(6) @AnyToStringNullableConverter() String? url,
      @HiveField(7) DateTime? releaseDate});
}

/// @nodoc
class __$$EpisodeModelImplCopyWithImpl<$Res>
    extends _$EpisodeModelCopyWithImpl<$Res, _$EpisodeModelImpl>
    implements _$$EpisodeModelImplCopyWith<$Res> {
  __$$EpisodeModelImplCopyWithImpl(
      _$EpisodeModelImpl _value, $Res Function(_$EpisodeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EpisodeModel
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
    return _then(_$EpisodeModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EpisodeModelImpl extends _EpisodeModel {
  const _$EpisodeModelImpl(
      {@HiveField(0) @AnyToStringConverter() required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) @AnyToStringNullableConverter() this.description,
      @HiveField(3)
      @JsonKey(name: 'episode')
      @StringToIntConverterRequired()
      required this.number,
      @HiveField(4) @StringToIntConverter() this.season,
      @HiveField(5) @EpisodeImageConverter() this.image,
      @HiveField(6) @AnyToStringNullableConverter() this.url,
      @HiveField(7) this.releaseDate})
      : super._();

  factory _$EpisodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeModelImplFromJson(json);

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
  final String? description;
  @override
  @HiveField(3)
  @JsonKey(name: 'episode')
  @StringToIntConverterRequired()
  final int number;
  @override
  @HiveField(4)
  @StringToIntConverter()
  final int? season;
  @override
  @HiveField(5)
  @EpisodeImageConverter()
  final String? image;
  @override
  @HiveField(6)
  @AnyToStringNullableConverter()
  final String? url;
  @override
  @HiveField(7)
  final DateTime? releaseDate;

  @override
  String toString() {
    return 'EpisodeModel(id: $id, title: $title, description: $description, number: $number, season: $season, image: $image, url: $url, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, number,
      season, image, url, releaseDate);

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeModelImplCopyWith<_$EpisodeModelImpl> get copyWith =>
      __$$EpisodeModelImplCopyWithImpl<_$EpisodeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeModelImplToJson(
      this,
    );
  }
}

abstract class _EpisodeModel extends EpisodeModel {
  const factory _EpisodeModel(
      {@HiveField(0) @AnyToStringConverter() required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) @AnyToStringNullableConverter() final String? description,
      @HiveField(3)
      @JsonKey(name: 'episode')
      @StringToIntConverterRequired()
      required final int number,
      @HiveField(4) @StringToIntConverter() final int? season,
      @HiveField(5) @EpisodeImageConverter() final String? image,
      @HiveField(6) @AnyToStringNullableConverter() final String? url,
      @HiveField(7) final DateTime? releaseDate}) = _$EpisodeModelImpl;
  const _EpisodeModel._() : super._();

  factory _EpisodeModel.fromJson(Map<String, dynamic> json) =
      _$EpisodeModelImpl.fromJson;

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
  String? get description;
  @override
  @HiveField(3)
  @JsonKey(name: 'episode')
  @StringToIntConverterRequired()
  int get number;
  @override
  @HiveField(4)
  @StringToIntConverter()
  int? get season;
  @override
  @HiveField(5)
  @EpisodeImageConverter()
  String? get image;
  @override
  @HiveField(6)
  @AnyToStringNullableConverter()
  String? get url;
  @override
  @HiveField(7)
  DateTime? get releaseDate;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeModelImplCopyWith<_$EpisodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
