import 'package:dio/dio.dart';
import 'package:photo_stock/util/credentials.dart';
import 'package:photo_stock/util/urls.dart';

class PhotoClient {
  final Dio _dio = Dio();

  Future<List<dynamic>> getPage(int pageNumber) async {
    final response = await _dio.get(AppUrls.photos,
        queryParameters: {'client_id': Credentials.apiKey, 'page': pageNumber});
    return response.data as List<dynamic>;
  }
}
