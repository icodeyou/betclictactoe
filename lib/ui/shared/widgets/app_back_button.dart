import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BackButton(
        style: ButtonStyle(iconSize: WidgetStateProperty.all(45)),
      ),
    );
  }
}
