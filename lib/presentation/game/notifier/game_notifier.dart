import 'package:betclictactoe/presentation/shared/controller/shared_pref_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameNotifierProvider =
    NotifierProvider.autoDispose<GameNotifier, GameState>(GameNotifier.new);

class GameState {
  GameState({
    required this.playerName,
    required this.isPlayingFirstWithX,
    required this.friendScore,
    required this.playerScore,
  });

  final String playerName;
  final bool isPlayingFirstWithX;
  final int friendScore;
  final int playerScore;
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
      playerScore: 0,
    );
  }

  void togglePlayingFirst() {
    state = GameState(
      playerName: state.playerName,
      isPlayingFirstWithX: !state.isPlayingFirstWithX,
      friendScore: state.friendScore,
      playerScore: state.playerScore,
    );
  }

  void incrementScore({required bool isXTurn}) {
    if (isXTurn && state.isPlayingFirstWithX ||
        (!isXTurn && !state.isPlayingFirstWithX)) {
      state = GameState(
        playerName: state.playerName,
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore,
        playerScore: state.playerScore + 1,
      );
    } else {
      state = GameState(
        playerName: state.playerName,
        isPlayingFirstWithX: state.isPlayingFirstWithX,
        friendScore: state.friendScore + 1,
        playerScore: state.playerScore,
      );
    }
  }
}
