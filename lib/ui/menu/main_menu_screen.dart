import 'package:betclictactoe/app/routing/paths.dart';
import 'package:betclictactoe/theme/colors.dart';
import 'package:betclictactoe/ui/shared/controllers/audio_controller.dart';
import 'package:betclictactoe/ui/shared/widgets/app_button.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioControllerNotifier = ref.watch(audioControllerProvider.notifier);
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
                      'Betclic \nTic Tac Toe',
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
                onPressed: () {
                  audioControllerNotifier.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).goNamed(Paths.game.name);
                },
                child: const Text('Play'),
              ),
              AppButton(
                onPressed: () =>
                    GoRouter.of(context).goNamed(Paths.settings.name),
                child: const Text('Settings'),
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
