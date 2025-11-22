import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameOptionsView extends ConsumerWidget {
  const GameOptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            ' ${gameState.playerName} ${t.gameScreen.playFirstLabel}',
            maxLines: 2,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: gameState.isPlayingFirstWithX
                  ? Theme.of(context).colorScheme.primary
                  : AppColors.darkText,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Switch(
          value: gameState.isPlayingFirstWithX,
          onChanged: (newValue) {
            gameNotifier.togglePlayingFirst();
          },
        ),
      ],
    );
  }
}
