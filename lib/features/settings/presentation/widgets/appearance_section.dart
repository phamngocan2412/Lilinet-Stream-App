import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';
import '../../domain/entities/app_settings.dart' as domain;
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import 'settings_section.dart';

class AppearanceSection extends StatelessWidget {
  final domain.AppSettings settings;

  const AppearanceSection({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Appearance',
      icon: Icons.palette,
      children: [
        ListTile(
          title: const Text('Theme'),
          subtitle: Text(_getThemeLabel(settings.themeMode)),
          leading: const Icon(Icons.brightness_6),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Minimize player before showing bottom sheet
            final videoBloc = getIt<VideoPlayerBloc>();
            videoBloc.add(MinimizeVideo());

            final settingsBloc = context.read<SettingsBloc>();
            showModalBottomSheet(
              context: context,
              useRootNavigator: true, // Show above miniplayer
              builder: (bottomSheetContext) => BlocProvider.value(
                value: settingsBloc,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ThemeOption(
                      title: 'Light',
                      icon: Icons.light_mode,
                      isSelected: settings.themeMode == domain.ThemeMode.light,
                      onTap: () {
                        settingsBloc.add(
                          UpdateSettings(
                            settings.copyWith(
                              themeMode: domain.ThemeMode.light,
                            ),
                          ),
                        );
                        Navigator.pop(bottomSheetContext);
                      },
                    ),
                    _ThemeOption(
                      title: 'Dark',
                      icon: Icons.dark_mode,
                      isSelected: settings.themeMode == domain.ThemeMode.dark,
                      onTap: () {
                        settingsBloc.add(
                          UpdateSettings(
                            settings.copyWith(themeMode: domain.ThemeMode.dark),
                          ),
                        );
                        Navigator.pop(bottomSheetContext);
                      },
                    ),
                    _ThemeOption(
                      title: 'System',
                      icon: Icons.settings_system_daydream,
                      isSelected: settings.themeMode == domain.ThemeMode.system,
                      onTap: () {
                        settingsBloc.add(
                          UpdateSettings(
                            settings.copyWith(
                              themeMode: domain.ThemeMode.system,
                            ),
                          ),
                        );
                        Navigator.pop(bottomSheetContext);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _getThemeLabel(domain.ThemeMode mode) {
    switch (mode) {
      case domain.ThemeMode.light:
        return 'Light';
      case domain.ThemeMode.dark:
        return 'Dark';
      case domain.ThemeMode.system:
        return 'System';
    }
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: onTap,
    );
  }
}
