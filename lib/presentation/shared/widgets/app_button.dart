import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final audioControllerNotifier = ref.read(audioControllerProvider.notifier);
    return FilledButton(
      onPressed: () {
        audioControllerNotifier.playSfx(SfxType.buttonTap);
        onPressed?.call();
      },
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
