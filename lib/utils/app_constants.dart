import 'package:betclictactoe/domain/models/cell.dart';

class AppConstants {
  /// General
  static const String fullAppName = 'Betclic \nTic Tac Toe';

  /// Logging
  static const int logStacktraceNumber = 2;

  /// UI
  static const int playerNameMaxLength = 15;
  static const String tictactoeFont = 'luckiest_guy';
  static const String titleFont = 'permanent_marker';

  /// Audio
  ///
  /// [polyphony] is to configure the number of sound effects (SFX) that can
  /// play at the same time. If you choose `1`, it will always only play one
  /// sound (a new sound will stop the previous one). Background music does not
  /// count into the [polyphony] limit.
  /// This value should be at least `1`.
  static const int polyphony = 4;

  /// Game
  static const int gridSize = 3;
  static const int winningLength = 3;
  // Winning positions
  static final winningPositions = [
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
}
