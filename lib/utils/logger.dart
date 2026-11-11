import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static void debug(String message) => _write('DEBUG', message);
  static void info(String message) => _write('INFO', message);
  static void warning(String message) => _write('WARNING', message);
  static void error(String message) => _write('ERROR', message);

  static void _write(String level, String message) {
    if (kDebugMode) {
      debugPrint('[${DateTime.now().toIso8601String()}] [$level] $message');
    }
  }
}
