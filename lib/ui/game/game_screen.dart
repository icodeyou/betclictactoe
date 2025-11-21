import 'package:betclictactoe/theme/colors.dart';
import 'package:betclictactoe/ui/game/play_view.dart';
import 'package:betclictactoe/ui/shared/widgets/app_back_button.dart';
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
