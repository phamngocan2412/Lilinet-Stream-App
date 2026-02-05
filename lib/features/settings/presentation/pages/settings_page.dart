import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/settings_section.dart';
import '../widgets/account_section.dart';
import '../widgets/appearance_section.dart';
import '../widgets/playback_section.dart';
import '../widgets/content_settings_section.dart';
import '../widgets/storage_settings_section.dart';
import '../widgets/about_section.dart';

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

            return ListenableBuilder(
              listenable: getIt<MiniplayerHeightNotifier>(),
              builder: (context, _) {
                final miniplayerHeight =
                    getIt<MiniplayerHeightNotifier>().height;

                return ListView(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 16 + miniplayerHeight,
                  ),
                  children: [
                    AccountSection(
                      onDeleteAccount: () => _showDeleteAccountDialog(context),
                    ),
                    const Divider(height: 32),
                    AppearanceSection(settings: settings),
                    const Divider(height: 32),
                    PlaybackSection(settings: settings),
                    const Divider(height: 32),
                    SettingsSection(
                      title: 'Download',
                      icon: Icons.download,
                      children: [
                        SettingsSwitchTile(
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
                    SettingsSection(
                      title: 'Notifications',
                      icon: Icons.notifications,
                      children: [
                        SettingsSwitchTile(
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
                    ContentSettingsSection(settings: settings),
                    const Divider(height: 32),
                    StorageSettingsSection(
                      onClearCache: () => _showClearCacheDialog(context),
                    ),
                    const Divider(height: 32),
                    AboutSection(onLaunchURL: (url) => _launchURL(url)),
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
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and you will lose all your favorites and history.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<AuthBloc>().add(const DeleteAccountRequested());
              Navigator.pop(dialogContext);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
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
