import 'streaming_link.dart';
import 'subtitle.dart';

class StreamingResponse {
  final List<StreamingLink> links;
  final List<Subtitle> subtitles;

  const StreamingResponse({required this.links, required this.subtitles});
}
