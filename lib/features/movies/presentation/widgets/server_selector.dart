// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ServerSelector extends StatelessWidget {
  final List<String> servers;
  final String? selectedServer;
  final Function(String) onServerSelected;

  const ServerSelector({
    super.key,
    required this.servers,
    required this.selectedServer,
    required this.onServerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Text(
            'Server: ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: servers.map((server) {
                  final isSelected = server == selectedServer;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(server),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) onServerSelected(server);
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
