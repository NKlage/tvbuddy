import '../application.dart';
import '../shared.dart' show LogLevel;

/// Executes Tasks to configure TV Buddy App on Startup
abstract class AppInitService {
  late AnalyticService _analyticService;
  late LoggingService _loggingService;

  /// Set [AnalyticService] implementation
  // ignore: avoid_setters_without_getters
  set analyticService(AnalyticService analyticService) {
    _analyticService = analyticService;
  }

  /// Set [LoggingService] implementation
  // ignore: avoid_setters_without_getters
  set loggingService(LoggingService loggingService) {
    _loggingService = loggingService;
  }

  /// Initialize Application
  Future<void> init() async {
    await initAnalyticService();
    await initLoggingService();
  }

  /// Initialize [AnalyticService]
  Future<void> initAnalyticService() async {
    return _analyticService.init();
  }

  /// Initialize [LoggingService]
  Future<void> initLoggingService() async {
    return _loggingService.init(logLevel: LogLevel.debug);
  }
}
