import 'package:flutter/material.dart';
import '../../presentation/manager/comment_state.dart';

class CommentSortTabs extends StatelessWidget {
  final CommentSortType currentSort;
  final ValueChanged<CommentSortType> onSortChanged;

  const CommentSortTabs({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.05),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTab(context, 'Top', CommentSortType.trending),
          _buildTab(context, 'Newest', CommentSortType.newest),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, CommentSortType type) {
    final isSelected = currentSort == type;
    return InkWell(
      onTap: () => onSortChanged(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
