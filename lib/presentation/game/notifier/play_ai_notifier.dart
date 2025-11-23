import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playAINotifierProvider =
    AsyncNotifierProvider.autoDispose<PlayAINotifier, PlayState>(
      () => PlayAINotifier(),
    );

class PlayAINotifier extends AsyncNotifier<PlayState> implements IPlayNotifier {
  GameNotifier get _gameNotifier => ref.read(gameNotifierProvider.notifier);
  AudioController get _audioController =>
      ref.read(audioControllerProvider.notifier);

  @override
  Future<PlayState> build() async {
    return PlayState(xTicks: [], oTicks: []);
  }

  @override
  void tick(int index, Future<void> Function() winningAnimationCallback) {
    if (state.value == null) {
      logger.e('@tick Cannot tick while in loading or error state');
      return;
    }
    final playState = state.value!;

    final mainPlayerPlayingX = playState.isXTurn();

    final newPlayState = PlayState(
      xTicks: mainPlayerPlayingX
          ? [...playState.xTicks, index]
          : playState.xTicks,
      oTicks: mainPlayerPlayingX
          ? playState.oTicks
          : [...playState.oTicks, index],
    );

    state = AsyncData(newPlayState);

    final somebodyWon = _handleWinning(
      newPlayState,
      mainPlayerPlayingX,
      winningAnimationCallback,
    );

    if (!somebodyWon) {
      _startAIPlay(aiPlayingWithX: !mainPlayerPlayingX).then((_) {
        _handleWinning(
          state.value!,
          !mainPlayerPlayingX,
          winningAnimationCallback,
        );
      });
    }
  }

  /// Returns true if one player has won
  bool _handleWinning(
    PlayState newPlayState,
    bool isXTurn,
    Future<void> Function() winningAnimationCallback,
  ) {
    final winningIndexes = newPlayState.getWinningIndexes();
    if (winningIndexes.isEmpty) {
      ref
          .read(audioControllerProvider.notifier)
          .playSfx(isXTurn ? SfxType.xTick : SfxType.yTick);
      return false;
    }

    _audioController.playSfx(SfxType.congrats);

    _gameNotifier.incrementScore(isXTurn: isXTurn);

    winningAnimationCallback().then((_) {
      ref.invalidateSelf();
    });
    return true;
  }

  Future<void> _startAIPlay({required bool aiPlayingWithX}) async {
    if (state.value == null) {
      logger.e('@aiPlay: Cannot play while in loading or error state');
      return;
    }
    final playState = state.value!;

    state = AsyncLoading();

    final allIndexes = List<int>.generate(9, (index) => index);
    final takenIndexes = [...playState.xTicks, ...playState.oTicks];
    final availableIndexes = allIndexes
        .where((index) => !takenIndexes.contains(index))
        .toList();

    if (availableIndexes.isEmpty) {
      return;
    }

    // Replace by repo
    await Future.delayed(const Duration(milliseconds: 1000));
    final aiIndex = availableIndexes.first;

    state = AsyncData(
      PlayState(
        xTicks: aiPlayingWithX
            ? [...playState.xTicks, aiIndex]
            : playState.xTicks,
        oTicks: aiPlayingWithX
            ? playState.oTicks
            : [...playState.oTicks, aiIndex],
      ),
    );
  }

  void _winning() {}
}
