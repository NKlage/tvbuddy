import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvbuddy/features/core/shared.dart'
    show TvBuddyRouteConfiguration;
import 'package:tvbuddy/features/trending/data.dart' show TrendingDatasource;
import 'package:tvbuddy/features/trending/domain.dart' show TrendingRepository;
import 'package:tvbuddy/features/trending/presentation.dart'
    show TrendingController;
import 'package:tvbuddy/features/trending/shared.dart' show TrendingProviders;

void main() {
  test('trending providers tests', () async {
    // Arrange

    // Act

    // Assert
    expect(
      TrendingProviders.trendingRemoteDatasource,
      isA<Provider<TrendingDatasource>>(),
    );
    expect(
      TrendingProviders.trendingRepository,
      isA<Provider<TrendingRepository>>(),
    );
    expect(
      TrendingProviders.trendingController,
      isA<Provider<TrendingController>>(),
    );
    expect(
      TrendingProviders.routeConfiguration,
      isA<Provider<TvBuddyRouteConfiguration>>(),
    );
  });
}
