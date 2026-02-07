import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../features/movies/domain/entities/streaming_link.dart';

part 'streaming_state.freezed.dart';

@freezed
class StreamingState with _$StreamingState {
  const factory StreamingState.initial() = StreamingInitial;

  const factory StreamingState.loading() = StreamingLoading;

  const factory StreamingState.loaded({
    required List<StreamingLink> links,
    required String selectedServer,
    String? selectedQuality,
  }) = StreamingLoaded;

  const factory StreamingState.error(String message) = StreamingError;
}

extension StreamingStateX on StreamingState {
  bool get isLoading => this is StreamingLoading;
  bool get isLoaded => this is StreamingLoaded;
  bool get hasError => this is StreamingError;

  StreamingLink? get currentLink {
    return maybeWhen(
      loaded: (links, server, quality) => links.firstOrNull,
      orElse: () => null,
    );
  }
}
