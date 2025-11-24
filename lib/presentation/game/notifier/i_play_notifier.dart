import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin IPlayNotifier {
  void tick(int index, Future<void> Function() winningAnimationCallback);

  /// Returns true if one player has won
  bool handleWinning(
    Ref ref,
    PlayState newPlayState,
    bool isXTurn,
    Future<void> Function() winningAnimationCallback,
  ) {
    final audioController = ref.read(audioControllerProvider.notifier);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    final winningIndexes = newPlayState.getWinningIndexes();
    if (winningIndexes.isEmpty) {
      audioController.playSfx(isXTurn ? SfxType.xTick : SfxType.yTick);
      return false;
    }

    audioController.playSfx(SfxType.congrats);

    winningAnimationCallback().then((_) {
      gameNotifier.incrementScore(isXTurn: isXTurn);
      ref.invalidateSelf();
    });
    return true;
  }
}
