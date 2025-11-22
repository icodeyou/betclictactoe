import 'package:betclictactoe/app/app_lifecycle.dart';
import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/app/routing/router.dart';
import 'package:betclictactoe/app/startup/global_provider.dart';
import 'package:betclictactoe/presentation/shared/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalAsyncValue = ref.watch(globalProvider);

    if (globalAsyncValue.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(t.splashScreen.title),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    }

    if (globalAsyncValue.hasError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(t.splashScreen.errorMessage),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(globalProvider);
                  },
                  child: Text(t.splashScreen.retryButtonLabel),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AppLifecycleObserver(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: ThemeColors.primary,
                primary: ThemeColors.primary,
                secondary: ThemeColors.secondary,
                surface: ThemeColors.background,
              ),
              useMaterial3: true,
            ).copyWith(
              appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
            ),
        routerConfig: router,
      ),
    );
  }
}
