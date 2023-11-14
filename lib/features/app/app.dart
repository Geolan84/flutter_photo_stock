import 'package:flutter/material.dart';
import 'package:photo_stock/features/photo_list/photo_list.dart';
import 'package:photo_stock/util/app_dictionary.dart';

/// App main widget.
class PhotoStockApp extends StatelessWidget {
  /// @nodoc
  const PhotoStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppDictionary.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          secondary: Colors.black,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 4,
              )
            ],
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 4,
              )
            ],
          ),
        ),
      ),
      home: const PhotoListScreen(),
    );
  }
}
