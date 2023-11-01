//import 'package:/data/repository/country/country_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';

/// Model for [PhotoListScreen]
class PhotoListScreenModel extends ElementaryModel {
  final PhotoRepository _photoRepository;

  PhotoListScreenModel(
    this._photoRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Return iterable countries.
  Future<List<Photo>> loadCountries() async {
    try {
      final res = await _photoRepository.getAllPhotos();
      return res.toList();
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
