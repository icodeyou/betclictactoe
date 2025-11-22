import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GameOptionsView extends StatelessWidget {
  const GameOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Switch(
          value: true,
          onChanged: (newValue) {
            print(newValue);
          },
        ),
        Text(
          "I am playing first",

          style: TextStyle(
            color: AppColors.darkText,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
