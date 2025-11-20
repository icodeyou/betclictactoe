import 'package:betclictactoe/theme/colors.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.playBackground,
      body: Center(child: Text('Game Screen')),
    );
  }
}
