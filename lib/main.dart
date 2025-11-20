import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/routing/router.dart';
import 'app_lifecycle/app_lifecycle.dart';
import 'theme/colors.dart';
import 'ui/shared/controllers/audio_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Put game into full screen mode on mobile devices.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Lock the game to portrait mode on mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        // This is where you add objects that you want to have available
        // throughout your game.
        //
        // Every widget in the game can access these objects by calling
        // `context.watch()` or `context.read()`.
        // See `lib/main_menu/main_menu_screen.dart` for example usage.
        providers: [
          // Set up audio.
          ProxyProvider<AppLifecycleStateNotifier, AudioController>(
            create: (context) => AudioController(),
            update: (context, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
            // Ensures that music starts immediately.
            lazy: false,
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              theme:
                  ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: AppColors.darkPen,
                      surface: AppColors.backgroundMain,
                    ),
                    textTheme: TextTheme(
                      bodyMedium: TextStyle(color: AppColors.ink),
                    ),
                    useMaterial3: true,
                  ).copyWith(
                    // Make buttons more fun.
                    filledButtonTheme: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
