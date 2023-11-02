import 'package:elementary/elementary.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';

/// Model for [PhotoListScreen]
class PhotoDetailModel extends ElementaryModel {
  PhotoDetailModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
