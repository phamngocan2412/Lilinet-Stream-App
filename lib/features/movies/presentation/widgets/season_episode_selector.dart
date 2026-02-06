import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/episode.dart';
import '../../../../features/history/domain/entities/watch_progress.dart';
import 'episode_list.dart'; // Reuse existing EpisodeList

class SeasonEpisodeSelector extends StatelessWidget {
  final Movie movie;
  final int selectedSeason;
  final List<Episode> episodes;
  final Function(int) onSeasonSelected;
  final Function(Episode) onEpisodeTap;
  final List<WatchProgress> watchProgress;

  const SeasonEpisodeSelector({
    super.key,
    required this.movie,
    required this.selectedSeason,
    required this.episodes,
    required this.onSeasonSelected,
    required this.onEpisodeTap,
    required this.watchProgress,
  });

  @override
  Widget build(BuildContext context) {
    // If it's a movie, just show episodes (usually one) without selector
    if (movie.type.toLowerCase() == 'movie') {
      return _buildEpisodeList();
    }

    // Determine available seasons
    final allEpisodes = movie.episodes ?? [];
    if (allEpisodes.isEmpty) return const SizedBox.shrink();

    final seasons = allEpisodes.map((e) => e.season ?? 1).toSet().toList();
    seasons.sort();

    // If only 1 season, don't show selector? Or maybe show "Season 1" text?
    // Requirement says "If Movie ... Hide Season Selector".
    // If TV Series with 1 season, we might still want to show "Season 1".

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (seasons.length > 1) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: seasons.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final season = seasons[index];
                  final isSelected = season == selectedSeason;
                  return ChoiceChip(
                    label: Text('Season $season'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) onSeasonSelected(season);
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    backgroundColor: Colors.white10,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        _buildEpisodeList(),
      ],
    );
  }

  Widget _buildEpisodeList() {
    return EpisodeList(
      episodes: episodes,
      mediaId: movie.id,
      posterUrl: movie.poster ?? movie.cover,
      onEpisodeTap: onEpisodeTap,
      watchProgress: watchProgress,
    );
  }
}
