import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin IPlayNotifier {
  void tick(Cell index, Future<void> Function() winningAnimationCallback);

  /// Returns true if one player has won
  bool handleWinning(
    Ref ref,
    Board newBoard,
    bool isXTurn,
    Future<void> Function() winningAnimationCallback,
  ) {
    final audioController = ref.read(audioControllerProvider.notifier);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    final winningIndexes = newBoard.getWinningIndexes();
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
