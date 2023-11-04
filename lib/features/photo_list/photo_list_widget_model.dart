import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';
import 'package:photo_stock/features/photo_list/photo_list_model.dart';
import 'package:photo_stock/util/app_dictionary.dart';
import 'package:provider/provider.dart';
import 'package:surf_logger/surf_logger.dart';

/// Factory for [PhotoListScreenWidgetModel]
PhotoListScreenWidgetModel photoListScreenWMFactory(
  BuildContext context,
) {
  final model = context.read<PhotoListScreenModel>();

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

  /// Constructor for PhotoListScreenWM.
  PhotoListScreenWidgetModel(
    PhotoListScreenModel model,
  ) : super(model);

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
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      _isPageLoading.value = true;
      await _loadAdditionalPage();
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

  Future<void> _loadAdditionalPage() async {
    final previousData = List<Photo>.from(_photoListState.value.data!);
    try {
      final res = await model.loadPage();
      previousData.addAll(res);
      _photoListState.content(previousData);
    } on Exception catch (e) {
      Logger.w(e.toString());
      _photoListState.error(e, previousData);
    }
  }

  Future<void> _loadPhotoList() async {
    final previousData = _photoListState.value.data;
    _photoListState.loading(previousData);

    try {
      final res = await model.loadPage();
      _photoListState.content(res);
    } on Exception catch (e) {
      Logger.w(e.toString());
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
}
