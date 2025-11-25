import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/presentation/shared/keys/ui_keys.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/test_setup.dart';

void main() {
  testWidgets('Play AI button', (tester) async {
    await TestSetup.initApp(tester);

    expect(find.byKey(UIKeys.titleHomeScreen), findsOneWidget);
    expect(find.text(t.homeScreen.playAIButtonLabel), findsOneWidget);

    await tester.tap(find.text(t.homeScreen.playAIButtonLabel));
    await tester.pumpAndSettle();

    // Make sure we navigated away from home screen
    expect(find.text(AppConstants.fullAppName), findsNothing);

    // Come back to home screen
    await tester.tap(find.byKey(UIKeys.gameScreenBackButton));
    await tester.pumpAndSettle();
    expect(find.text(AppConstants.fullAppName), findsOneWidget);
  });

  testWidgets('Play friend button', (tester) async {
    await TestSetup.initApp(tester);

    //expect(find.byKey(UIKeys.titleHomeScreen), findsOneWidget);
    expect(find.text(t.homeScreen.playFriendButtonLabel), findsOneWidget);

    await tester.tap(find.text(t.homeScreen.playFriendButtonLabel));
    await tester.pumpAndSettle();

    // Make sure we navigated away from home screen
    expect(find.text(t.homeScreen.playFriendButtonLabel), findsNothing);

    // Come back to home screen
    await tester.tap(find.byKey(UIKeys.gameScreenBackButton));
    await tester.pumpAndSettle();
    expect(find.text(AppConstants.fullAppName), findsOneWidget);
  });

  testWidgets('Settings button', (tester) async {
    await TestSetup.initApp(tester);

    expect(find.byKey(UIKeys.titleHomeScreen), findsOneWidget);
    expect(find.text(t.homeScreen.settingsButtonLabel), findsOneWidget);

    await tester.tap(find.text(t.homeScreen.settingsButtonLabel));
    await tester.pumpAndSettle();

    // Make sure we navigated away from home screen
    expect(find.text(AppConstants.fullAppName), findsNothing);

    // Come back to home screen
    await tester.tap(find.byKey(UIKeys.settingsScreenBackButton));
    await tester.pumpAndSettle();
    expect(find.text(AppConstants.fullAppName), findsOneWidget);
  });
}
