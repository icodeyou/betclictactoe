import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/settings/notifier/settings_notifier.dart';
import 'package:betclictactoe/presentation/settings/ui/icon_line.dart';
import 'package:betclictactoe/presentation/settings/ui/string_line.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioNotifier = ref.read(audioControllerProvider.notifier);
    final audioState = ref.watch(audioControllerProvider);

    final playerName = ref.watch(settingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        title: Text(
          t.settingsScreen.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Permanent Marker',
            fontSize: 45,
            height: 1,
          ),
        ),
      ),
      backgroundColor: ThemeColors.backgroundSettings,
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
                    StringLine(
                      title: t.settingsScreen.nameLabel,
                      value: playerName,
                    ),
                    IconLine(
                      title: t.settingsScreen.soundFXLabel,
                      icon: Icon(
                        audioState.sfxOn ? Icons.graphic_eq : Icons.volume_off,
                      ),
                      onSelected: () {
                        audioNotifier.toggleSound();
                      },
                    ),
                    IconLine(
                      title: t.settingsScreen.musicLabel,
                      icon: Icon(
                        audioState.musicOn ? Icons.music_note : Icons.music_off,
                      ),
                      onSelected: () {
                        audioNotifier.toggleMusic();
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
