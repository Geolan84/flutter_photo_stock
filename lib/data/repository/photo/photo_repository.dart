import 'package:photo_stock/data/api/photo/photo_api.dart';
import 'package:photo_stock/domain/photo/photo.dart';

/// Interface for photo repository.
abstract interface class IPhotoRepository {
  /// Gets photo for first page.
  Future<List<Photo>> getPage();
}

/// Manages photos data for WM.
class PhotoRepository implements IPhotoRepository {
  int _pageNumber = 0;
  final PhotoClient _client = PhotoClient();

  @override
  Future<List<Photo>> getPage() async {
    final photoJson = await _client.getPage(_pageNumber++);
    final res = Photo.getPhotoListFromJson(photoJson);
    return res;
  }
}
