import 'package:flutter/material.dart';
import '../../domain/entities/episode.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';
import 'episode_item.dart';

class EpisodeList extends StatefulWidget {
  final List<Episode> episodes;
  final String mediaId;
  final Function(Episode) onEpisodeTap;
  final List<WatchProgress> watchProgress;
  final String? posterUrl;
  final String? currentEpisodeId;

  const EpisodeList({
    super.key,
    required this.episodes,
    required this.mediaId,
    required this.onEpisodeTap,
    this.watchProgress = const [],
    this.posterUrl,
    this.currentEpisodeId,
  });

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  late Map<String, WatchProgress> _progressMap;

  // Optimization: Reuse empty instance to reduce allocations during scroll
  static final _emptyProgress = WatchProgress.empty();

  @override
  void initState() {
    super.initState();
    _updateProgressMap();
  }

  @override
  void didUpdateWidget(EpisodeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Optimization: Only rebuild map if watchProgress list identity changes
    // or mediaId changes. Content changes within the same list instance
    // are not detected here, but HistoryBloc typically emits new list instances.
    if (widget.watchProgress != oldWidget.watchProgress ||
        widget.mediaId != oldWidget.mediaId) {
      _updateProgressMap();
    }
  }

  void _updateProgressMap() {
    _progressMap = {
      for (final p in widget.watchProgress)
        if (p.mediaId == widget.mediaId && p.episodeId != null) p.episodeId!: p
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 300,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.episodes.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final episode = widget.episodes[index];
        final isSelected = episode.id == widget.currentEpisodeId;
        final progress = _progressMap[episode.id] ?? _emptyProgress;

        return EpisodeItem(
          key: ValueKey(episode.id),
          episode: episode,
          isSelected: isSelected,
          progress: progress,
          posterUrl: widget.posterUrl,
          onTap: () => widget.onEpisodeTap(episode),
          totalEpisodesCount: widget.episodes.length,
        );
      },
    );
  }
}
