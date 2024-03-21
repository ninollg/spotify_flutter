import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/models/album.dart';
import 'package:projet_spotify_gorouter/provider/provider_spotify.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumNewsScreen extends StatefulWidget {
  const AlbumNewsScreen({Key? key}) : super(key: key);

  @override
  _AlbumNewsScreenState createState() => _AlbumNewsScreenState();
}

class _AlbumNewsScreenState extends State<AlbumNewsScreen> {
  List<Album> _futureAlbums = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final albums = await fetchLatestAlbums();
    setState(() {
      _futureAlbums = albums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album News Screen')),
      body: _futureAlbums.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _futureAlbums.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(_futureAlbums[index].title),
                    onTap: () => context.go('/a/albumdetails/${_futureAlbums[index].id}'),
                    leading: SizedBox(
                      width: 100,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: _futureAlbums[index].imageUrl,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
