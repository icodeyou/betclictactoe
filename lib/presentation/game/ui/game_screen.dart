import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/game/notifier/play_notifier.dart';
import 'package:betclictactoe/presentation/game/ui/play_view.dart';
import 'package:betclictactoe/presentation/game/ui/score_view.dart';
import 'package:betclictactoe/presentation/shared/theme/app_colors.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_back_button.dart';
import 'package:betclictactoe/presentation/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: AppBackButton(),
        title: Text(
          t.playScreen.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Permanent Marker',
            fontSize: 45,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              ScoreView(),
              SizedBox(height: 16),
              Expanded(child: Center(child: PlayView())),
              AppButton(
                onPressed: () {
                  ref.invalidate(playNotifierProvider);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Icon(Icons.replay, size: 24),
                    Text(t.playScreen.restartButtonLabel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
