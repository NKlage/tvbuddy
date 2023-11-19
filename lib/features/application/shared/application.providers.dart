import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/shared.dart' show CoreProviders;
import '../../trending/shared.dart' show TrendingProviders;
import '../application.dart' show InitAppService, RouteService;
import '../presentation/tv_buddy_theme.dart';

/// Application Feature Providers
class ApplicationProviders {
  // Data
  // Local Datasource

  // Remote Datasource

  // Domain
  // Repository

  // Presentation
  // Controller
  /// App Theme Provider
  static final Provider<TvBuddyTheme> theme = Provider((ref) => TvBuddyTheme());

  // Application

  /// InitRouteService Provider
  static final Provider<RouteService> initRouteService = Provider(
    (ref) => RouteService(
      [
        ref.read(TrendingProviders.routeConfiguration),
      ],
    ),
  );

  /// InitAppService Provider
  static final ProviderFamily<InitAppService, List<Locale>> initAppService =
      Provider.family<InitAppService, List<Locale>>(
    (ref, locales) => InitAppService(
      analyticService: ref.read(CoreProviders.analyzeService(locales)),
      routeService: ref.read(initRouteService),
    ),
  );
}
