import 'package:freezed_annotation/freezed_annotation.dart';

part 'streaming_link.freezed.dart';

@freezed
abstract class StreamingLink with _$StreamingLink {
  const factory StreamingLink({
    required String url,
    required String quality,
    required bool isM3U8,
    Map<String, String>? headers,
  }) = _StreamingLink;
}
