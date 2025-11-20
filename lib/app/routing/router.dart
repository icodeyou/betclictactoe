import 'package:betclictactoe/ui/game/game_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../theme/colors.dart';
import '../../ui/menu/main_menu_screen.dart';
import '../../ui/settings/settings_screen.dart';
import 'play_transition.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main_menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPlayTransition<void>(
            key: const ValueKey('play'),
            color: AppColors.playBackground,
            child: const GameScreen(),
          ),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) =>
              const SettingsScreen(key: Key('settings')),
        ),
      ],
    ),
  ],
);
