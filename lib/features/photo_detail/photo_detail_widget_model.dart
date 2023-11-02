import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_detail/photo_detail.dart';
import 'package:photo_stock/features/photo_detail/photo_detail_model.dart';
import 'package:provider/provider.dart';

/// Factory for [PhotoDetailWidgetModel]
PhotoDetailWidgetModel photoDetailWMFactory(
  BuildContext context,
) {
  final model = context.read<PhotoDetailModel>();

  return PhotoDetailWidgetModel(model);
}

/// Widget Model for [PhotoDetailScreen]
class PhotoDetailWidgetModel
    extends WidgetModel<PhotoDetailScreen, PhotoDetailModel>
    implements IPhotoDetailWidgetModel {
  final _photoDetailState = EntityStateNotifier<Photo>();

  @override
  ValueListenable<EntityState<Photo>> get photoDetailState => _photoDetailState;

  PhotoDetailWidgetModel(
    PhotoDetailModel model,
  ) : super(model);

  @override
  void onErrorHandle(Object error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    super.onErrorHandle(error);
  }
}

/// Interface of [PhotoDetailWidgetModel]
abstract interface class IPhotoDetailWidgetModel implements IWidgetModel {
  ValueListenable<EntityState<Photo>> get photoDetailState;
}
