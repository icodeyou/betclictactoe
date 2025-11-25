import 'package:betclictactoe/app/app.dart';
import 'package:betclictactoe/app/startup/global_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestSetup {
  static Future<void> initApp(WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Wrap your app in UncontrolledProviderScope to use the container
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          globalProvider.overrideWithValue(const AsyncValue.data(null)),
          sharedPrefProvider.overrideWithValue(AsyncValue.data(prefs)),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 1));
    await tester.pump(Duration(seconds: 1)); 
  }
}
