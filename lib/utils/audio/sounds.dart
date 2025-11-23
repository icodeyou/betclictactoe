List<String> soundTypeToFilename(SfxType type) => switch (type) {
  SfxType.xTick => const ['pop.mp3'],
  SfxType.yTick => const ['pop2.mp3'],
  SfxType.buttonTap => const [
    'shine.mp3',
    'shine2.mp3',
    'shine3.mp3',
    'shine4.mp3',
  ],
  SfxType.congrats => const [
    'win.mp3',
    'win3.mp3',
    'win4.mp3',
    'win4.mp3',
    'congrats.mp3',
  ],
};

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.xTick:
    case SfxType.yTick:
      return 0.4;
    case SfxType.buttonTap:
      return 0.8;
    case SfxType.congrats:
      return 1.0;
  }
}

enum SfxType { xTick, yTick, buttonTap, congrats }
