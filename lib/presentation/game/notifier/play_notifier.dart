import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playNotifierProvider =
    NotifierProvider.autoDispose<PlayNotifier, PlayState>(() => PlayNotifier());

class PlayState {
  PlayState({required this.xTicks, required this.oTicks});

  /// The list of the indexes corresponding to all the ticks from the beginning
  /// of the game, in chronological order, for x and o players.
  final List<int> xTicks;
  final List<int> oTicks;

  List<int> getWinningIndexes() {
    // Winning positions
    const winningPositions = [
      // Horizontal
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Vertical
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonal
      [0, 4, 8],
      [2, 4, 6],
    ];

    final winningIndexes = <int>[];

    for (final position in winningPositions) {
      if (position.every((index) => xTicks.contains(index)) ||
          position.every((index) => oTicks.contains(index))) {
        winningIndexes.addAll(position);
      }
    }
    return winningIndexes;
  }

  bool isXTurn() {
    return xTicks.length == oTicks.length;
  }
}

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

    // Play sound

    if (isXTurn) {
      state = PlayState(xTicks: [...state.xTicks, index], oTicks: state.oTicks);
    } else {
      state = PlayState(xTicks: state.xTicks, oTicks: [...state.oTicks, index]);
    }

    final winningIndexes = state.getWinningIndexes();
    if (winningIndexes.isEmpty) {
      ref
          .read(audioControllerProvider.notifier)
          .playSfx(isXTurn ? SfxType.huhsh : SfxType.wssh);
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
