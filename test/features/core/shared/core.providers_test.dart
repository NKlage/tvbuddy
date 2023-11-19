import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:tvbuddy/features/core/application.dart' show AnalyticService;
import 'package:tvbuddy/features/core/domain.dart' show ConfigurationEntity;
import 'package:tvbuddy/features/core/localization.dart' show CoreLocalizations;
import 'package:tvbuddy/features/core/shared.dart' show CoreProviders;

void main() {
  test('core providers tests', () async {
    // Arrange

    // Act

    // Assert
    expect(CoreProviders.tmdbClient, isA<Provider<TMDB>>());
    expect(CoreProviders.configuration, isA<Provider<ConfigurationEntity>>());
    expect(
      CoreProviders.analyzeService,
      isA<ProviderFamily<AnalyticService, List<Locale>>>(),
    );
    expect(
      CoreProviders.coreLocalizationsProvider,
      isA<Provider<CoreLocalizations>>(),
    );
  });
}
