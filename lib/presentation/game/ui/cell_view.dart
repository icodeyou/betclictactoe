import 'package:betclictactoe/presentation/game/notifier/play_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellView extends ConsumerWidget {
  const CellView({
    super.key,
    required this.index,
    required this.animationController,
  });

  final int index;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playState = ref.watch(playNotifierProvider);
    final playStateNotifier = ref.watch(playNotifierProvider.notifier);
    final emptyCell =
        !playState.xTicks.contains(index) && !playState.oTicks.contains(index);

    return InkWell(
      onTap: emptyCell && !animationController.isAnimating
          ? () {
              playStateNotifier.tick(index, () async {
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
                        AppColors.primary.withAlpha(20),
                        AppColors.primary.withAlpha(60),
                      ],
                    ),
                  )
                : BoxDecoration(
                    color: AppColors.primary.withAlpha(
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
                        child: Text(
                          xTick ? 'X' : 'O',
                          style: TextStyle(
                            fontSize: 64,
                            fontFamily: 'luckiest_guy',
                            fontWeight: FontWeight.bold,
                            color: animationValue == 0
                                ? AppColors.primary
                                : Colors.white,
                          ),
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
