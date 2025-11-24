import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/ui/cell_view.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';

class PlayView extends StatefulWidget {
  const PlayView({super.key, required this.againstAI});

  final bool againstAI;

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              i ~/ AppConstants.gridSize,
              i % AppConstants.gridSize,
            ),
            animationController: _animationController,
            againstAI: widget.againstAI,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
