import 'package:flutter/material.dart';
import 'package:lilinet_app/features/explore/domain/entities/filter_options.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions currentOptions;
  final Function(FilterOptions) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentOptions,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterOptions _options;

  @override
  void initState() {
    super.initState();
    _options = widget.currentOptions;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // Sort By
          Text(
            'Sort By',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: SortBy.values.map((sort) {
              final isSelected = _options.sortBy == sort;
              return ChoiceChip(
                label: Text(_getSortLabel(sort)),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _options = _options.copyWith(sortBy: sort);
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Media Type
          Text(
            'Type',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: MediaType.values.map((type) {
              final isSelected = _options.mediaType == type;
              return ChoiceChip(
                label: Text(_getTypeLabel(type)),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _options = _options.copyWith(mediaType: type);
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Min Rating
          Text(
            'Min Rating: ${(_options.minRating ?? 0).toStringAsFixed(1)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: _options.minRating ?? 0,
            min: 0,
            max: 10,
            divisions: 20,
            label: (_options.minRating ?? 0).toStringAsFixed(1),
            onChanged: (value) {
              setState(() {
                _options = _options.copyWith(minRating: value);
              });
            },
          ),
          const SizedBox(height: 24),

          // Apply Button
          FilledButton(
            onPressed: () {
              widget.onApply(_options);
              Navigator.pop(context);
            },
            child: const Text('Apply Filters'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getSortLabel(SortBy sort) {
    switch (sort) {
      case SortBy.popularity:
        return 'Popularity';
      case SortBy.releaseDate:
        return 'Release Date';
      case SortBy.rating:
        return 'Rating';
      case SortBy.title:
        return 'Title';
    }
  }

  String _getTypeLabel(MediaType type) {
    switch (type) {
      case MediaType.all:
        return 'All';
      case MediaType.movie:
        return 'Movie';
      case MediaType.tvSeries:
        return 'TV Series';
    }
  }
}
