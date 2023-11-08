import 'package:dio/dio.dart';
import 'package:photo_stock/data/api/photo/photo_api_dto.dart';
import 'package:photo_stock/util/credentials.dart';
import 'package:photo_stock/util/urls.dart';

/// Interface for PhotoClient.
abstract interface class IPhotoClient {
  /// Get json from server with page of photos by page number.
  Future<List<PhotoApiDto>> getPage(int pageNumber);
}

/// Operates with server api through dio.
class PhotoClient implements IPhotoClient {
  /// Dio instanse.
  final Dio dio;

  /// @nodoc
  PhotoClient({required this.dio});

  @override
  Future<List<PhotoApiDto>> getPage(int pageNumber) async {
    final response = await dio.get(AppUrls.photos,
        queryParameters: {'client_id': Credentials.apiKey, 'page': pageNumber});
    final photos = await response.data as List<dynamic>;
    return photos.map(PhotoApiDto.fromJson).toList();
  }
}
