import 'package:flutter/material.dart';
import 'settings_section.dart';

class StorageSettingsSection extends StatelessWidget {
  final VoidCallback onClearCache;

  const StorageSettingsSection({super.key, required this.onClearCache});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Storage',
      icon: Icons.storage,
      children: [
        ListTile(
          title: const Text('Clear Cache'),
          subtitle: const Text('Remove cached images and data'),
          leading: const Icon(Icons.delete_sweep),
          onTap: onClearCache,
        ),
      ],
    );
  }
}
