import 'package:flutter/material.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';
import 'package:photo_stock/util/app_dictionary.dart';

/// App main widget.
class PhotoStockApp extends StatelessWidget {
  /// App constructor.
  const PhotoStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppDictionary.appName,
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData.dark(),
      home: const PhotoListScreen(),
    );
  }
}
