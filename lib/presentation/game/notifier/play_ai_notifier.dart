import 'dart:math';

import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playAINotifierProvider =
    AsyncNotifierProvider.autoDispose<PlayAINotifier, Board>(
      () => PlayAINotifier(),
    );

class PlayAINotifier extends AsyncNotifier<Board> with IPlayNotifier {
  @override
  Future<Board> build() async {
    final gameState = ref.watch(gameNotifierProvider);
    if (!gameState.isPlayingFirstWithX) {
      // TODO : Call repo
      await Future.delayed(const Duration(milliseconds: 500));
      final firstCellAI = Cell(Random().nextInt(3), Random().nextInt(3));
      return Board(xPlayed: [firstCellAI], oPlayed: []);
    }
    return Board(xPlayed: [], oPlayed: []);
  }

  @override
  void tick(
    Cell cellPosition,
    Future<void> Function() winningAnimationCallback,
  ) {
    if (state.value == null) {
      logger.e('@tick Cannot tick while in loading or error state');
      return;
    }
    final board = state.value!;

    final mainPlayerPlayingX = board.isXTurn();

    final newBoard = Board(
      xPlayed: mainPlayerPlayingX
          ? [...board.xPlayed, cellPosition]
          : board.xPlayed,
      oPlayed: mainPlayerPlayingX
          ? board.oPlayed
          : [...board.oPlayed, cellPosition],
    );

    state = AsyncData(newBoard);

    final somebodyWon = handleWinning(
      ref,
      newBoard,
      mainPlayerPlayingX,
      winningAnimationCallback,
    );

    if (!somebodyWon) {
      _startAIPlay(aiPlayingWithX: !mainPlayerPlayingX).then((_) {
        handleWinning(
          ref,
          state.value!,
          !mainPlayerPlayingX,
          winningAnimationCallback,
        );
      });
    }
  }

  Future<void> _startAIPlay({required bool aiPlayingWithX}) async {
    if (state.value == null) {
      logger.e('@aiPlay: Cannot play while in loading or error state');
      return;
    }
    final board = state.value!;

    state = AsyncLoading();

    final allCells = List<Cell>.generate(
      9,
      (index) => Cell(index ~/ 3, index % 3),
    );
    final takenCells = [...board.xPlayed, ...board.oPlayed];
    final availableCells = allCells
        .where((cell) => !takenCells.contains(cell))
        .toList();

    if (availableCells.isEmpty) {
      return;
    }

    // Replace by repo
    await Future.delayed(const Duration(milliseconds: 1000));
    final aiCell = availableCells.first;

    state = AsyncData(
      Board(
        xPlayed: aiPlayingWithX
            ? [...board.xPlayed, aiCell]
            : board.xPlayed,
        oPlayed: aiPlayingWithX
            ? board.oPlayed
            : [...board.oPlayed, aiCell],
      ),
    );
  }
}
