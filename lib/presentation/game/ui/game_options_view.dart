import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameOptionsView extends ConsumerWidget {
  const GameOptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);
    return Row(
      spacing: ThemeSizes.xs,
      children: [
        Expanded(
          child: AppText(
            t.gameScreen.playFirstLabel,
            maxLines: 2,
            textAlign: TextAlign.right,
            color: gameState.isPlayingFirstWithX
                ? Theme.of(context).colorScheme.primary
                : ThemeColors.darkText,
            fontSize: ThemeFontSizes.m,
            fontWeight: FontWeight.w300,
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
