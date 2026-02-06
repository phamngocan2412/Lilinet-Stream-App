import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/app_settings.dart' as domain;
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/widgets/auth_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          if (settingsState is SettingsLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (settingsState is SettingsError) {
            return Center(child: Text(settingsState.message));
          }

          if (settingsState is SettingsLoaded ||
              settingsState is SettingsSaved) {
            final settings = settingsState is SettingsLoaded
                ? settingsState.settings
                : (settingsState as SettingsSaved).settings;

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildAccountSection(context),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Appearance',
                  icon: Icons.palette,
                  children: [_buildThemeSelector(context, settings)],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Playback',
                  icon: Icons.play_circle,
                  children: [
                    _buildSwitchTile(
                      context,
                      title: 'Auto Play',
                      subtitle: 'Automatically play next episode',
                      value: settings.autoPlay,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                  settings.copyWith(autoPlay: value)),
                            );
                      },
                    ),
                    _buildSwitchTile(
                      context,
                      title: 'Skip Intro',
                      subtitle: 'Skip intro when available',
                      value: settings.skipIntro,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                  settings.copyWith(skipIntro: value)),
                            );
                      },
                    ),
                    _buildQualitySelector(context, settings),
                    _buildServerSelector(context, settings),
                    _buildProviderSelector(context, settings),
                  ],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Download',
                  icon: Icons.download,
                  children: [
                    _buildSwitchTile(
                      context,
                      title: 'WiFi Only',
                      subtitle: 'Download only on WiFi connection',
                      value: settings.downloadOverWifiOnly,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings.copyWith(downloadOverWifiOnly: value),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Notifications',
                  icon: Icons.notifications,
                  children: [
                    _buildSwitchTile(
                      context,
                      title: 'Push Notifications',
                      subtitle: 'Receive app notifications',
                      value: settings.showNotifications,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings.copyWith(showNotifications: value),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Content',
                  icon: Icons.visibility,
                  children: [
                    _buildSwitchTile(
                      context,
                      title: 'Adult Content',
                      subtitle: 'Show adult content',
                      value: settings.adultContent,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              UpdateSettings(
                                settings.copyWith(adultContent: value),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
                  title: 'Storage',
                  icon: Icons.storage,
                  children: [
                    ListTile(
                      title: const Text('Clear Cache'),
                      subtitle: const Text('Remove cached images and data'),
                      leading: const Icon(Icons.delete_sweep),
                      onTap: () {
                        _showClearCacheDialog(context);
                      },
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildSection(
                  context,
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
                      onTap: () {
                        _launchURL('https://policies.google.com/privacy');
                      },
                    ),
                    ListTile(
                      title: const Text('Terms of Service'),
                      leading: const Icon(Icons.description),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () {
                        _launchURL('https://policies.google.com/terms');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showResetDialog(context);
                    },
                    icon: const Icon(Icons.restore),
                    label: const Text('Reset All Settings'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (state is Authenticated)
              ListTile(
                leading: CircleAvatar(
                  child: Text(state.user.email[0].toUpperCase()),
                ),
                title: Text(state.user.email.split('@')[0]),
                subtitle: const Text('Signed In'),
                trailing: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                ),
              )
            else
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Sign In / Sign Up'),
                subtitle: const Text('Sync favorites across devices'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AuthDialog(),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    domain.AppSettings settings,
  ) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: Text(_getThemeLabel(settings.themeMode)),
      leading: const Icon(Icons.brightness_6),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        final settingsBloc = context.read<SettingsBloc>();
        showModalBottomSheet(
          context: context,
          builder: (bottomSheetContext) => BlocProvider.value(
            value: settingsBloc,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Light'),
                  leading: const Icon(Icons.light_mode),
                  trailing: settings.themeMode == domain.ThemeMode.light
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(themeMode: domain.ThemeMode.light),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                ListTile(
                  title: const Text('Dark'),
                  leading: const Icon(Icons.dark_mode),
                  trailing: settings.themeMode == domain.ThemeMode.dark
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(themeMode: domain.ThemeMode.dark),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                ListTile(
                  title: const Text('System'),
                  leading: const Icon(Icons.settings_system_daydream),
                  trailing: settings.themeMode == domain.ThemeMode.system
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(themeMode: domain.ThemeMode.system),
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
    );
  }

  Widget _buildQualitySelector(
    BuildContext context,
    domain.AppSettings settings,
  ) {
    return ListTile(
      title: const Text('Default Quality'),
      subtitle: Text(_getQualityLabel(settings.defaultQuality)),
      leading: const Icon(Icons.high_quality),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        final settingsBloc = context.read<SettingsBloc>();
        showModalBottomSheet(
          context: context,
          builder: (bottomSheetContext) => BlocProvider.value(
            value: settingsBloc,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: domain.VideoQuality.values.map((quality) {
                return ListTile(
                  title: Text(_getQualityLabel(quality)),
                  trailing: settings.defaultQuality == quality
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(defaultQuality: quality),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServerSelector(
    BuildContext context,
    domain.AppSettings settings,
  ) {
    return ListTile(
      title: const Text('Preferred Server'),
      subtitle: Text(_getServerLabel(settings.preferredServer)),
      leading: const Icon(Icons.dns),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        final settingsBloc = context.read<SettingsBloc>();
        showModalBottomSheet(
          context: context,
          builder: (bottomSheetContext) => BlocProvider.value(
            value: settingsBloc,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Auto (Recommended)'),
                  subtitle: const Text(
                      'Automatically select the best available server'),
                  trailing:
                      settings.preferredServer == domain.PreferredServer.auto
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                            preferredServer: domain.PreferredServer.auto),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                ListTile(
                  title: const Text('VidCloud'),
                  subtitle: const Text('Fast and reliable'),
                  trailing: settings.preferredServer ==
                          domain.PreferredServer.vidcloud
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                            preferredServer: domain.PreferredServer.vidcloud),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                ListTile(
                  title: const Text('UpCloud'),
                  subtitle: const Text('Good for movies'),
                  trailing:
                      settings.preferredServer == domain.PreferredServer.upcloud
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                            preferredServer: domain.PreferredServer.upcloud),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                ListTile(
                  title: const Text('MegaUp'),
                  subtitle: const Text('Alternative server'),
                  trailing:
                      settings.preferredServer == domain.PreferredServer.megaup
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                            preferredServer: domain.PreferredServer.megaup),
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
    );
  }

  String _getServerLabel(domain.PreferredServer server) {
    switch (server) {
      case domain.PreferredServer.auto:
        return 'Auto';
      case domain.PreferredServer.vidcloud:
        return 'VidCloud';
      case domain.PreferredServer.upcloud:
        return 'UpCloud';
      case domain.PreferredServer.megaup:
        return 'MegaUp';
    }
  }

  Widget _buildProviderSelector(
    BuildContext context,
    domain.AppSettings settings,
  ) {
    return Column(
      children: [
        ListTile(
          title: const Text('Anime Source'),
          subtitle: Text(settings.animeProvider.toUpperCase()),
          leading: const Icon(Icons.animation),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            final settingsBloc = context.read<SettingsBloc>();
            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) => BlocProvider.value(
                value: settingsBloc,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'animepahe',
                      'AnimePahe (Recommended)',
                      isMovie: false,
                    ),
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'gogoanime',
                      'GogoAnime (Stable)',
                      isMovie: false,
                    ),
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'zoro',
                      'Zoro / HiAnime (Best Quality)',
                      isMovie: false,
                    ),
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'animekai',
                      'AnimeKai',
                      isMovie: false,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Movie Source'),
          subtitle: Text(settings.movieProvider.toUpperCase()),
          leading: const Icon(Icons.movie),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            final settingsBloc = context.read<SettingsBloc>();
            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) => BlocProvider.value(
                value: settingsBloc,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'flixhq',
                      'FlixHQ (Recommended)',
                      isMovie: true,
                    ),
                    _buildProviderOption(
                      context,
                      settingsBloc,
                      settings,
                      'viewasian',
                      'ViewAsian / DramaCool',
                      isMovie: true,
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

  Widget _buildProviderOption(
    BuildContext context,
    SettingsBloc bloc,
    domain.AppSettings settings,
    String id,
    String label, {
    required bool isMovie,
  }) {
    final isSelected =
        isMovie ? settings.movieProvider == id : settings.animeProvider == id;

    return ListTile(
      title: Text(label),
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        bloc.add(
          UpdateSettings(
            isMovie
                ? settings.copyWith(movieProvider: id)
                : settings.copyWith(animeProvider: id),
          ),
        );
        Navigator.pop(context);
      },
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

  String _getQualityLabel(domain.VideoQuality quality) {
    switch (quality) {
      case domain.VideoQuality.auto:
        return 'Auto';
      case domain.VideoQuality.sd360:
        return '360p';
      case domain.VideoQuality.sd480:
        return '480p';
      case domain.VideoQuality.hd720:
        return '720p';
      case domain.VideoQuality.hd1080:
        return '1080p';
    }
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all cached images to free up space. Your settings and login will not be affected. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<SettingsBloc>().add(ClearCache());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'This will reset your preferences (Theme, Quality, etc) to default. Your account will remain logged in. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<SettingsBloc>().add(ResetSettings());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset successfully')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
