import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../../../../core/utils/json_converters.dart';
import '../../domain/entities/episode.dart';

part 'episode_model.freezed.dart';
part 'episode_model.g.dart';

@freezed
@HiveType(typeId: 5)
abstract class EpisodeModel with _$EpisodeModel {
  const EpisodeModel._();

  const factory EpisodeModel({
    @HiveField(0) @AnyToStringConverter() required String id,
    @HiveField(1) required String title,
    @HiveField(2) @AnyToStringNullableConverter() String? description,
    @HiveField(3)
    @JsonKey(name: 'episode')
    @StringToIntConverterRequired()
    required int number,
    @HiveField(4) @StringToIntConverter() int? season,
    @HiveField(5) @EpisodeImageConverter() String? image,
    @HiveField(6) @AnyToStringNullableConverter() String? url,
    @HiveField(7) DateTime? releaseDate,
  }) = _EpisodeModel;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Episode toEntity() {
    return Episode(
      id: id,
      title: title,
      description: description,
      number: number,
      season: season,
      image: image,
      url: url,
      releaseDate: releaseDate,
    );
  }
}
