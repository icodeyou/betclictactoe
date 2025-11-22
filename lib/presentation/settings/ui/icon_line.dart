import 'package:betclictactoe/presentation/shared/theme/theme_font_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';

class IconLine extends StatelessWidget {
  const IconLine({
    super.key,
    required this.title,
    required this.icon,
    this.onSelected,
  });

  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AppText(
              title,
              maxLines: 1,
              fontFamily: AppConstants.titleFont,
              fontSize: ThemeFontSizes.xl,
              textAlign: TextAlign.start,
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
