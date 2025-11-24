import 'package:betclictactoe/domain/models/cell.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('cell', () {
    test('two cells equal', () {
      final cell1 = const Cell(1, 2);
      final cell2 = const Cell(1, 2);
      expect(cell1, equals(cell2));
    });

    test('two cells not equal', () {
      final cell1 = const Cell(1, 2);
      final cell2 = const Cell(2, 1);
      expect(cell1, isNot(equals(cell2)));
    });
  });
}
