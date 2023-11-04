import 'package:flutter/material.dart';

/// Class describes photo entity.
class Photo {
  /// URL to image resource of photo.
  final String imageLink;

  /// Count of likes of photo.
  final int likes;

  /// Username of user.
  final String username;

  /// Color of shadow for photo.
  final Color color;

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
    Color parsedColor;
    // Shadow color in json stores in String, code parses it to hex and cast to material Color.
    try {
      parsedColor = Color(
          int.parse(json['color'].toString().substring(1, 7), radix: 16) +
              0xFF000000);
    } on Exception {
      parsedColor = Colors.brown;
    }
    return Photo(
      imageLink: (json['urls'] as Map<String, dynamic>)['regular'].toString(),
      username: (json['user'] as Map<String, dynamic>)['username'].toString(),
      likes: int.parse(json['likes'].toString()),
      color: parsedColor,
      blurHash: json['blur_hash'].toString(),
    );
  }

  /// Parses json to list of photos.
  static List<Photo> getPhotoListFromJson(List<dynamic> src) {
    return src.map((i) => Photo.fromJson(i as Map<String, dynamic>)).toList();
  }
}
