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
        const Text(
          "I am playing first",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
