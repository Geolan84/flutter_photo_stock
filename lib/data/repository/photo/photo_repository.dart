import 'package:photo_stock/domain/photo/photo.dart';

/// Interface for photo repository.
abstract interface class IPhotoRepository {
  /// Gets photo for first page.
  Future<Iterable<Photo>> getAllPhotos();
}

/// Manages photos data for WM.
class PhotoRepository {
  /// Gets photo for first page.
  Future<Iterable<Photo>> getAllPhotos() async {
    // Imitation of work.
    await Future.delayed(const Duration(seconds: 1));
    return Future(
      () => List<Photo>.generate(
        10,
        (index) => Photo(
          imageLink:
              'https://wallpapers.com/images/hd/funny-shrek-h7n6n0iogb00kcan.jpg',
          username: 'Shrek${index + 1}',
          likes: 28,
          color: '#260c0c',
          blurHash: 'L6PZfSi_.AyE_3t7t7R**0o#DgR4',
        ),
      ),
    );
  }
}
