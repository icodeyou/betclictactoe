import 'package:betclictactoe/presentation/game/ui/cell_view.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: AppConstants.gridSize,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: List.generate(
            AppConstants.gridSize * AppConstants.gridSize,
            (i) =>
                CellView(index: i, animationController: _animationController),
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
