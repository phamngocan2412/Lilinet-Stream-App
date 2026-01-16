import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../../../../core/utils/json_converters.dart';
import 'episode_model.dart';

part 'season_model.freezed.dart';
part 'season_model.g.dart';

@freezed
@HiveType(typeId: 6)
abstract class SeasonModel with _$SeasonModel {
  const factory SeasonModel({
    @HiveField(0) @StringToIntConverterRequired() required int season,
    @HiveField(1) @Default([]) List<EpisodeModel> episodes,
  }) = _SeasonModel;

  factory SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonModelFromJson(json);
}
