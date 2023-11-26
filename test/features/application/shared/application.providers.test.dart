import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvbuddy/features/application/application.dart'
    show InitAppService, RouteService;
import 'package:tvbuddy/features/application/presentation.dart'
    show TvBuddyTheme;
import 'package:tvbuddy/features/application/shared.dart'
    show ApplicationProviders;

void main() {
  test('application provider test', () async {
    // Arrange

    // Act

    // Assert
    expect(
      ApplicationProviders.initRouteService,
      isA<Provider<RouteService>>(),
    );
    expect(
      ApplicationProviders.initAppService,
      isA<ProviderFamily<InitAppService, List<Locale>>>(),
    );
    expect(
      ApplicationProviders.theme,
      isA<Provider<TvBuddyTheme>>(),
    );
  });
}
