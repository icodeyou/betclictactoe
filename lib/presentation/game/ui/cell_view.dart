import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_ai_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_friend_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellView extends ConsumerWidget {
  const CellView({
    super.key,
    required this.cellPosition,
    required this.animationController,
    required this.againstAI,
  });

  final Cell cellPosition;
  final AnimationController animationController;
  final bool againstAI;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Board board;
    final IPlayNotifier iPlayNotifier;
    bool isComputerThinking = false;
    if (againstAI) {
      iPlayNotifier = ref.read(playAINotifierProvider.notifier);
      final boardAsync = ref.watch(playAINotifierProvider);
      isComputerThinking = boardAsync.isLoading;
      if (boardAsync.value == null) {
        logger.e('@build: boardAsync.value is null');
        return const SizedBox.shrink();
      } else {
        board = boardAsync.value!;
      }
    } else {
      iPlayNotifier = ref.read(playFriendNotifierProvider.notifier);
      board = ref.watch(playFriendNotifierProvider);
    }
    final tickedCell =
        board.xPlayed.contains(cellPosition) ||
        board.oPlayed.contains(cellPosition);

    return InkWell(
      onTap: tickedCell || animationController.isAnimating || isComputerThinking
          ? null
          : () {
              iPlayNotifier.tick(cellPosition, () async {
                await animationController.repeat(reverse: true, count: 9);
              });
            },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final double animationValue;
          if (board.getWinningIndexes().contains(cellPosition)) {
            animationValue = animationController.value;
          } else {
            animationValue = 0;
          }

          final cellColor =
              isComputerThinking || animationController.isAnimating
              ? ThemeColors.darkSecondary
              : ThemeColors.secondary;
          return Container(
            decoration: tickedCell
                ? BoxDecoration(
                    color: ThemeColors.secondary.withAlpha(
                      (200 * animationValue).toInt(),
                    ),
                    shape: BoxShape.circle,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: RadialGradient(
                      // small offset from center
                      center: const Alignment(0.3, 0.3),
                      colors: [
                        cellColor.withAlpha(20),
                        cellColor.withAlpha(60),
                      ],
                    ),
                  ),
            child: Builder(
              builder: (context) {
                final xTick = board.xPlayed.contains(cellPosition);
                final oTick = board.oPlayed.contains(cellPosition);
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
