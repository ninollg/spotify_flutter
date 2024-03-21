class Artist {
  final String id;
  final String name;
  final List<String> genres;
  final String href;
  final int popularity;
  final String uri;
  final Map<String, dynamic> externalUrls;
  final Map<String, dynamic> followers;
  final List<Map<String, dynamic>> images;

  Artist({
    required this.id,
    required this.name,
    required this.genres,
    required this.href,
    required this.popularity,
    required this.uri,
    required this.externalUrls,
    required this.followers,
    required this.images,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      genres: List<String>.from(json['genres']),
      href: json['href'],
      popularity: json['popularity'],
      uri: json['uri'],
      externalUrls: Map<String, dynamic>.from(json['external_urls']),
      followers: Map<String, dynamic>.from(json['followers']),
      images: List<Map<String, dynamic>>.from(json['images']),
    );
  }
}
