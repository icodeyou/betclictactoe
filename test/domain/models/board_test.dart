import 'dart:math';

import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('board_test - isCellTicked', () {
    test('isCellTicked returns true when cell is in xPlayed', () {
      final target = const Cell(0, 0);
      final board = Board(xPlayed: [target], oPlayed: []);
      expect(board.isCellTicked(target), isTrue);
    });

    test('isCellTicked returns true when cell is in oPlayed', () {
      final target = const Cell(2, 1);
      final board = Board(xPlayed: [], oPlayed: [target]);
      expect(board.isCellTicked(target), isTrue);
    });

    test('isCellTicked returns false when cell is not played', () {
      final board = Board(
        xPlayed: [const Cell(0, 1)],
        oPlayed: [const Cell(2, 1)],
      );
      expect(board.isCellTicked(const Cell(1, 2)), isFalse);
    });
  });

  group('board_test - getWinningIndexes', () {
    test('getWinningIndexes returns winning positions when X has a win', () {
      final randomIndex = Random().nextInt(
        AppConstants.winningPositions.length,
      );
      logger.d('randomIndex: $randomIndex');
      final winPosition = AppConstants.winningPositions[randomIndex];
      final oSampleCells = [Cell(0, 1), Cell(1, 0), Cell(2, 2)].where((
        element,
      ) {
        return !winPosition.contains(element);
      }).toList();
      final board = Board(xPlayed: winPosition, oPlayed: oSampleCells);
      final result = board.getWinningIndexes();

      expect(result.length, equals(3));
      for (final c in winPosition) {
        expect(result, contains(c));
      }
    });

    test('getWinningIndexes returns winning positions when O has a win', () {
      final randomIndex = Random().nextInt(
        AppConstants.winningPositions.length,
      );
      logger.d('randomIndex: $randomIndex');
      final winPosition = AppConstants.winningPositions[randomIndex];
      final xSampleCells = [Cell(0, 0), Cell(2, 1), Cell(1, 1)].where((
        element,
      ) {
        return !winPosition.contains(element);
      }).toList();
      final board = Board(xPlayed: xSampleCells, oPlayed: winPosition);
      final result = board.getWinningIndexes();

      expect(result.length, equals(3));
      for (final c in winPosition) {
        expect(result, contains(c));
      }
    });

    test('getWinningIndexes returns empty list when no one has a win', () {
      final board = Board(
        xPlayed: [
          const Cell(0, 1),
          const Cell(1, 1),
          const Cell(1, 2),
          const Cell(2, 0),
          const Cell(2, 2),
        ],
        oPlayed: [
          const Cell(0, 0),
          const Cell(0, 2),
          const Cell(1, 0),
          const Cell(2, 1),
        ],
      );
      final result = board.getWinningIndexes();
      expect(result, isEmpty);
    });
  });

  group('board_test - isFull', () {
    test('isFull returns true when board is full', () {
      final board = Board(
        xPlayed: [
          const Cell(0, 0),

          const Cell(1, 1),
          const Cell(1, 2),
          const Cell(2, 0),
          const Cell(2, 2),
        ],
        oPlayed: [
          const Cell(0, 1),
          const Cell(0, 2),
          const Cell(1, 0),
          const Cell(2, 1),
        ],
      );
      expect(board.isFull(), isTrue);
    });

    test('isFull returns false when board is not full', () {
      final board = Board(
        xPlayed: [const Cell(0, 0), const Cell(0, 1)],
        oPlayed: [const Cell(1, 2), const Cell(2, 0)],
      );
      expect(board.isFull(), isFalse);
    });
  });
}
