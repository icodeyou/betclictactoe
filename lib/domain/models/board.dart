import 'package:betclictactoe/domain/models/cell.dart';

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
    // Winning positions
    final winningPositions = [
      // Horizontal
      [Cell(0, 0), Cell(0, 1), Cell(0, 2)],
      [Cell(1, 0), Cell(1, 1), Cell(1, 2)],
      [Cell(2, 0), Cell(2, 1), Cell(2, 2)],
      // Vertical
      [Cell(0, 0), Cell(1, 0), Cell(2, 0)],
      [Cell(0, 1), Cell(1, 1), Cell(2, 1)],
      [Cell(0, 2), Cell(1, 2), Cell(2, 2)],
      // Diagonal
      [Cell(0, 0), Cell(1, 1), Cell(2, 2)],
      [Cell(0, 2), Cell(1, 1), Cell(2, 0)],
    ];

    final winningIndexes = <Cell>[];

    for (final position in winningPositions) {
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
}
