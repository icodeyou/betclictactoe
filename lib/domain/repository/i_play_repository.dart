import 'package:betclictactoe/domain/models/board.dart';
import 'package:betclictactoe/domain/models/cell.dart';

abstract class IPlayRepository {
  Future<Cell> getFirstMove();
  Future<Cell> getNextMove(Board board, bool aiPlayingWithX);
}
