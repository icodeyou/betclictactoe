import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameNotifierProvider =
    NotifierProvider.autoDispose<GameNotifier, GameState>(GameNotifier.new);

class GameState {
  GameState({
    required this.isPlayingFirstWithX,
    required this.friendScore,
    required this.userScore,
  });

  final bool isPlayingFirstWithX;
  final int friendScore;
  final int userScore;
}

class GameNotifier extends Notifier<GameState> {
  @override
  GameState build() {
    return GameState(isPlayingFirstWithX: true, friendScore: 0, userScore: 0);
  }

  void togglePlayingFirst() {
    state = GameState(
      isPlayingFirstWithX: !state.isPlayingFirstWithX,
      friendScore: state.friendScore,
      userScore: state.userScore,
    );
  }

  void incrementScore({required bool isXTurn}) {
    if (isXTurn && state.isPlayingFirstWithX ||
        (!isXTurn && !state.isPlayingFirstWithX)) {
      state = GameState(
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore,
        userScore: state.userScore + 1,
      );
    } else {
      state = GameState(
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore + 1,
        userScore: state.userScore,
      );
    }
  }
}
