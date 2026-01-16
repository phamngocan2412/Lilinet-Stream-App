import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../../../../core/utils/json_converters.dart';
import '../../domain/entities/streaming_link.dart';

part 'streaming_link_model.freezed.dart';
part 'streaming_link_model.g.dart';

@freezed
@HiveType(typeId: 9)
abstract class StreamingLinkModel with _$StreamingLinkModel {
  const StreamingLinkModel._();

  const factory StreamingLinkModel({
    @HiveField(0) @AnyToStringConverter() required String url,
    @HiveField(1) @AnyToStringConverter() required String quality,
    @HiveField(2) required bool isM3U8,
    @HiveField(3) Map<String, String>? headers,
  }) = _StreamingLinkModel;

  factory StreamingLinkModel.fromJson(Map<String, dynamic> json) =>
      _$StreamingLinkModelFromJson(json);

  StreamingLink toEntity() {
    return StreamingLink(
      url: url,
      quality: quality,
      isM3U8: isM3U8,
      headers: headers,
    );
  }
}

@freezed
@HiveType(typeId: 11)
abstract class SubtitleModel with _$SubtitleModel {
  const SubtitleModel._();

  const factory SubtitleModel({
    @HiveField(0) @AnyToStringConverter() required String url,
    @HiveField(1) @AnyToStringConverter() required String lang,
  }) = _SubtitleModel;

  factory SubtitleModel.fromJson(Map<String, dynamic> json) =>
      _$SubtitleModelFromJson(json);
}

@freezed
@HiveType(typeId: 10)
abstract class StreamingResponseModel with _$StreamingResponseModel {
  const factory StreamingResponseModel({
    @HiveField(0) required List<StreamingLinkModel> sources,
    @HiveField(1) Map<String, String>? headers,
    @HiveField(2) List<SubtitleModel>? subtitles,
  }) = _StreamingResponseModel;

  factory StreamingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StreamingResponseModelFromJson(json);
}
