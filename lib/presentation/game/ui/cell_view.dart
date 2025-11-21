import 'package:betclictactoe/presentation/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class CellView extends StatelessWidget {
  const CellView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Cell tapped');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: RadialGradient(
            // small offset from center
            center: const Alignment(0.3, 0.3),
            colors: [
              AppColors.primary.withAlpha(20),
              AppColors.primary.withAlpha(60),
            ],
          ),
        ),
      ),
    );
  }
}
