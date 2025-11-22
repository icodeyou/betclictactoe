import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/ui/game_options_view.dart';
import 'package:betclictactoe/presentation/game/ui/points_view.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreView extends ConsumerWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.background,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.secondary.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: ThemeSizes.m.asInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: ThemeSizes.xs,
          children: [
            Row(
              children: [
                Expanded(
                  child: PointsView(
                    player: gameState.playerName,
                    points: gameState.playerScore,
                    color: ThemeColors.primary,
                  ),
                ),
                Expanded(
                  child: PointsView(
                    player: t.gameScreen.friendScoreLabel,
                    points: gameState.friendScore,
                    color: ThemeColors.darkText,
                  ),
                ),
              ],
            ),
            Divider(),
            GameOptionsView(),
          ],
        ),
      ),
    );
  }
}
