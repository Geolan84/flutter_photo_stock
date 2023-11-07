import 'package:elementary/elementary.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';

/// Model for [PhotoListScreen]
class PhotoListScreenModel extends ElementaryModel {
  final IPhotoRepository _photoRepository;

  /// @nodoc
  PhotoListScreenModel(
    this._photoRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Loads new page from photo repository.
  Future<List<Photo>> loadPage() async {
    try {
      final res = await _photoRepository.getPage();
      return res;
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
