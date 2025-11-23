import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:betclictactoe/presentation/shared/controller/audio_controller.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playAINotifierProvider =
    AsyncNotifierProvider.autoDispose<PlayAINotifier, PlayState>(
      () => PlayAINotifier(),
    );

class PlayAINotifier extends AsyncNotifier<PlayState> {
  GameNotifier get _gameNotifier => ref.read(gameNotifierProvider.notifier);
  AudioController get _audioController =>
      ref.read(audioControllerProvider.notifier);

  @override
  Future<PlayState> build() async {
    return PlayState(xTicks: [], oTicks: []);
  }

  void tick(int index, Future<void> Function() winningAnimationCallback) {
    if (state.value == null) {
      logger.e('@tick Cannot tick while in loading or error state');
      return;
    }
    final playState = state.value!;

    final isXTurn = playState.isXTurn();

    state = AsyncData(
      PlayState(
        xTicks: isXTurn ? [...playState.xTicks, index] : playState.xTicks,
        oTicks: isXTurn ? playState.oTicks : [...playState.oTicks, index],
      ),
    );

    startAIPlay(aiPlayingWithX: isXTurn);

    final winningIndexes = playState.getWinningIndexes();
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

  Future<void> startAIPlay({required bool aiPlayingWithX}) async {
    if (state.value == null) {
      logger.e('@aiPlay: Cannot play while in loading or error state');
      return;
    }
    final playState = state.value!;

    state = AsyncLoading();

    // Replace by repo
    final allIndexes = List<int>.generate(9, (index) => index);
    final takenIndexes = [...playState.xTicks, ...playState.oTicks];
    final availableIndexes = allIndexes
        .where((index) => !takenIndexes.contains(index))
        .toList();

    if (availableIndexes.isEmpty) {
      return;
    }

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
}
