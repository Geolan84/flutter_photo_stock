import 'package:photo_stock/data/api/photo/photo_api_dto.dart';

/// Class describes photo entity.
class Photo {
  /// URL to image resource of photo.
  final String imageLink;

  /// Count of likes of photo.
  final int likes;

  /// Username of user.
  final String username;

  /// Color of shadow for photo.
  final int color;

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

  /// Mocked color for photo's shadow by default.
  static const mockColor = 0xffb74093;

  /// Factory for converting PhotoApiDto to Photo
  factory Photo.fromPhotoApiDto(PhotoApiDto apiPhoto) {
    /// Since we get shadow color as `0x######`, we have to cut first symbol and add non-transparent alpha channel.
    int parsedColor;

    try {
      parsedColor =
          int.parse(apiPhoto.color.substring(1, 7), radix: 16) + 0xFF000000;
    } on Exception {
      parsedColor = mockColor;
    }
    return Photo(
      blurHash: apiPhoto.blurHash,
      imageLink: apiPhoto.imageLink,
      likes: apiPhoto.likes,
      username: apiPhoto.username,
      color: parsedColor,
    );
  }

  /// Parses json to list of photos.
  static List<Photo> getPhotoListFromPhotoDto(List<PhotoApiDto> src) {
    return src.map(Photo.fromPhotoApiDto).toList();
  }
}
