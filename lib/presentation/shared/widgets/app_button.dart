import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;

  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final bool overDarkBackground;

  const AppButton({
    super.key,
    required this.child,
    this.onPressed,
    this.foregroundColor,
    this.overDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        foregroundColor: foregroundColor ?? (overDarkBackground ? AppColors.primary : null),
        backgroundColor: overDarkBackground ? Colors.white : null,
      ),
      child: child,
    );
  }
}
