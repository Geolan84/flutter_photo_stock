import 'package:elementary/elementary.dart';
import 'package:surf_logger/surf_logger.dart';

/// Base implementation of error handler.
/// This just print error to console.
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(
    Object error, {
    StackTrace? stackTrace,
  }) {
    // ignore: avoid_print
    Logger.d(error.toString());
  }
}
