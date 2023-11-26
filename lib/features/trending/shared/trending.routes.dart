import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/shared.dart' show TvBuddyRouteConfiguration;
import '../presentation.dart';

/// Trending Feature NavigatorKey
final trendingRouteNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'trendingRouteNavigatorBKey',
);

/// Trending feature route configuration
class TrendingRoute extends TvBuddyRouteConfiguration {
  @override
  StatefulShellBranch get branch => StatefulShellBranch(
        navigatorKey: trendingRouteNavigatorKey,
        routes: [
          GoRoute(
            pageBuilder: (_, __) => getPage(const TrendingPage()),
            path: '/trending',
          ),
        ],
      );

  @override
  List<GoRoute> get routes => [];
}
