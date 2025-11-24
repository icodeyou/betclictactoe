import 'package:betclictactoe/presentation/game/notifier/i_play_notifier.dart';
import 'package:betclictactoe/presentation/game/notifier/play_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playFriendNotifierProvider =
    NotifierProvider.autoDispose<PlayFriendNotifier, PlayState>(
      () => PlayFriendNotifier(),
    );

class PlayFriendNotifier extends Notifier<PlayState> with IPlayNotifier {
  @override
  PlayState build() {
    return PlayState(xTicks: [], oTicks: []);
  }

  @override
  void tick(int index, Future<void> Function() winningAnimationCallback) {
    final isXTurn = state.isXTurn();

    state = PlayState(
      xTicks: isXTurn ? [...state.xTicks, index] : state.xTicks,
      oTicks: isXTurn ? state.oTicks : [...state.oTicks, index],
    );

    handleWinning(ref, state, isXTurn, winningAnimationCallback);
  }
}
