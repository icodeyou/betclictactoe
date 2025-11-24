import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/presentation/game/notifier/game_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playFriendNotifierProvider =
    NotifierProvider.autoDispose<PlayFriendNotifier, Board>(
      () => PlayFriendNotifier(),
    );

class PlayFriendNotifier extends Notifier<Board> with IPlayNotifier {
  @override
  Board build() {
    ref.watch(gameNotifierProvider); // Rebuild board when settings change
    return Board(xPlayed: [], oPlayed: []);
  }

  @override
  void tick(Cell cell, Future<void> Function() winningAnimationCallback) {
    final isXTurn = state.isXTurn();

    state = Board(
      xPlayed: isXTurn ? [...state.xPlayed, cell] : state.xPlayed,
      oPlayed: isXTurn ? state.oPlayed : [...state.oPlayed, cell],
    );

    handleWinning(ref, state, isXTurn, winningAnimationCallback);
  }
}
