import 'package:flutter/material.dart';

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
      home: const Center(
        child: Text('Photo Stock'),
      ),
    );
  }
}
