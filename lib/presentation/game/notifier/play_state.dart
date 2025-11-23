class PlayState {
  PlayState({required this.xTicks, required this.oTicks});

  /// The list of the indexes corresponding to all the ticks from the beginning
  /// of the game, in chronological order, for x and o players.
  final List<int> xTicks;
  final List<int> oTicks;

  List<int> getWinningIndexes() {
    // Winning positions
    const winningPositions = [
      // Horizontal
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Vertical
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonal
      [0, 4, 8],
      [2, 4, 6],
    ];

    final winningIndexes = <int>[];

    for (final position in winningPositions) {
      if (position.every((index) => xTicks.contains(index)) ||
          position.every((index) => oTicks.contains(index))) {
        winningIndexes.addAll(position);
      }
    }
    return winningIndexes;
  }

  bool isXTurn() {
    return xTicks.length == oTicks.length;
  }
}
