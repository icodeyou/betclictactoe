# BetclicTacToe

This is the technical test project for Betclic.

The target platforms are iOS and Android.

## Development

To run the app in debug mode:

```bash
flutter run
```

### Code organization

Code is organized in a loose and shallow layer-first fashion.
In `lib/`, you'll therefore find directories such as `audio`,
`main_menu` or `settings`. Nothing fancy, but usable.

```text
  lib
  ├── app_lifecycle
  ├── audio
  ├── game_internals
  ├── level_selection
  ├── main_menu
  ├── play_session
  ├── player_progress
  ├── settings
  ├── style
  ├── win_game
  │
  ├── main.dart
  └── router.dart
```

### Building for production

To build the app for iOS (and open Xcode when finished):

```bash
flutter build ipa && open build/ios/archive/Runner.xcarchive
```

To build the app for Android (and open the folder with the bundle when finished):

```bash
flutter build appbundle && open build/app/outputs/bundle/release
```

### Audio

Audio is enabled by default and ready to go. You can modify code
in `lib/audio/` to your liking.

The music tracks are in `assets/music` — these are Creative Commons Attribution (CC-BY)
licensed, and are included in this repository with permission.

The repository also includes a few sound effect samples in `assets/sfx`.
These are public domain (CC0).

### Logging

The template uses the [`logging`](https://pub.dev/packages/logging) package
to log messages to the console.

### Settings

The settings page is enabled by default, and accessible both
from the main menu and through the "gear" button in the play session screen.

Settings are saved to local storage using the
[`shared_preferences`](https://pub.dev/packages/shared_preferences)
package.
To change what preferences are saved and how, edit files in
`lib/settings/persistence`.

## Icon

To update the launcher icon, first change the files
`assets/icon-adaptive-foreground.png` and `assets/icon.png`.
Then, run the following:

```bash
dart run flutter_launcher_icons:main
```

You can [configure](https://github.com/fluttercommunity/flutter_launcher_icons#book-guide)
the look of the icon in the `flutter_icons:` section of `pubspec.yaml`.

## Troubleshooting

### CocoaPods

When upgrading to higher versions of Flutter or plugins, you might encounter an error when
building the iOS or macOS app. A good first thing to try is to delete the `ios/Podfile.lock`
file (or `macos/Podfile.lock`, respectively), then trying to build again. (You can achieve
a more thorough cleanup by running `flutter clean` instead.)

If this doesn't help, here are some more methods:

- See if everything is still okay with your Flutter and CocoaPods installation
  by running `flutter doctor`. Revisit the macOS
  [Flutter installation guide](https://docs.flutter.dev/get-started/install/macos)
  if needed.
- Update CocoaPods specs directory:

  ```bash
  cd ios
  pod repo update
  cd ..
  ```

- Open the project in Xcode,
  [increase the build target](https://stackoverflow.com/a/38602597/1416886),
  then select _Product_ > _Clean Build Folder_.

## License

This project is based under the official game template created by the Flutter team.

Copyright 2022, the Flutter project authors. All rights reserved.
Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.
