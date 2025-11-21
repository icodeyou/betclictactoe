import 'package:betclictactoe/presentation/game/ui/cell_view.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

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
            (index) => const CellView(),
          ),
        ),
      ),
    );
  }
}
