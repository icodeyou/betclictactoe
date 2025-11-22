import 'package:betclictactoe/presentation/shared/controller/shared_pref_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameNotifierProvider =
    NotifierProvider.autoDispose<GameNotifier, GameState>(GameNotifier.new);

class GameState {
  GameState({
    required this.playerName,
    required this.isPlayingFirstWithX,
    required this.friendScore,
    required this.userScore,
  });

  final String playerName;
  final bool isPlayingFirstWithX;
  final int friendScore;
  final int userScore;
}

class GameNotifier extends Notifier<GameState> {
  @override
  GameState build() {
    final playerName = ref
        .read(sharedPrefControllerProvider.notifier)
        .getPlayerName();
    return GameState(
      playerName: playerName,
      isPlayingFirstWithX: true,
      friendScore: 0,
      userScore: 0,
    );
  }

  void togglePlayingFirst() {
    state = GameState(
      playerName: state.playerName,
      isPlayingFirstWithX: !state.isPlayingFirstWithX,
      friendScore: state.friendScore,
      userScore: state.userScore,
    );
  }

  void incrementScore({required bool isXTurn}) {
    if (isXTurn && state.isPlayingFirstWithX ||
        (!isXTurn && !state.isPlayingFirstWithX)) {
      state = GameState(
        playerName: state.playerName,
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore,
        userScore: state.userScore + 1,
      );
    } else {
      state = GameState(
        playerName: state.playerName,
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore + 1,
        userScore: state.userScore,
      );
    }
  }
}
