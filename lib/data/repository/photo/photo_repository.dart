import 'package:photo_stock/data/api/photo/photo_api.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:surf_logger/surf_logger.dart';

class PhotoRepository {
  int _pageNumber = 0;
  final PhotoClient _client = PhotoClient();
  Future<List<Photo>> getPage() async {
    final photoJson = await _client.getPage(_pageNumber++);
    final res = Photo.getPhotoListFromJson(photoJson);
    Logger.d(res.toString());
    return res;
  }

  Future<Iterable<Photo>> getAllPhotos() async {
    //Imitation of work.
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
