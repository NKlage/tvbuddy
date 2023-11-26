import 'package:flutter/foundation.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart' as default_logger;

import '../shared.dart' show LogLevel;

/// Configure Application Logging
abstract class LoggingService {
  /// Init [LoggingService]
  Future<void> init({LogLevel logLevel = LogLevel.error}) async {
    var level = default_logger.LogLevel.error;
    try {
      level = default_logger.LogLevel.values.firstWhere(
        (value) => value.name.toLowerCase() == logLevel.name.toLowerCase(),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    default_logger.Loggy.initLoggy(
      logPrinter: LogLevel.error == logLevel
          ? const default_logger.DefaultPrinter()
          : const PrettyDeveloperPrinter(),
      logOptions: default_logger.LogOptions(
        level,
      ),
    );
  }
}
