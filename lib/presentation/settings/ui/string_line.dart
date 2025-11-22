import 'package:betclictactoe/presentation/settings/ui/custom_name_dialog.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            title,
            fontFamily: AppConstants.titleFont,
            fontSize: ThemeFontSizes.xl,
          ),
          const Spacer(),
          AppText(
            value,
            fontFamily: AppConstants.titleFont,
            fontSize: ThemeFontSizes.xl,
          ),
        ],
      ),
    );
  }
}
