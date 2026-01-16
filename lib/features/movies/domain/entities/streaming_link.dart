import 'package:equatable/equatable.dart';

class StreamingLink extends Equatable {
  final String url;
  final String quality;
  final bool isM3U8;
  final Map<String, String>? headers;

  const StreamingLink({
    required this.url,
    required this.quality,
    required this.isM3U8,
    this.headers,
  });

  @override
  List<Object?> get props => [url, quality, isM3U8, headers];
}
