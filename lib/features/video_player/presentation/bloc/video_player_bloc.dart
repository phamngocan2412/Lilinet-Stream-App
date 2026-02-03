import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../../core/services/cast_service.dart';
import '../../../../core/services/download_service.dart';
import 'video_player_event.dart';
import 'video_player_state.dart';

@lazySingleton
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoPlayerService _videoPlayerService;
  final CastService _castService;
  final DownloadService _downloadService;

  VideoPlayerBloc(
    this._videoPlayerService,
    this._castService,
    this._downloadService,
  ) : super(const VideoPlayerState()) {
    on<PlayVideo>(_onPlayVideo);
    on<LoadVideo>(_onLoadVideo);
    on<TogglePlayPause>(_onTogglePlayPause);
    on<PauseVideoPlayback>(_onPauseVideoPlayback);
    on<ResumeVideoPlayback>(_onResumeVideoPlayback);
    on<SeekVideo>(_onSeekVideo);
    on<SetPlaybackSpeed>(_onSetPlaybackSpeed);
    on<MinimizeVideo>(_onMinimizeVideo);
    on<MaximizeVideo>(_onMaximizeVideo);
    on<EnterPiP>(_onEnterPiP);
    on<CloseVideo>(_onCloseVideo);
    on<StartCast>(_onStartCast);
    on<DownloadCurrentVideo>(_onDownloadCurrentVideo);
  }

  static VideoPlayerState get initialState => const VideoPlayerState();

  // Expose service for UI components that need the controller (Video widget)
  VideoPlayerService get videoService => _videoPlayerService;

  void _onPlayVideo(PlayVideo event, Emitter<VideoPlayerState> emit) {
    emit(
      state.copyWith(
        status: VideoPlayerStatus.expanded,
        episodeId: event.episodeId,
        mediaId: event.mediaId,
        title: event.title,
        posterUrl: event.posterUrl,
        episodeTitle: event.episodeTitle,
        startPosition: event.startPosition,
        mediaType: event.mediaType,
        movie: event.movie,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _onLoadVideo(LoadVideo event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.playVideo(
      url: event.url,
      startPosition: state.startPosition,
      subtitleUrl: event.subtitleUrl,
      subtitleLang: event.subtitleLang,
      headers: event.headers,
      isQualitySwitch: event.isQualitySwitch,
    );
  }

  Future<void> _onTogglePlayPause(TogglePlayPause event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.playOrPause();
  }

  Future<void> _onPauseVideoPlayback(PauseVideoPlayback event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.pause();
  }

  Future<void> _onResumeVideoPlayback(ResumeVideoPlayback event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.play();
  }

  Future<void> _onSeekVideo(SeekVideo event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.player.seek(event.position);
  }

  Future<void> _onSetPlaybackSpeed(SetPlaybackSpeed event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.setRate(event.speed);
  }

  void _onMinimizeVideo(MinimizeVideo event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.minimized));
  }

  void _onMaximizeVideo(MaximizeVideo event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.expanded));
  }

  Future<void> _onEnterPiP(EnterPiP event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.enablePiP();
  }

  Future<void> _onCloseVideo(CloseVideo event, Emitter<VideoPlayerState> emit) async {
    await _videoPlayerService.stop();
    emit(const VideoPlayerState(status: VideoPlayerStatus.closed));
  }

  Future<void> _onStartCast(StartCast event, Emitter<VideoPlayerState> emit) async {
    await _castService.startCasting(
      videoUrl: event.videoUrl,
      title: state.title ?? 'Video',
    );
  }

  Future<void> _onDownloadCurrentVideo(DownloadCurrentVideo event, Emitter<VideoPlayerState> emit) async {
    await _downloadService.downloadVideo(
      url: event.url,
      fileName: event.fileName,
      movieId: event.movieId,
      movieTitle: event.movieTitle,
    );
  }
}
