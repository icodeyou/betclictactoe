import 'package:equatable/equatable.dart';

class Cell extends Equatable {
  final int x;
  final int y;

  const Cell(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}
