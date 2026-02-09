import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/constants/app_spacing.dart';
// import '../../../../core/constants/app_border_radius.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settingsTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                    top: AppSpacing.lg,
                    bottom: AppSpacing.lg + miniplayerHeight,
                  ),
                  children: [
                    AccountSection(
                      onDeleteAccount: () => _showDeleteAccountDialog(context),
                    ),
                    const Divider(height: AppSpacing.xxl),
                    AppearanceSection(settings: settings),
                    const Divider(height: AppSpacing.xxl),
                    PlaybackSection(settings: settings),
                    const Divider(height: AppSpacing.xxl),
                    SettingsSection(
                      title: l10n.downloadSection,
                      icon: Icons.download,
                      children: [
                        SettingsSwitchTile(
                          title: l10n.wifiOnly,
                          subtitle: l10n.wifiOnlySubtitle,
                          value: settings.downloadOverWifiOnly,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                                  UpdateSettings(
                                    settings.copyWith(
                                        downloadOverWifiOnly: value),
                                  ),
                                );
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.download_done),
                          title: Text(l10n.myDownloads),
                          subtitle: Text(l10n.myDownloadsSubtitle),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/downloads'),
                        ),
                      ],
                    ),
                    const Divider(height: AppSpacing.xxl),
                    SettingsSection(
                      title: l10n.notificationsSection,
                      icon: Icons.notifications,
                      children: [
                        SettingsSwitchTile(
                          title: l10n.pushNotifications,
                          subtitle: l10n.pushNotificationsSubtitle,
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
                    const Divider(height: AppSpacing.xxl),
                    ContentSettingsSection(settings: settings),
                    const Divider(height: AppSpacing.xxl),
                    StorageSettingsSection(
                      onClearCache: () => _showClearCacheDialog(context),
                    ),
                    const Divider(height: AppSpacing.xxl),
                    AboutSection(onLaunchURL: (url) => _launchURL(url)),
                    const SizedBox(height: AppSpacing.xxl),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showResetDialog(context);
                        },
                        icon: const Icon(Icons.restore),
                        label: Text(l10n.resetAllSettings),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorScheme.error,
                          side: BorderSide(
                            color: colorScheme.error,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.lg,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
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
    // Minimize player before showing dialog
    getIt<VideoPlayerBloc>().add(MinimizeVideo());

    showDialog(
      context: context,
      useRootNavigator: true, // Show above miniplayer
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
    // Minimize player before showing dialog
    getIt<VideoPlayerBloc>().add(MinimizeVideo());

    showDialog(
      context: context,
      useRootNavigator: true, // Show above miniplayer
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
    // Minimize player before showing dialog
    getIt<VideoPlayerBloc>().add(MinimizeVideo());

    showDialog(
      context: context,
      useRootNavigator: true, // Show above miniplayer
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
