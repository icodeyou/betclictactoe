import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/app/routing/paths.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_button.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
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
      backgroundColor: ThemeColors.backgroundHome,
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: ThemeSizes.xl,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Transform.rotate(
                    angle: -0.1,
                    child: const AppText(
                      AppConstants.fullAppName,
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      fontFamily: AppConstants.titleFont,
                      fontSize: 55,
                    ),
                  ),
                ),
              ),
              AppButton(
                overDarkBackground: true,
                foregroundColor: ThemeColors.secondary,
                onPressed: () {
                  audioControllerNotifier.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).goNamed(Paths.game.name);
                },
                text: t.homeScreen.playButtonLabel,
              ),
              AppButton(
                onPressed: () {
                  audioControllerNotifier.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).goNamed(Paths.settings.name);
                },
                text: t.homeScreen.settingsButtonLabel,
              ),
              Padding(
                padding: ThemeSizes.xxl.asInsets.topOnly,
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
