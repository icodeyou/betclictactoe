import 'dart:math';

import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/domain/repository/i_play_repository.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playRepositoryProvider = Provider<IPlayRepository>((ref) {
  return PlayRepository();
});

class PlayRepository implements IPlayRepository {
  @override
  Future<Cell> getFirstMove() {
    // Simulate network delay
    return Future.delayed(const Duration(milliseconds: 500), () {
      // Random first move
      final random = Random();
      return Cell(random.nextInt(3), random.nextInt(3));
    });
  }

  @override
  Future<Cell> getNextMove(Board board, bool aiPlayingWithX) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final aiMoves = aiPlayingWithX ? board.xPlayed : board.oPlayed;
    final oppMoves = aiPlayingWithX ? board.oPlayed : board.xPlayed;

    bool isWinning(List<Cell> moves) => AppConstants.winningPositions.any(
      (pos) => pos.every((c) => moves.contains(c)),
    );

    // All cells on the board
    final allCells = <Cell>[
      for (var x = 0; x < 3; x++)
        for (var y = 0; y < 3; y++) Cell(x, y),
    ];

    final available = allCells
        .where((c) => !board.isCellTicked(c))
        .toList(growable: false);

    // Win if there is an opportunity
    for (final cell in available) {
      final simulated = List<Cell>.from(aiMoves)..add(cell);
      if (isWinning(simulated)) {
        return cell;
      }
    }

    // Block opponent's win
    for (final cell in available) {
      final simulatedOpp = List<Cell>.from(oppMoves)..add(cell);
      if (isWinning(simulatedOpp)) return Future.value(cell);
    }

    // Take center
    final center = Cell(1, 1);
    if (available.contains(center)) return Future.value(center);

    // Take a corner (preferred order)
    final corners = [Cell(0, 0), Cell(0, 2), Cell(2, 0), Cell(2, 2)];
    for (final corner in corners) {
      if (available.contains(corner)) return Future.value(corner);
    }

    // Take any available cell
    if (available.isNotEmpty) return Future.value(available.first);

    throw Exception('No available moves');
  }
}
