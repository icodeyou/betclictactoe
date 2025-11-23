/// A class that represents a path to a screen in the app.
class Path {
  /// Unique constructor for class Path
  const Path({required this.path, required this.name});

  /// The path of the screen, corresponding to [GoRoute.path] parameter.
  final String path;

  /// The name, corresponding to [GoRoute.name] parameter.
  final String name;
}

/// A class that contains all the paths of the app.
class Paths {
  static const home = Path(path: '/home', name: 'home_screen');

  static const gameFriend = Path(path: '/game_friend', name: 'game_friend_screen');

  static const gameAI = Path(path: '/game_ai', name: 'game_ai_screen');

  static const settings = Path(path: '/settings', name: 'settings_screen');
}
