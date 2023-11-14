/// Contains all urls for photo client.
class AppUrls {
  /// Url for specific photo, should be supplement by photo_id.
  static const photoById = '$_apiUrl/photos/';
  static const _apiUrl = 'https://api.unsplash.com';

  /// Url to get page, by default it returns first page with 10 photos.
  static const photos = '$_apiUrl/photos';
}
