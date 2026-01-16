import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';

class SeasonSelector extends StatelessWidget {
  final Movie movie;
  final int selectedSeason;
  final Function(int) onSeasonSelected;

  const SeasonSelector({
    super.key,
    required this.movie,
    required this.selectedSeason,
    required this.onSeasonSelected,
  });

  @override
  Widget build(BuildContext context) {
    // If it's a movie, hide selector
    if (movie.type.toLowerCase() == 'movie') {
      return const SizedBox.shrink();
    }

    // Determine available seasons
    final allEpisodes = movie.episodes ?? [];
    if (allEpisodes.isEmpty) return const SizedBox.shrink();

    final seasons = allEpisodes.map((e) => e.season ?? 1).toSet().toList();
    seasons.sort();

    // If only 1 season, hide selector
    if (seasons.length <= 1) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: seasons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
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
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
