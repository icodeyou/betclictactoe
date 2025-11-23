const Set<Song> songs = {
  // Warning: Filenames with whitespace break package:audioplayers on iOS
  Song('song-jazz.mp3', artist: 'Music_For_Videos'),
  Song('song-piano-adventure.mp3', artist: 'Music_For_Videos'),
  Song('song-stranger.mp3', artist: 'Osynthw'),
  Song('song-electro.mp3', artist: 'ED-MusicProductions'),
};

class Song {
  final String filename;

  final String? artist;

  const Song(this.filename, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
