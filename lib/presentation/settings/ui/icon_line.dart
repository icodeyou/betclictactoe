import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
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
      child: Padding(
        padding: ThemeSizes.l.asInsets.horizontalOnly,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
