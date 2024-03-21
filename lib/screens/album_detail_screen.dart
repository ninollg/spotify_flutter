import 'package:flutter/material.dart';
import 'package:projet_spotify_gorouter/models/album.dart';
import 'package:projet_spotify_gorouter/provider/provider_spotify.dart';

class AlbumDetailScreen extends StatelessWidget {
  final String albumId; 
  final String albumTitle;
  final String artistName;
  final String imageUrl;
  final String releaseDate;
  final int totalTracks;

  const AlbumDetailScreen({
    required this.albumId, 
    required this.albumTitle,
    required this.artistName,
    required this.imageUrl,
    required this.releaseDate,
    required this.totalTracks,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: fetchAlbumDetail(albumId), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final album = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Album Details: ${album.title}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        album.imageUrl,
                        height: 300,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Title: ${album.title}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Artist: ${album.artist}',
                      style: TextStyle(fontSize: 16),
                    ),
                    // SizedBox(height: 10),
                    // Text(
                    //   'Release Date: ${album.releaseDate}',
                    //   style: TextStyle(fontSize: 16),
                    // ),
                    // SizedBox(height: 10),
                    // Text(
                    //   'Total Tracks: ${album.totalTracks}',
                    //   style: TextStyle(fontSize: 16),
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text('No album details found'));
        }
      },
    );
  }
}
