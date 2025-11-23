import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playNotifierProvider =
    NotifierProvider.autoDispose<PlayNotifier, PlayState>(() => PlayNotifier());

class PlayNotifier extends Notifier<PlayState> {
  GameNotifier get _gameNotifier => ref.read(gameNotifierProvider.notifier);
  AudioController get _audioController =>
      ref.read(audioControllerProvider.notifier);

  @override
  PlayState build() {
    return PlayState(xTicks: [], oTicks: []);
  }

  void tick(int index, Future<void> Function() winningAnimationCallback) {
    final isXTurn = state.isXTurn();

    if (isXTurn) {
      state = PlayState(xTicks: [...state.xTicks, index], oTicks: state.oTicks);
    } else {
      state = PlayState(xTicks: state.xTicks, oTicks: [...state.oTicks, index]);
    }

    final winningIndexes = state.getWinningIndexes();
    if (winningIndexes.isEmpty) {
      ref
          .read(audioControllerProvider.notifier)
          .playSfx(isXTurn ? SfxType.xTick : SfxType.yTick);
      return;
    }

    _audioController.playSfx(SfxType.congrats);

    _gameNotifier.incrementScore(isXTurn: isXTurn);

    winningAnimationCallback().then((_) {
      ref.invalidateSelf();
    });
  }

  Future<void> launchAnimation(AnimationController animationController) async {
    await animationController.forward();
    await animationController.reverse();
  }
}
