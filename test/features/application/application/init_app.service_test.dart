import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvbuddy/features/application/application.dart'
    show InitAppService, RouteService;
import 'package:tvbuddy/features/core/application.dart'
    show AnalyticService, LoggingService;

import 'init_app.service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AnalyticService>(),
  MockSpec<RouteService>(),
  MockSpec<LoggingService>(),
])
void main() {
  test('init service test', () async {
    // Arrange
    final mockAnalyticService = MockAnalyticService();
    final mockRouteService = MockRouteService();
    final mockLoggingService = MockLoggingService();
    final sut = InitAppService(
      analyticService: mockAnalyticService,
      routeService: mockRouteService,
      loggingService: mockLoggingService,
    );
    // Act
    await sut.init();

    // Assert
    verify(mockAnalyticService.init()).called(1);
    verify(mockRouteService.init()).called(1);
    verify(mockLoggingService.init()).called(1);
  });
}
