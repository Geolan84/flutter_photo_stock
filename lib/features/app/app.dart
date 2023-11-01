import 'package:flutter/material.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';

/// App main widget.
class PhotoStockApp extends StatelessWidget {
  const PhotoStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Stock',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData.dark(),
      home: const PhotoListScreen(),
    );
  }
}
