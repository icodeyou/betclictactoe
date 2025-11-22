import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_lifecycle.dart';
import 'app/routing/router.dart';
import 'presentation/shared/theme/app_colors.dart';

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
    return ProviderScope(
      child: AppLifecycleObserver(
        child: MaterialApp.router(
          theme:
              ThemeData.from(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  secondary: AppColors.secondary,
                  surface: AppColors.background,
                ),
                useMaterial3: true,
              ).copyWith(
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
              ),
          routerConfig: router,
        ),
      ),
    );
  }
}
