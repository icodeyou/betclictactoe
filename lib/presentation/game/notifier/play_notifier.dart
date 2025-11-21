import 'package:flutter_riverpod/flutter_riverpod.dart';

final playNotifierProvider =
    NotifierProvider.autoDispose<PlayNotifier, PlayState>(() => PlayNotifier());

class PlayState {
  PlayState({required this.xTicks, required this.oTicks});

  /// The list of the indexes corresponding to all the ticks from the beginning
  /// of the game, in chronological order, for x and o players.
  final List<int> xTicks;
  final List<int> oTicks;
}

class PlayNotifier extends Notifier<PlayState> {
  @override
  PlayState build() {
    return PlayState(xTicks: [], oTicks: []);
  }

  void tick(int index) {
    // X always starts first.
    final isXTurn = state.xTicks.length == state.oTicks.length;

    if (isXTurn) {
      state = PlayState(xTicks: [...state.xTicks, index], oTicks: state.oTicks);
    } else {
      state = PlayState(xTicks: state.xTicks, oTicks: [...state.oTicks, index]);
    }
  }
}
