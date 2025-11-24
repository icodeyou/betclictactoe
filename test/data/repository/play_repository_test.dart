import 'package:betclictactoe/data/repository/play_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('play_repository', () {
    test('getFirstMove', () async {
      final playRepository = PlayRepository();
      final results = await Future.wait(
        List.generate(9, (_) => playRepository.getFirstMove()),
      );
      expect(results.every((r) => r.x >= 0 && r.x <= 2), isTrue);
      expect(results.every((r) => r.y >= 0 && r.y <= 2), isTrue);
    });
  });
}
