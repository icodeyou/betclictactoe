import 'package:flutter/material.dart';

class SettingsController {
  /// Whether or not the audio is on at all. This overrides both music
  /// and sounds (sfx).
  ///
  /// This is an important feature especially on mobile, where players
  /// expect to be able to quickly mute all the audio. Having this as
  /// a separate flag (as opposed to some kind of {off, sound, everything}
  /// enum) means that the player will not lose their [soundsOn] and
  /// [musicOn] preferences when they temporarily mute the game.
  ValueNotifier<bool> audioOn = ValueNotifier(true);

  /// The player's name. Used for things like high score lists.
  ValueNotifier<String> playerName = ValueNotifier('Player');

  /// Whether or not the sound effects (sfx) are on.
  ValueNotifier<bool> soundsOn = ValueNotifier(true);

  /// Whether or not the music is on.
  ValueNotifier<bool> musicOn = ValueNotifier(true);
}
