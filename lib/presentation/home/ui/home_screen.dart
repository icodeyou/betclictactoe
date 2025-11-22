import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/app/routing/paths.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_button.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioControllerNotifier = ref.read(audioControllerProvider.notifier);
    final audioControllerState = ref.watch(audioControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundHome,
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 24,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Transform.rotate(
                    angle: -0.1,
                    child: const Text(
                      AppConstants.fullAppName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Permanent Marker',
                        fontSize: 55,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
              AppButton(
                overDarkBackground: true,
                foregroundColor: AppColors.secondary,
                onPressed: () {
                  audioControllerNotifier.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).goNamed(Paths.game.name);
                },
                child: Text(t.homeScreen.playButtonLabel),
              ),
              AppButton(
                onPressed: () =>
                    GoRouter.of(context).goNamed(Paths.settings.name),
                child: Text(t.homeScreen.settingsButtonLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    audioControllerNotifier.toggleAudio();
                  },
                  icon: Icon(
                    audioControllerState.audioOn
                        ? Icons.volume_up
                        : Icons.volume_off,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
