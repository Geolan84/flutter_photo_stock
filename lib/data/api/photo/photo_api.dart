import 'package:dio/dio.dart';
import 'package:photo_stock/util/credentials.dart';
import 'package:photo_stock/util/urls.dart';

/// Operates with server api through dio.
class PhotoClient {
  final Dio _dio = Dio();

  /// Send request for new page on server.
  Future<List<dynamic>> getPage(int pageNumber) async {
    final response = await _dio.get(AppUrls.photos,
        queryParameters: {'client_id': Credentials.apiKey, 'page': pageNumber});
    return response.data as List<dynamic>;
  }
}
