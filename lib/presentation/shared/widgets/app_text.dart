import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    required this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.center,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final double fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? ThemeColors.darkText,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
