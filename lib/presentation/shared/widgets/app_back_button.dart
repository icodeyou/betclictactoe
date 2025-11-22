import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ThemeSizes.xs.asInsets.horizontalOnly,
      child: BackButton(
        style: ButtonStyle(iconSize: WidgetStateProperty.all(45)),
      ),
    );
  }
}
