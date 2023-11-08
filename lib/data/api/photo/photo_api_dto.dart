/// Class describes photo dto entity.
class PhotoApiDto {
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
  PhotoApiDto({
    required this.imageLink,
    required this.username,
    required this.likes,
    required this.color,
    required this.blurHash,
  });

  /// Parse json representation to photo api dto object.
  factory PhotoApiDto.fromJson(body) {
    body = body as Map<String, dynamic>;
    return PhotoApiDto(
      imageLink: (body['urls'] as Map<String, dynamic>)['regular'].toString(),
      username: (body['user'] as Map<String, dynamic>)['username'].toString(),
      likes: int.parse(body['likes'].toString()),
      color: body['color'].toString(),
      blurHash: body['blur_hash'].toString(),
    );
  }
}
