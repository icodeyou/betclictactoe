import 'dart:math';

import 'package:betclictactoe/presentation/game/notifier/play_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellView extends ConsumerStatefulWidget {
  const CellView({super.key, required this.index});

  final int index;

  @override
  ConsumerState<CellView> createState() => _CellViewState();
}

class _CellViewState extends ConsumerState<CellView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final animationProgress = CurvedAnimation(
    parent: _animationController,
    curve: Curves.decelerate,
  );

  @override
  Widget build(BuildContext context) {
    final playState = ref.watch(playNotifierProvider);
    final playStateNotifier = ref.watch(playNotifierProvider.notifier);
    final emptyCell =
        !playState.xTicks.contains(widget.index) &&
        !playState.oTicks.contains(widget.index);

    return InkWell(
      onTap: emptyCell
          ? () {
              playStateNotifier.tick(widget.index);
              if (Random().nextInt(5) == 3) {
                _finalAnimation();
              }
            }
          : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
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
                      (200 * animationProgress.value).toInt(),
                    ),
                    shape: BoxShape.circle,
                  ),
            child: Builder(
              builder: (context) {
                final xTick = playState.xTicks.contains(widget.index);
                final oTick = playState.oTicks.contains(widget.index);
                if (xTick || oTick) {
                  return Center(
                    child: Text(
                      xTick ? 'X' : 'O',
                      style: TextStyle(
                        fontSize: 64,
                        fontFamily: 'luckiest_guy',
                        fontWeight: FontWeight.bold,
                        color: _animationController.isAnimating
                            ? Colors.white
                            : AppColors.primary,
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _finalAnimation() async {
    await _animationController.repeat(reverse: true, count: 10);
    ref.invalidate(playNotifierProvider);
  }
}
