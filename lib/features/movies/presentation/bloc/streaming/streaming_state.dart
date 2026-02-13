import 'package:equatable/equatable.dart';
import '../../../domain/entities/streaming_link.dart';
import '../../../domain/entities/subtitle.dart';

abstract class StreamingState extends Equatable {
  const StreamingState();

  @override
  List<Object?> get props => [];
}

class StreamingInitial extends StreamingState {}

class StreamingLoading extends StreamingState {}

class StreamingLoaded extends StreamingState {
  final String episodeId;
  final List<StreamingLink> links;
  final String? selectedServer;
  final List<Subtitle>? subtitles;
  final List<String>? availableServers;

  const StreamingLoaded({
    required this.episodeId,
    required this.links,
    this.selectedServer,
    this.subtitles,
    this.availableServers,
  });

  @override
  List<Object?> get props => [
        episodeId,
        links,
        selectedServer,
        subtitles,
        availableServers,
      ];
}

class StreamingError extends StreamingState {
  final String message;

  const StreamingError(this.message);

  @override
  List<Object> get props => [message];
}
