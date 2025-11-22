import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.foregroundColor,
    this.overDarkBackground = false,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final bool overDarkBackground;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: ThemeSizes.xxl,
          vertical: ThemeSizes.m,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: overDarkBackground ? Colors.white : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: ThemeSizes.s,
        children: [
          if (icon != null) ...[Icon(icon!, size: 24)],
          AppText(
            text,
            fontSize: ThemeFontSizes.l,
            fontWeight: FontWeight.bold,
            color:
                foregroundColor ??
                (overDarkBackground ? ThemeColors.primary : Colors.white),
          ),
        ],
      ),
    );
  }
}
