import 'package:betclictactoe/presentation/game/notifier/play_notifier.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellView extends ConsumerWidget {
  const CellView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playState = ref.watch(playNotifierProvider);
    final playStateNotifier = ref.watch(playNotifierProvider.notifier);
    final emptyCell =
        !playState.xTicks.contains(index) && !playState.oTicks.contains(index);
    return InkWell(
      onTap: emptyCell
          ? () {
              playStateNotifier.tick(index);
            }
          : null,
      child: Container(
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
            : null,
        child: Builder(
          builder: (context) {
            if (playState.xTicks.contains(index)) {
              return Center(child: Text('X'));
            } else if (playState.oTicks.contains(index)) {
              return Center(child: Text('O'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
