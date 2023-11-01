import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/domain/photo/photo.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';
import 'package:photo_stock/features/photo_list/photo_list_model.dart';
import 'package:provider/provider.dart';

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
  final _alignTitleCenter = ValueNotifier<bool>(false);
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

  Future<void> handleStartScrolling() async {
    _alignTitleCenter.value = _scrollController.position.pixels < 10;
  }

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
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    super.onErrorHandle(error);
  }

  Future<void> _loadPhotoList() async {
    final previousData = _photoListState.value.data;
    _photoListState.loading(previousData);

    try {
      final res = await model.loadCountries();
      _photoListState.content(res);
    } on Exception catch (e) {
      _photoListState.error(e, previousData);
    }
  }
}

/// Interface of [PhotoListScreenWidgetModel]
abstract interface class IPhotoListWidgetModel implements IWidgetModel {
  ValueListenable<EntityState<List<Photo>>> get photoListState;
  ValueListenable<bool> get isPageLoading;
  ValueListenable<bool> get alignTitleCenter;
  ScrollController get scrollController;
}
