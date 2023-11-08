import 'package:photo_stock/data/api/photo/photo_api.dart';
import 'package:photo_stock/domain/photo/photo.dart';

/// Interface for photo repository.
abstract interface class IPhotoRepository {
  /// Gets photo for first page.
  Future<List<Photo>> getPage(int pageNumber);
}

/// Manages photos data for WM.
class PhotoRepository implements IPhotoRepository {
  /// Api client instanse.
  final IPhotoClient client;

  /// @nodoc
  PhotoRepository({required this.client});

  @override
  Future<List<Photo>> getPage(int pageNumber) async {
    final photoJson = await client.getPage(pageNumber);
    final res = Photo.getPhotoListFromPhotoDto(photoJson);
    return res;
  }
}

/// Mock of photo repository, returns mock photos.
class MockPhotoRepository implements IPhotoRepository {
  @override
  Future<List<Photo>> getPage(int pageNumber) async {
    // Imitation of loading.
    await Future.delayed(const Duration(seconds: 1));
    return Future(
      () => List<Photo>.generate(
        10,
        (index) => Photo(
          imageLink:
              'https://wallpapers.com/images/hd/funny-shrek-h7n6n0iogb00kcan.jpg',
          username: 'Shrek${index + 1}',
          likes: 28,
          color: 0xffb74093,
          blurHash: 'L6PZfSi_.AyE_3t7t7R**0o#DgR4',
        ),
      ),
    );
  }
}
