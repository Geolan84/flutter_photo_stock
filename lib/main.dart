import 'package:flutter/material.dart';
import 'package:photo_stock/features/app/app.dart';
import 'package:photo_stock/features/app/app_dependencies.dart';
import 'package:surf_logger/surf_logger.dart';

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

void main() {
  _initLogger();
  runApp(
    const AppDependencies(
      app: PhotoStockApp(),
    ),
  );
}
