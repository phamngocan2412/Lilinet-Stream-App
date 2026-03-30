import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';
import '../../domain/entities/app_settings.dart' as domain;
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import 'pin_code_dialog.dart';
import 'settings_section.dart';

class ContentSettingsSection extends StatelessWidget {
  final domain.AppSettings settings;

  const ContentSettingsSection({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Content',
      icon: Icons.visibility,
      children: [
        SwitchListTile(
          title: const Text('Adult Content'),
          subtitle: const Text('Show adult content'),
          value: settings.adultContent,
          onChanged: (value) async {
            // Minimize player before showing PIN dialog
            getIt<VideoPlayerBloc>().add(MinimizeVideo());

            final bloc = context.read<SettingsBloc>();

            if (value) {
              // Enabling: Require PIN setup or verify
              if (settings.pinCode == null) {
                // Setup PIN
                final newPin = await PinCodeDialog.showSetPin(context);
                if (newPin != null) {
                  bloc.add(
                    UpdateSettings(
                      settings.copyWith(adultContent: true, pinCode: newPin),
                    ),
                  );
                }
              } else {
                // Verify PIN
                final isVerified = await PinCodeDialog.show(
                  context,
                  currentPin: settings.pinCode,
                );
                if (isVerified == true) {
                  bloc.add(
                    UpdateSettings(settings.copyWith(adultContent: true)),
                  );
                }
              }
            } else {
              // Disabling: Just disable
              bloc.add(UpdateSettings(settings.copyWith(adultContent: false)));
            }
          },
        ),
        if (settings.pinCode != null)
          ListTile(
            title: const Text('Change PIN'),
            leading: const Icon(Icons.lock_outline),
            onTap: () async {
              // Minimize player before showing PIN dialog
              getIt<VideoPlayerBloc>().add(MinimizeVideo());

              // Verify old PIN first
              final isVerified = await PinCodeDialog.show(
                context,
                currentPin: settings.pinCode,
              );
              if (isVerified == true && context.mounted) {
                // Set new PIN
                final newPin = await PinCodeDialog.showSetPin(context);
                if (!context.mounted) return;

                if (newPin != null) {
                  context.read<SettingsBloc>().add(
                    UpdateSettings(settings.copyWith(pinCode: newPin)),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN updated successfully')),
                  );
                }
              }
            },
          ),
      ],
    );
  }
}
