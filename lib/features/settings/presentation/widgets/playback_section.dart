import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';
import '../../domain/entities/app_settings.dart' as domain;
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import 'settings_section.dart';

class PlaybackSection extends StatelessWidget {
  final domain.AppSettings settings;

  const PlaybackSection({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Playback',
      icon: Icons.play_circle,
      children: [
        SettingsSwitchTile(
          title: 'Auto Play',
          subtitle: 'Automatically play next episode',
          value: settings.autoPlay,
          onChanged: (value) {
            context.read<SettingsBloc>().add(
              UpdateSettings(settings.copyWith(autoPlay: value)),
            );
          },
        ),
        SettingsSwitchTile(
          title: 'Skip Intro',
          subtitle: 'Skip intro when available',
          value: settings.skipIntro,
          onChanged: (value) {
            context.read<SettingsBloc>().add(
              UpdateSettings(settings.copyWith(skipIntro: value)),
            );
          },
        ),
        _buildQualitySelector(context),
        _buildServerSelector(context),
        _buildProviderSelector(context),
      ],
    );
  }

  void _minimizePlayer(BuildContext context) {
    // Minimize player before showing dialog to prevent overlay issues
    final videoBloc = getIt<VideoPlayerBloc>();
    if (videoBloc.state.status.toString() != 'VideoPlayerStatus.minimized') {
      videoBloc.add(MinimizeVideo());
    }
  }

  Widget _buildQualitySelector(BuildContext context) {
    return ListTile(
      title: const Text('Default Quality'),
      subtitle: Text(_getQualityLabel(settings.defaultQuality)),
      leading: const Icon(Icons.high_quality),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        _minimizePlayer(context);
        final settingsBloc = context.read<SettingsBloc>();
        showModalBottomSheet(
          context: context,
          useRootNavigator: true, // Show above miniplayer
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

  Widget _buildServerSelector(BuildContext context) {
    return ListTile(
      title: const Text('Preferred Server'),
      subtitle: Text(_getServerLabel(settings.preferredServer)),
      leading: const Icon(Icons.dns),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        _minimizePlayer(context);
        final settingsBloc = context.read<SettingsBloc>();
        showModalBottomSheet(
          context: context,
          useRootNavigator: true, // Show above miniplayer
          builder: (bottomSheetContext) => BlocProvider.value(
            value: settingsBloc,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ServerOption(
                  title: 'Auto (Recommended)',
                  subtitle: 'Automatically select the best available server',
                  isSelected:
                      settings.preferredServer == domain.PreferredServer.auto,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                          preferredServer: domain.PreferredServer.auto,
                        ),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                _ServerOption(
                  title: 'VidCloud',
                  subtitle: 'Fast and reliable',
                  isSelected:
                      settings.preferredServer ==
                      domain.PreferredServer.vidcloud,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                          preferredServer: domain.PreferredServer.vidcloud,
                        ),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                _ServerOption(
                  title: 'UpCloud',
                  subtitle: 'Good for movies',
                  isSelected:
                      settings.preferredServer ==
                      domain.PreferredServer.upcloud,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                          preferredServer: domain.PreferredServer.upcloud,
                        ),
                      ),
                    );
                    Navigator.pop(bottomSheetContext);
                  },
                ),
                _ServerOption(
                  title: 'MegaUp',
                  subtitle: 'Alternative server',
                  isSelected:
                      settings.preferredServer == domain.PreferredServer.megaup,
                  onTap: () {
                    settingsBloc.add(
                      UpdateSettings(
                        settings.copyWith(
                          preferredServer: domain.PreferredServer.megaup,
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
    );
  }

  Widget _buildProviderSelector(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Anime Source'),
          subtitle: Text(settings.animeProvider.toUpperCase()),
          leading: const Icon(Icons.animation),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _showProviderSheet(context, isMovie: false);
          },
        ),
        ListTile(
          title: const Text('Movie Source'),
          subtitle: Text(settings.movieProvider.toUpperCase()),
          leading: const Icon(Icons.movie),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _showProviderSheet(context, isMovie: true);
          },
        ),
      ],
    );
  }

  void _showProviderSheet(BuildContext context, {required bool isMovie}) {
    _minimizePlayer(context);
    final settingsBloc = context.read<SettingsBloc>();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // Show above miniplayer
      builder: (bottomSheetContext) => BlocProvider.value(
        value: settingsBloc,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: isMovie
              ? [
                  _ProviderOption(
                    id: 'flixhq',
                    label: 'FlixHQ (Recommended)',
                    settings: settings,
                    isMovie: true,
                    bloc: settingsBloc,
                  ),
                  _ProviderOption(
                    id: 'viewasian',
                    label: 'ViewAsian / DramaCool',
                    settings: settings,
                    isMovie: true,
                    bloc: settingsBloc,
                  ),
                ]
              : [
                  _ProviderOption(
                    id: 'animepahe',
                    label: 'AnimePahe (Recommended)',
                    settings: settings,
                    isMovie: false,
                    bloc: settingsBloc,
                  ),
                  _ProviderOption(
                    id: 'gogoanime',
                    label: 'GogoAnime (Stable)',
                    settings: settings,
                    isMovie: false,
                    bloc: settingsBloc,
                  ),
                  _ProviderOption(
                    id: 'zoro',
                    label: 'Zoro / HiAnime (Best Quality)',
                    settings: settings,
                    isMovie: false,
                    bloc: settingsBloc,
                  ),
                  _ProviderOption(
                    id: 'animekai',
                    label: 'AnimeKai',
                    settings: settings,
                    isMovie: false,
                    bloc: settingsBloc,
                  ),
                ],
        ),
      ),
    );
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
}

class _ServerOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServerOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: onTap,
    );
  }
}

class _ProviderOption extends StatelessWidget {
  final String id;
  final String label;
  final domain.AppSettings settings;
  final bool isMovie;
  final SettingsBloc bloc;

  const _ProviderOption({
    required this.id,
    required this.label,
    required this.settings,
    required this.isMovie,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = isMovie
        ? settings.movieProvider == id
        : settings.animeProvider == id;

    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
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
}
