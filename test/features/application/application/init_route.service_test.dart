import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tvbuddy/features/application/application.dart'
    show RouteService;
import 'package:tvbuddy/features/core/shared.dart'
    show TvBuddyRouteConfiguration;

void main() {
  test('should initialize route configuration', () async {
    // Arrange

    // Act

    final sut = RouteService([TestRouteConfiguration()])..init();

    // Assert
    final routes = sut.routeConfiguration.configuration.routes;
    expect(routes.length, 2);
    expect(routes[0], isA<StatefulShellRoute>());
    expect(routes[1], isA<GoRoute>());
  });
}

class TestRouteConfiguration extends TvBuddyRouteConfiguration {
  @override
  StatefulShellBranch get branch => StatefulShellBranch(
        navigatorKey:
            GlobalKey<NavigatorState>(debugLabel: 'testRouteConfiguration'),
        routes: [
          GoRoute(
            path: '/test-shell-route',
            pageBuilder: (_, __) => const MaterialPage(child: Placeholder()),
          ),
        ],
      );

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: '/test-default-route',
          pageBuilder: (_, __) => const MaterialPage(child: Placeholder()),
        ),
      ];
}
