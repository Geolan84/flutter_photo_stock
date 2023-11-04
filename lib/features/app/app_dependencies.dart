import 'package:flutter/material.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/features/app/app.dart';
import 'package:photo_stock/features/photo_detail/photo_detail_model.dart';
import 'package:photo_stock/features/photo_list/photo_list_model.dart';
import 'package:photo_stock/util/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  ///App instanse.
  final PhotoStockApp app;

  ///Const constructor for AppDependencies.
  const AppDependencies({required this.app, super.key});

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final DefaultErrorHandler _defaultErrorHandler;
  late final IPhotoRepository _photoRepository;
  late final PhotoListScreenModel _photoListScreenModel;
  late final PhotoDetailModel _photoDetailModel;

  @override
  void initState() {
    super.initState();
    _defaultErrorHandler = DefaultErrorHandler();
    // Uncomment this mock initialization for tests.
    //_photoRepository = MockPhotoRepository();
    _photoRepository = PhotoRepository();
    _photoListScreenModel = PhotoListScreenModel(
      _photoRepository,
      _defaultErrorHandler,
    );
    _photoDetailModel = PhotoDetailModel(_defaultErrorHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PhotoListScreenModel>(
          create: (_) => _photoListScreenModel,
        ),
        Provider<PhotoDetailModel>(
          create: (_) => _photoDetailModel,
        ),
      ],
      child: widget.app,
    );
  }
}
