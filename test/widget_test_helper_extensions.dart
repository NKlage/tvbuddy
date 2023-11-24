import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tvbuddy/features/application/application.dart'
    show RouteService;
import 'package:tvbuddy/features/application/presentation.dart' show TvBuddyApp;
import 'package:tvbuddy/features/application/presentation/tv_buddy_theme.dart';
import 'package:tvbuddy/features/trending/shared.dart' show TrendingRoute;

extension WidgetTestHelperExtensions on WidgetTester {
  Future<void> pumpTvBuddyApp({GoRouter? routeConfiguration}) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final defaultRouteConfiguration = RouteService([TrendingRoute()])..init();
    return pumpWidget(
      ProviderScope(
        child: TvBuddyApp(
          routeConfiguration: routeConfiguration ??
              defaultRouteConfiguration.routeConfiguration,
          theme: TvBuddyTheme(),
        ),
      ),
    );
  }
}
