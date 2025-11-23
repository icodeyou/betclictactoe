import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_ai_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_friend_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellView extends ConsumerWidget {
  const CellView({
    super.key,
    required this.index,
    required this.animationController,
    required this.againstAI,
  });

  final int index;
  final AnimationController animationController;
  final bool againstAI;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlayState playState;
    final IPlayNotifier iPlayNotifier;
    if (againstAI) {
      iPlayNotifier = ref.read(playAINotifierProvider.notifier);
      final playStateAsync = ref.watch(playAINotifierProvider);
      if (playStateAsync.value == null) {
        logger.e('@build: playStateAsync.value is null');
        return const SizedBox.shrink();
      } else {
        playState = playStateAsync.value!;
      }
    } else {
      iPlayNotifier = ref.read(playFriendNotifierProvider.notifier);
      playState = ref.watch(playFriendNotifierProvider);
    }
    final emptyCell =
        !playState.xTicks.contains(index) && !playState.oTicks.contains(index);

    return InkWell(
      onTap: emptyCell && !animationController.isAnimating
          ? () {
              iPlayNotifier.tick(index, () async {
                await animationController.repeat(reverse: true, count: 8);
              });
            }
          : null,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final double animationValue;
          if (playState.getWinningIndexes().contains(index)) {
            animationValue = animationController.value;
          } else {
            animationValue = 0;
          }
          return Container(
            decoration: emptyCell
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: RadialGradient(
                      // small offset from center
                      center: const Alignment(0.3, 0.3),
                      colors: [
                        ThemeColors.secondary.withAlpha(20),
                        ThemeColors.secondary.withAlpha(60),
                      ],
                    ),
                  )
                : BoxDecoration(
                    color: ThemeColors.secondary.withAlpha(
                      (200 * animationValue).toInt(),
                    ),
                    shape: BoxShape.circle,
                  ),
            child: Builder(
              builder: (context) {
                final xTick = playState.xTicks.contains(index);
                final oTick = playState.oTicks.contains(index);
                if (xTick || oTick) {
                  return Center(
                    child: Transform.scale(
                      scale: 1 + 0.2 * animationValue,
                      child: Transform.translate(
                        offset: Offset(0, 8),
                        child: AppText(
                          xTick ? 'X' : 'O',
                          fontSize: 64,
                          fontFamily: AppConstants.tictactoeFont,
                          fontWeight: FontWeight.bold,
                          color: animationValue == 0
                              ? ThemeColors.secondary
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
