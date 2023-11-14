import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_detail/photo_detail.dart';
import 'package:photo_stock/features/photo_detail/photo_detail_model.dart';
import 'package:photo_stock/util/app_dictionary.dart';
import 'package:photo_stock/util/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Factory for [PhotoDetailWidgetModel]
PhotoDetailWidgetModel photoDetailWMFactory(
  BuildContext context,
) {
  final errorHandler = context.read<DefaultErrorHandler>();
  final model = PhotoDetailModel(errorHandler: errorHandler);
  return PhotoDetailWidgetModel(model);
}

/// Widget Model for [PhotoDetailScreen]
class PhotoDetailWidgetModel
    extends WidgetModel<PhotoDetailScreen, PhotoDetailModel>
    implements IPhotoDetailWidgetModel {
  @override
  ValueListenable<EntityState<Photo>> get photoDetailState =>
      EntityStateNotifier<Photo>();

  @override
  ThemeData get theme => Theme.of(context);

  @override
  void moveToPhotoList() {
    Navigator.pop(context);
  }

  /// Constructor for WM.
  PhotoDetailWidgetModel(
    super.model,
  );

  @override
  void onErrorHandle(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppDictionary.somethingWentWrong)));
    super.onErrorHandle(error);
  }
}

/// Interface of [PhotoDetailWidgetModel]
abstract interface class IPhotoDetailWidgetModel implements IWidgetModel {
  /// Getter for Photo state.
  ValueListenable<EntityState<Photo>> get photoDetailState;

  /// Getter for theme from context.
  ThemeData get theme;

  /// Move to photo list from photo detail screen.
  void moveToPhotoList();
}
