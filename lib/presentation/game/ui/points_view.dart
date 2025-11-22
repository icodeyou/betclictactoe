import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PointsView extends StatelessWidget {
  const PointsView({
    super.key,
    required this.player,
    required this.points,
    required this.color,
  });

  final String player;
  final int points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          player,
          fontSize: ThemeFontSizes.m,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        AppText(
          points.toString(),
          fontSize: ThemeFontSizes.xl,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ],
    );
  }
}
