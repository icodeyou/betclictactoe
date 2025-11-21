import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:betclictactoe/utils/app_constants.dart';
import 'package:betclictactoe/utils/audio/songs.dart';
import 'package:betclictactoe/utils/audio/sounds.dart';
import 'package:betclictactoe/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioControllerProvider = NotifierProvider<AudioController, AudioState>(
  () => AudioController(),
);

class AudioState {
  AudioState({
    required this.audioOn,
    required this.sfxOn,
    required this.musicOn,
  });

  /// Whether or not the audio is on at all. This overrides both music
  /// and sounds (sfx).
  bool audioOn;

  /// Whether or not the sound effects (sfx) are on.
  bool sfxOn;

  /// Whether or not the music is on.
  bool musicOn;
}

/// This controller manages whether music and sound should be played.
class AudioController extends Notifier<AudioState> {
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

  @override
  AudioState build() {
    // By default, we always start playing music.
    _playCurrentSongInPlaylist();
    _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
    unawaited(_preloadSfx());

    listenSelf((previous, next) {
      // Handle audioOn changes
      if (previous?.audioOn != next.audioOn) {
        logger.d('Audio changed to ${next.audioOn}');
        if (next.audioOn) {
          // All sound just got un-muted. Audio is on.
          if (next.musicOn) {
            _startOrResumeMusic();
          }
        } else {
          // All sound just got muted. Audio is off.
          _stopAllSound();
        }
      }

      // Handle musicOn changes
      if (next.musicOn) {
        logger.d('Music got turned on.');
        if (next.audioOn) {
          _startOrResumeMusic();
        }
      } else {
        logger.d('Music got turned off.');
        _musicPlayer.pause();
      }

      // Handle soundsOn changes
      for (final player in _sfxPlayers) {
        if (player.state == PlayerState.playing) {
          player.stop();
        }
      }
    });

    ref.onDispose(() {
      _stopAllSound();
      _musicPlayer.dispose();
      for (final player in _sfxPlayers) {
        player.dispose();
      }
    });

    return AudioState(audioOn: true, musicOn: true, sfxOn: true);
  }

  /// Plays a single sound effect, defined by [type].
  ///
  /// The controller will ignore this call when the attached settings'
  /// [SettingsController.audioOn] is `true` or if its
  /// [SettingsController.soundsOn] is `false`.
  void playSfx(SfxType type) {
    final audioOn = state.audioOn;
    if (!audioOn) {
      logger.d(() => 'Ignoring playing sound ($type) because audio is muted.');
      return;
    }
    final soundsOn = state.sfxOn;
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

  void handleAppPaused() {
    _stopAllSound();
  }

  void handleAppResumed() {
    if (state.audioOn && state.musicOn) {
      _startOrResumeMusic();
    }
  }

  void toggleAudio() {
    state = AudioState(
      audioOn: !state.audioOn,
      musicOn: state.musicOn,
      sfxOn: state.sfxOn,
    );
  }

  void toggleSound() {
    state = AudioState(
      audioOn: state.audioOn,
      musicOn: state.musicOn,
      sfxOn: !state.sfxOn,
    );
  }

  void toggleMusic() {
    state = AudioState(
      audioOn: state.audioOn,
      musicOn: !state.musicOn,
      sfxOn: state.sfxOn,
    );
  }

  void _handleSongFinished(void _) {
    logger.i('Last song finished playing.');
    // Move the song that just finished playing to the end of the playlist.
    _playlist.addLast(_playlist.removeFirst());
    // Play the song at the beginning of the playlist.
    _playCurrentSongInPlaylist();
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
