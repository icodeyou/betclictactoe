import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/utils/app_constants.dart';

class Board {
  Board({required this.xPlayed, required this.oPlayed});

  /// The list of the indexes corresponding to all the ticks from the beginning
  /// of the game, in chronological order, for x and o players.
  final List<Cell> xPlayed;
  final List<Cell> oPlayed;

  bool isCellTicked(Cell cell) {
    final debug = xPlayed.contains(cell) || oPlayed.contains(cell);
    return debug;
  }

  List<Cell> getWinningIndexes() {
    final winningIndexes = <Cell>[];

    for (final position in AppConstants.winningPositions) {
      if (position.every((cell) => xPlayed.contains(cell)) ||
          position.every((cell) => oPlayed.contains(cell))) {
        winningIndexes.addAll(position);
      }
    }
    return winningIndexes;
  }

  bool isXTurn() {
    return xPlayed.length == oPlayed.length;
  }

  bool isFull() {
    return (xPlayed.length + oPlayed.length) >=
        (AppConstants.gridSize * AppConstants.gridSize);
  }
}
