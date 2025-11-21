import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:betclictactoe/app_lifecycle/app_lifecycle.dart';
import 'package:betclictactoe/ui/shared/controllers/settings_controller.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/audio/songs.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter/widgets.dart';

/// Allows playing music and sound. A facade to `package:audioplayers`.
class AudioController {
  final AudioPlayer _musicPlayer = AudioPlayer(playerId: 'musicPlayer');

  /// This is a list of [AudioPlayer] instances which are rotated to play
  /// sound effects.
  final List<AudioPlayer> _sfxPlayers = Iterable.generate(
    AppConstants.polyphony,
    (i) => AudioPlayer(playerId: 'sfxPlayer#$i'),
  ).toList(growable: false);

  int _currentSfxPlayer = 0;

  final Queue<Song> _playlist = Queue.of(List<Song>.of(songs)..shuffle());

  final Random _random = Random();

  SettingsController settingsController = SettingsController();

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  /// Creates an instance that plays music and sound.
  AudioController() {
    if (settingsController.audioOn.value && settingsController.musicOn.value) {
      _playCurrentSongInPlaylist();
    }
    _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
    unawaited(_preloadSfx());
  }

  // TODO : Use Riverpod instead
  /// Makes sure the audio controller is listening to changes
  /// of both the app lifecycle (e.g. suspended app)
  void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier) {
    _attachLifecycleNotifier(lifecycleNotifier);
    _attachSettings();
  }

  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  /// Plays a single sound effect, defined by [type].
  ///
  /// The controller will ignore this call when the attached settings'
  /// [SettingsController.audioOn] is `true` or if its
  /// [SettingsController.soundsOn] is `false`.
  void playSfx(SfxType type) {
    final audioOn = settingsController.audioOn.value;
    if (!audioOn) {
      logger.d(() => 'Ignoring playing sound ($type) because audio is muted.');
      return;
    }
    final soundsOn = settingsController.soundsOn.value;
    if (!soundsOn) {
      logger.f(
        () => 'Ignoring playing sound ($type) because sounds are turned off.',
      );
      return;
    }

    logger.d(() => 'Playing sound: $type');
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    logger.d(() => '- Chosen filename: $filename');

    final currentPlayer = _sfxPlayers[_currentSfxPlayer];
    currentPlayer.play(
      AssetSource('sfx/$filename'),
      volume: soundTypeToVolume(type),
    );
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  /// Enables the [AudioController] to listen to [AppLifecycleState] events,
  /// and therefore do things like stopping playback when the game
  /// goes into the background.
  void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }

  /// Enables the [AudioController] to track changes to settings.
  /// Namely, when any of [SettingsController.audioOn],
  /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
  /// the audio controller will act accordingly.
  void _attachSettings() {
    // Add handlers to the new settings controller
    settingsController.audioOn.addListener(_audioOnHandler);
    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundsOnHandler);

    // TODO : Stop listening on dispose
  }

  void _audioOnHandler() {
    logger.d('audioOn changed to ${settingsController.audioOn.value}');
    if (settingsController.audioOn.value) {
      // All sound just got un-muted. Audio is on.
      if (settingsController.musicOn.value) {
        _startOrResumeMusic();
      }
    } else {
      // All sound just got muted. Audio is off.
      _stopAllSound();
    }
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _stopAllSound();
      case AppLifecycleState.resumed:
        if (settingsController.audioOn.value &&
            settingsController.musicOn.value) {
          _startOrResumeMusic();
        }
      case AppLifecycleState.inactive:
        // No need to react to this state change.
        break;
    }
  }

  void _handleSongFinished(void _) {
    logger.i('Last song finished playing.');
    // Move the song that just finished playing to the end of the playlist.
    _playlist.addLast(_playlist.removeFirst());
    // Play the song at the beginning of the playlist.
    _playCurrentSongInPlaylist();
  }

  void _musicOnHandler() {
    if (settingsController.musicOn.value) {
      // Music got turned on.
      if (settingsController.audioOn.value) {
        _startOrResumeMusic();
      }
    } else {
      // Music got turned off.
      _musicPlayer.pause();
    }
  }

  Future<void> _playCurrentSongInPlaylist() async {
    logger.i(() => 'Playing ${_playlist.first} now.');
    try {
      await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
    } catch (e) {
      logger.e('Could not play song ${_playlist.first} - Error: $e');
    }
  }

  /// Preloads all sound effects.
  Future<void> _preloadSfx() async {
    logger.i('Preloading sound effects');
    await AudioCache.instance.loadAll(
      SfxType.values
          .expand(soundTypeToFilename)
          .map((path) => 'sfx/$path')
          .toList(),
    );
  }

  void _soundsOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.playing) {
        player.stop();
      }
    }
  }

  void _startOrResumeMusic() async {
    if (_musicPlayer.source == null) {
      logger.i(
        'No music source set. '
        'Start playing the current song in playlist.',
      );
      await _playCurrentSongInPlaylist();
      return;
    }

    logger.i('Resuming paused music.');
    try {
      _musicPlayer.resume();
    } catch (e) {
      logger.e('Error resuming music - Error: $e');
      _playCurrentSongInPlaylist();
    }
  }

  void _stopAllSound() {
    logger.i('Stopping all sound');
    _musicPlayer.pause();
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }
}
