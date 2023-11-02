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
}
