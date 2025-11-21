import 'package:betclictactoe/app/routing/paths.dart';
import 'package:betclictactoe/presentation/shared/theme/colors.dart';
import 'package:betclictactoe/presentation/game/ui/game_screen.dart';
import 'package:betclictactoe/presentation/home/ui/home_screen.dart';
import 'package:betclictactoe/presentation/settings/ui/settings_screen.dart';
import 'package:go_router/go_router.dart';

import 'play_transition.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      // If a page is invalid, go_router will suggest to go to '/'
      path: '/',
      redirect: (context, state) => Paths.home.path,
    ),
    GoRoute(
      path: Paths.home.path,
      name: Paths.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: Paths.game.path,
          name: Paths.game.name,
          pageBuilder: (context, state) => buildPlayTransition<void>(
            color: AppColors.background,
            child: const GameScreen(),
          ),
        ),
        GoRoute(
          path: Paths.settings.path,
          name: Paths.settings.name,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
