// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming_link_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreamingLinkModelAdapter extends TypeAdapter<StreamingLinkModel> {
  @override
  final typeId = 9;

  @override
  StreamingLinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreamingLinkModel(
      url: fields[0] as String,
      quality: fields[1] as String,
      isM3U8: fields[2] as bool,
      headers: (fields[3] as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, StreamingLinkModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.quality)
      ..writeByte(2)
      ..write(obj.isM3U8)
      ..writeByte(3)
      ..write(obj.headers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamingLinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubtitleModelAdapter extends TypeAdapter<SubtitleModel> {
  @override
  final typeId = 11;

  @override
  SubtitleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtitleModel(url: fields[0] as String, lang: fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, SubtitleModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.lang);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtitleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StreamingResponseModelAdapter
    extends TypeAdapter<StreamingResponseModel> {
  @override
  final typeId = 10;

  @override
  StreamingResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreamingResponseModel(
      sources: (fields[0] as List).cast<StreamingLinkModel>(),
      headers: (fields[1] as Map?)?.cast<String, String>(),
      subtitles: (fields[2] as List?)?.cast<SubtitleModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StreamingResponseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sources)
      ..writeByte(1)
      ..write(obj.headers)
      ..writeByte(2)
      ..write(obj.subtitles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamingResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StreamingLinkModel _$StreamingLinkModelFromJson(Map<String, dynamic> json) =>
    _StreamingLinkModel(
      url: const AnyToStringConverter().fromJson(json['url']),
      quality: const AnyToStringConverter().fromJson(json['quality']),
      isM3U8: json['isM3U8'] as bool,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$StreamingLinkModelToJson(_StreamingLinkModel instance) =>
    <String, dynamic>{
      'url': const AnyToStringConverter().toJson(instance.url),
      'quality': const AnyToStringConverter().toJson(instance.quality),
      'isM3U8': instance.isM3U8,
      'headers': instance.headers,
    };

_SubtitleModel _$SubtitleModelFromJson(Map<String, dynamic> json) =>
    _SubtitleModel(
      url: const AnyToStringConverter().fromJson(json['url']),
      lang: const AnyToStringConverter().fromJson(json['lang']),
    );

Map<String, dynamic> _$SubtitleModelToJson(_SubtitleModel instance) =>
    <String, dynamic>{
      'url': const AnyToStringConverter().toJson(instance.url),
      'lang': const AnyToStringConverter().toJson(instance.lang),
    };

_StreamingResponseModel _$StreamingResponseModelFromJson(
  Map<String, dynamic> json,
) => _StreamingResponseModel(
  sources: (json['sources'] as List<dynamic>)
      .map((e) => StreamingLinkModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  headers: (json['headers'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  subtitles: (json['subtitles'] as List<dynamic>?)
      ?.map((e) => SubtitleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StreamingResponseModelToJson(
  _StreamingResponseModel instance,
) => <String, dynamic>{
  'sources': instance.sources,
  'headers': instance.headers,
  'subtitles': instance.subtitles,
};

_ServerInfoModel _$ServerInfoModelFromJson(Map<String, dynamic> json) =>
    _ServerInfoModel(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$ServerInfoModelToJson(_ServerInfoModel instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
