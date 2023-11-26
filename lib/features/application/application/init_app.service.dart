import 'package:go_router/go_router.dart';

import '../../core/application.dart' show AnalyticService, LoggingService;
import '../../core/shared.dart' show LogLevel;
import '../application.dart';

/// Initialize TV Buddy App
class InitAppService {
  /// Default Constructor
  InitAppService({
    required AnalyticService analyticService,
    required RouteService routeService,
    required LoggingService loggingService,
  })  : _analyticService = analyticService,
        _routeService = routeService,
        _loggingService = loggingService;

  final AnalyticService _analyticService;
  final RouteService _routeService;
  final LoggingService _loggingService;
  late GoRouter _routeConfiguration;

  /// Get app route configuration
  GoRouter get routeConfiguration => _routeConfiguration;

  /// Get Analytic Service
  AnalyticService get analyticService => _analyticService;

  /// initialize application
  Future<void> init() async {
    await _loggingService.init(
      logLevel: LogLevel.debug,
    ); // TODO(nk): get log level from configuration
    // await _analyticService.init();
    _routeService.init();
    _routeConfiguration = _routeService.routeConfiguration;
  }
}
