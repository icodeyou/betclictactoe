import 'package:betclictactoe/presentation/shared/controller/shared_pref_controller.dart';
import 'package:riverpod/riverpod.dart';

final settingsNotifierProvider =
    NotifierProvider<SettingsNotifier, String>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<String> {
  @override
  String build() {
    final prefs = ref.read(sharedPrefControllerProvider.notifier);
    return prefs.getPlayerName();
  }

  Future<void> setPlayerName(String name) async {
    final prefs = ref.read(sharedPrefControllerProvider.notifier);
    await prefs.setPlayerName(name);
    state = name;
  }
}
