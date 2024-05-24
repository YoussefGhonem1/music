import 'package:music/song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
        title: 'Amr Diab',
        songs: Song.songs
            .where((element) => element.description == "Amr Diab")
            .toList(),
        imageUrl: 'assets/images/makanak.jpg'),
    Playlist(
        title: 'Tamer Hosny',
        songs: Song.songs
            .where((element) => element.description == "Tamer Hosny")
            .toList(),
        imageUrl: 'assets/images/hyatna.jpg'),
        
         Playlist(
        title: 'Hamaki',
        songs: Song.songs
            .where((element) => element.description == "Hamaki")
            .toList(),
        imageUrl: 'assets/images/adernaline.jpg'),
         Playlist(
        title: 'Tamer Ashour',
        songs: Song.songs
            .where((element) => element.description == "Tamer Ashour")
            .toList(),
        imageUrl: 'assets/images/3ashor.jpg'),

  ];
}
