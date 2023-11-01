class Photo {
  final String imageLink;
  final int likes;
  final String username;
  final String color;
  final String blurHash;

  Photo({
    required this.imageLink,
    required this.username,
    required this.likes,
    required this.color,
    required this.blurHash,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      imageLink: json['urls'].toString(), //['regular'].toString(),
      username: json['user'].toString(), //['username'],
      likes: int.parse(json['likes'].toString()),
      color: json['color'].toString(),
      blurHash: json['blur_hash'].toString(),
    );
  }
}
