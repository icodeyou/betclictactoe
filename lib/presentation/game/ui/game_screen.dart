import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:betclictactoe/presentation/game/ui/play_view.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(leading: AppBackButton()),
      body: Center(child: PlayView()),
    );
  }
}
