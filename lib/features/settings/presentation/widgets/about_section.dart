import 'package:flutter/material.dart';
import 'settings_section.dart';

class AboutSection extends StatelessWidget {
  final Function(String) onLaunchURL;

  const AboutSection({super.key, required this.onLaunchURL});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'About',
      icon: Icons.info,
      children: [
        const ListTile(
          title: Text('Version'),
          subtitle: Text('1.0.0+1'),
          leading: Icon(Icons.apps),
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          leading: const Icon(Icons.privacy_tip),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => onLaunchURL('https://policies.google.com/privacy'),
        ),
        ListTile(
          title: const Text('Terms of Service'),
          leading: const Icon(Icons.description),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => onLaunchURL('https://policies.google.com/terms'),
        ),
      ],
    );
  }
}
