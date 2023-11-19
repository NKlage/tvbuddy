import 'package:go_router/go_router.dart';

import '../../core/shared.dart' show TvBuddyRouteConfiguration;
import '../presentation.dart' show StatefulScaffoldWithNavigation;
import '../shared.dart' show rootNavigatorKey;

/// Initialize Routing
class RouteService {
  /// Constructing RouteService
  RouteService(this._configurations);

  final List<TvBuddyRouteConfiguration> _configurations;
  late GoRouter _router;

  /// Get Application Route Configuration
  GoRouter get routeConfiguration => _router;

  /// Initialize Route Service
  void init() {
    final branches =
        _configurations.map((e) => e.branch).toList(growable: false);

    final routes = <GoRoute>[];

    for (final configuration in _configurations) {
      routes.addAll(configuration.routes);
    }

    _router = GoRouter(
      initialLocation: '/trending',
      navigatorKey: rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) {
            return StatefulScaffoldWithNavigation(
              navigationShell: navigationShell,
            );
          },
          branches: branches,
        ),
        ...routes,
      ],
    );
  }
}
