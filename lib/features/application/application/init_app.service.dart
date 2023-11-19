import 'package:go_router/go_router.dart';

import '../../core/application.dart' show AnalyticService;
import '../application.dart';

/// Initialize TV Buddy App
class InitAppService {
  /// Default Constructor
  InitAppService({
    required AnalyticService analyticService,
    required RouteService routeService,
  })  : _analyticService = analyticService,
        _routeService = routeService;

  final AnalyticService _analyticService;
  final RouteService _routeService;
  late GoRouter _routeConfiguration;

  /// Get app route configuration
  GoRouter get routeConfiguration => _routeConfiguration;

  /// Get Analytic Service
  AnalyticService get analyticService => _analyticService;

  /// initialize application
  Future<void> init() async {
    await _analyticService.init();
    _routeService.init();
    _routeConfiguration = _routeService.routeConfiguration;
  }
}
