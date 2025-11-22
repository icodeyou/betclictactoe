import 'package:betclictactoe/presentation/settings/ui/custom_name_dialog.dart';
import 'package:flutter/material.dart';

class StringLine extends StatelessWidget {
  const StringLine({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
