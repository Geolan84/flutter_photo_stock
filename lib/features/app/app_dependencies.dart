import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/data/api/photo/photo_api.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/features/app/app.dart';
import 'package:photo_stock/util/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  ///App instanse.
  final PhotoStockApp app;

  /// @nodoc
  const AppDependencies({required this.app, super.key});

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final DefaultErrorHandler _defaultErrorHandler;
  late final IPhotoRepository _photoRepository;

  @override
  void initState() {
    super.initState();
    _defaultErrorHandler = DefaultErrorHandler();
    // Uncomment this mock initialization for tests.
    //_photoRepository = MockPhotoRepository();
    _photoRepository = PhotoRepository(client: PhotoClient(dio: Dio()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DefaultErrorHandler>(
          create: (_) => _defaultErrorHandler,
        ),
        Provider<IPhotoRepository>(
          create: (_) => _photoRepository,
        )
      ],
      child: widget.app,
    );
  }
}
