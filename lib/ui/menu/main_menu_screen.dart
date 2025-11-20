import 'package:betclictactoe/app/routing/paths.dart';
import 'package:betclictactoe/theme/colors.dart';
import 'package:betclictactoe/ui/shared/controllers/audio_controller.dart';
import 'package:betclictactoe/ui/shared/widgets/app_button.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 10,
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
                        fontFamily: 'Permanent Marker',
                        fontSize: 55,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
              AppButton(
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
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
                  onPressed: () {
                    // TODO: Call notifier
                  },
                  // TODO: Get value from notifier
                  icon: Icon(true ? Icons.volume_up : Icons.volume_off),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
