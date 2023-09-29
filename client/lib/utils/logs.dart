import 'package:logger/logger.dart';

class Logs {
  static final Logger _logger = Logger();

  static void traceLog(String message) => _logger.t(message);

  static void debugLog(String message) => _logger.d(message);

  static void infoLog(String message) => _logger.i(message);

  static void warningLog(String message, String error) =>
      _logger.w(message, error: error);

  static void fatalLog(String message, String error, StackTrace stackTrace) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}
