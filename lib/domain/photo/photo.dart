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
      imageLink: (json['urls'] as Map<String, dynamic>)['regular'].toString(),
      username: (json['user'] as Map<String, dynamic>)['username'].toString(),
      likes: int.parse(json['likes'].toString()),
      color: json['color'].toString(),
      blurHash: json['blur_hash'].toString(),
    );
  }

  static List<Photo> getPhotoListFromJson(List<dynamic> src) {
    return src.map((i) => Photo.fromJson(i as Map<String, dynamic>)).toList();
  }
}
