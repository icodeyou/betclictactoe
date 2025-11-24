import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/game/ui/play_view.dart';
import 'package:betclictactoe/presentation/game/ui/score_view.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_sizes.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_back_button.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_text.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key, required this.againstAI});

  final bool againstAI;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        leading: AppBackButton(),
        title: AppText(
          t.gameScreen.title,
          textAlign: TextAlign.center,
          fontFamily: AppConstants.titleFont,
          fontSize: 45,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ThemeSizes.m.asInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: ThemeSizes.xs,
            children: [
              ScoreView(againstAI: againstAI),
              SizedBox(height: ThemeSizes.m),
              PlayView(againstAI: againstAI),
            ],
          ),
        ),
      ),
    );
  }
}
