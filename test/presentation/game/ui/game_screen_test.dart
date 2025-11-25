import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/shared/keys/ui_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/test_setup.dart';

void main() {
  group('game_screen - VS Friend', () {
    testWidgets('', (tester) async {
      await TestSetup.initApp(tester);

      // Home Screen
      expect(find.byKey(UIKeys.titleHomeScreen), findsOneWidget);

      // Navigate to Game Screen
      await tester.tap(find.text(t.homeScreen.playFriendButtonLabel));
      await tester.pumpAndSettle();

      // Play Tic Tac Toe
      expect(find.text('X'), findsNothing);
      await tester.tap(find.byKey(Key('cell_view_0')));
      await tester.pumpAndSettle();
      expect(find.text('X'), findsOne);

      await tester.tap(find.byKey(Key('cell_view_1')));
      await tester.pumpAndSettle();
      expect(find.text('O'), findsOne);

      await tester.tap(find.byKey(Key('cell_view_2')));
      await tester.pumpAndSettle();
      expect(find.text('X'), findsExactly(2));

      await tester.tap(find.byKey(Key('cell_view_3')));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsExactly(2));
    });
  });
}
