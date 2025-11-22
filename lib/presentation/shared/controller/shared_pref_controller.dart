import 'package:betclictactoe/app/i18n/translations.g.dart';
import 'package:betclictactoe/app/startup/global_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefControllerProvider =
    NotifierProvider<SharedPrefController, void>(
  SharedPrefController.new,
);

class SharedPrefController extends Notifier<void> {
  SharedPreferences get prefs => ref.watch(sharedPrefProvider).requireValue;

  static const playerNameKey = 'player_name';

  @override
  void build() {}

  String getPlayerName() {
    return prefs.getString(playerNameKey) ?? t.settingsScreen.defaultName;
  }

  Future<void> setPlayerName(String name) {
    return prefs.setString(playerNameKey, name);
  }
}
