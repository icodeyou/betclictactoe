import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/settings/ui/custom_name_dialog.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioControllerNotifier = ref.watch(audioControllerProvider.notifier);
    final audioControllerState = ref.watch(audioControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Permanent Marker',
            fontSize: 45,
            height: 1,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundSettings,
      body: SafeArea(
        child: Column(
          spacing: 60,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: ListView(
                  children: [
                    _NameChangeLine(t.settingsScreen.nameLabel),
                    _SettingsLine(
                      t.settingsScreen.soundFXLabel,
                      Icon(
                        audioControllerState.sfxOn
                            ? Icons.graphic_eq
                            : Icons.volume_off,
                      ),
                      onSelected: () {
                        audioControllerNotifier.toggleSound();
                      },
                    ),
                    _SettingsLine(
                      t.settingsScreen.musicLabel,
                      Icon(
                        audioControllerState.musicOn
                            ? Icons.music_note
                            : Icons.music_off,
                      ),
                      onSelected: () {
                        audioControllerNotifier.toggleMusic();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Text(t.settingsScreen.credits),
          ],
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
            const Spacer(),
            Text(
              t
                  .settingsScreen
                  .defaultName, // TODO : Get value from shared preferences, and change with dialog
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
