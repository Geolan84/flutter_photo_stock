/// Class describes photo entity.
class Photo {
  /// URL to image resource of photo.
  final String imageLink;

  /// Count of likes of photo.
  final int likes;

  /// Username of user.
  final String username;

  /// Color of shadow for photo.
  final String color;

  /// Blur hash for image preview.
  final String blurHash;

  /// Constructor for photo entity.
  Photo({
    required this.imageLink,
    required this.username,
    required this.likes,
    required this.color,
    required this.blurHash,
  });

  /// Parse json representation to dart photo object.
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      imageLink: json['urls'].toString(),
      username: json['user'].toString(),
      likes: int.parse(json['likes'].toString()),
      color: json['color'].toString(),
      blurHash: json['blur_hash'].toString(),
    );
  }
}
