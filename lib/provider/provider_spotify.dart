import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_spotify_gorouter/models/album.dart';

const token =
    "BQDzRVUdYVu8YfA61oPnL2lKaZNKzdHSTWqCOcDYy4F113EWbuTac5sGdWecs0xBOrQS9sqosimvpfK49_ykL2GWKfJu1ghgnAUcHB8lZqATQiM1YD4";

Future<List<Album>> fetchLatestAlbums() async {
  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/browse/new-releases'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final albumsList = <Album>[];

    for (final album in jsonData['albums']['items']) {
      albumsList.add(Album(
        id: album['id'],
        title: album['name'],
        artist: album['artists'][0]['name'],
        imageUrl: album['images'][0]['url'],
        // releaseDate: album['release_date'],
        // totalTracks: album['total_tracks'],
      ));
    }
    // print(albumsList);

    return albumsList;
  } else {
    throw Exception('Failed to load latest albums');
  }
}

// Future<Album> fetchAlbumDetail() async {
//   final response = await http.get(
//       Uri.parse('https://api.spotify.com/v1/albums/0rlip3cEYFXL5BMUMTwb3N'),
//       headers: {'Authorization': 'Bearer $token'});
//       if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body);
//     final details = <Album>[];

//     for (final album in jsonData['albums']['items']) {
//       details.add(Album(
//         id: album['id'],
//         title: album['name'],
//         artist: album['artists'][0]['name'],
//         imageUrl: album['images'][0]['url'],
//       ));
//     }

//     return details;
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
Future<Album> fetchAlbumDetail(String albumId) async {
  final response = await http.get(
    Uri.parse('https://api.spotify.com/v1/albums/$albumId'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    final String id = jsonData['id'];
    final String title = jsonData['name'];
    final String artist = jsonData['artists'][0]['name'];
    final String imageUrl = jsonData['images'][0]['url'];
    // final String releaseDate = jsonData['release_date'];
    // final String totalTracks = jsonData['total_tracks'];

    return Album(
      id: id,
      title: title,
      artist: artist,
      imageUrl: imageUrl,
      // releaseDate: releaseDate,
      // totalTracks: totalTracks,
    );
  } else {
    throw Exception('Failed to load album');
  }
}
