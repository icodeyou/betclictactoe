import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GameOptionsView extends StatelessWidget {
  const GameOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          "I am playing first with X",

          style: TextStyle(
            color: AppColors.darkText,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Switch(
          value: true,
          onChanged: (newValue) {
            print(newValue);
          },
        ),
      ],
    );
  }
}
