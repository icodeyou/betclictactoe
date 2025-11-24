import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/notifier/play_ai_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_friend_notifier.dart';
import 'package:betclictactoe/presentation/game/ui/cell_view.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_button.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayView extends ConsumerStatefulWidget {
  const PlayView({super.key, required this.againstAI});

  final bool againstAI;

  @override
  ConsumerState<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends ConsumerState<PlayView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final boardAsync = widget.againstAI
        ? ref.watch(playAINotifierProvider)
        : null;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: GridView.count(
            crossAxisCount: AppConstants.gridSize,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: ThemeSizes.xs,
            crossAxisSpacing: ThemeSizes.xs,
            children: List.generate(
              AppConstants.gridSize * AppConstants.gridSize,
              (i) => CellView(
                cellPosition: Cell(
                  i % AppConstants.gridSize,
                  i ~/ AppConstants.gridSize,
                ),
                animationController: _animationController,
                againstAI: widget.againstAI,
              ),
            ),
          ),
        ),
        AppButton(
          onPressed:
              boardAsync?.isLoading == true || _animationController.isAnimating
              ? null
              : () {
                  if (widget.againstAI) {
                    ref.invalidate(playAINotifierProvider);
                  } else {
                    ref.invalidate(playFriendNotifierProvider);
                  }
                },
          text: t.gameScreen.restartButtonLabel,
          icon: Icons.replay,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
