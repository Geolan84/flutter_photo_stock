//import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:photo_stock/data/repository/photo/photo_repository.dart';
import 'package:photo_stock/features/app/app.dart';
import 'package:photo_stock/features/photo_detail/photo_detail_model.dart';
import 'package:photo_stock/features/photo_list/photo_list_model.dart';
import 'package:photo_stock/util/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  final PhotoStockApp app;

  const AppDependencies({required this.app, super.key});

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  //late final Dio _http;
  late final DefaultErrorHandler _defaultErrorHandler;
  //late final PhotoClient _photoClient;
  late final PhotoRepository _photoRepository;
  late final PhotoListScreenModel _photoListScreenModel;
  late final PhotoDetailModel _photoDetailModel;

  @override
  void initState() {
    super.initState();

    //_http = Dio();
    _defaultErrorHandler = DefaultErrorHandler();
    //_countryClient = CountryClient(_http);
    _photoRepository = PhotoRepository();
    // Uncomment to use mock instead real backend
    // _countryRepository = MockCountryRepository();

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
        //Provider<PhotoClient>(create: (_) => _photoClient,)
        // Provider<ThemeWrapper>(
        //   create: (_) => _themeWrapper,
        // ),
      ],
      child: widget.app,
    );
  }
}
