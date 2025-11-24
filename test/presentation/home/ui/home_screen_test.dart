import 'package:betclictactoe/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Screen - Integration tests', () {
    testWidgets('Play with a friend button', (tester) {
      tester.pumpWidget(const MyApp());
    });
  });
}
