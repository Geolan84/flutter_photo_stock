import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_detail/photo_detail.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';
import 'package:photo_stock/features/photo_list/photo_list_model.dart';
import 'package:photo_stock/util/app_dictionary.dart';
import 'package:photo_stock/util/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Factory for [PhotoListScreenWidgetModel]
PhotoListScreenWidgetModel photoListScreenWMFactory(
  BuildContext context,
) {
  final repository = context.read<PhotoRepository>();
  final errorHandler = context.read<DefaultErrorHandler>();
  final model = PhotoListScreenModel(
    repository,
    errorHandler,
  );
  return PhotoListScreenWidgetModel(model);
}

/// Widget Model for [PhotoListScreen]
class PhotoListScreenWidgetModel
    extends WidgetModel<PhotoListScreen, PhotoListScreenModel>
    implements IPhotoListWidgetModel {
  final _photoListState = EntityStateNotifier<List<Photo>>();
  final _scrollController = ScrollController();
  final _alignTitleCenter = ValueNotifier<bool>(true);
  final _isPageLoading = ValueNotifier<bool>(false);

  @override
  ValueListenable<bool> get alignTitleCenter => _alignTitleCenter;

  @override
  ValueListenable<EntityState<List<Photo>>> get photoListState =>
      _photoListState;

  @override
  ValueListenable<bool> get isPageLoading => _isPageLoading;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  void moveToPhotoDetail(Photo photo, Image photoImage) {
    final detail = MaterialPageRoute(
        builder: (_) =>
            PhotoDetailScreen(photo: photo, photoImage: photoImage));
    Navigator.push(context, detail);
  }

  /// Constructor for PhotoListScreenWM.
  PhotoListScreenWidgetModel(
    super.model,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadPhotoList();
    scrollController
      ..addListener(handleStartScrolling)
      ..addListener(handleNextPage);
  }

  /// Handles starting of scrolling, inderectly changes app bar alignment.
  Future<void> handleStartScrolling() async {
    _alignTitleCenter.value = _scrollController.position.pixels < 10;
  }

  /// Handler for scroll controller, checks moment of reach the end and starts new page loading.
  Future<void> handleNextPage() async {
    if (!isPageLoading.value &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
      _isPageLoading.value = true;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onErrorHandle(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppDictionary.somethingWentWrong)));
    super.onErrorHandle(error);
  }

  Future<void> _loadPhotoList() async {
    final previousData = _photoListState.value.data;
    _photoListState.loading(previousData);

    try {
      final res = await model.loadPhotosList();
      _photoListState.content(res);
    } on Exception catch (e) {
      _photoListState.error(e, previousData);
    }
  }
}

/// Interface of [PhotoListScreenWidgetModel]
abstract interface class IPhotoListWidgetModel implements IWidgetModel {
  /// Listenable list of photos to show on the screen.
  ValueListenable<EntityState<List<Photo>>> get photoListState;

  /// Listenable boolean state of new page loading process for progress indicator.
  ValueListenable<bool> get isPageLoading;

  /// Listenable boolean state of app bar alignment during scrolling.
  ValueListenable<bool> get alignTitleCenter;

  /// Scroll controller for CustomScrollView.
  ScrollController get scrollController;

  /// Getter for theme from context.
  ThemeData get theme;

  /// Move to photo detail screen from photo list.
  void moveToPhotoDetail(Photo photo, Image photoImage);
}
