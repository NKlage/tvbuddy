import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/shared.dart' show CoreProviders, TvBuddyRouteConfiguration;
import '../application.dart' show TrendingService;
import '../data.dart'
    show TrendingDatasource, TrendingRemoteDatasource, TrendingRepositoryImpl;
import '../domain.dart' show TrendingRepository;
import '../presentation.dart' show TrendingController;
import '../shared.dart' show TrendingRoute;

/// Trending Feature Providers
class TrendingProviders {
  // Data

  /// Trending Remote Datasource
  static final Provider<TrendingDatasource> trendingRemoteDatasource = Provider(
    (ref) => TrendingRemoteDatasource(
      tmdbClient: ref.read(CoreProviders.tmdbClient),
    ),
  );

  // Domain
  /// Trending Repository
  static final Provider<TrendingRepository> trendingRepository = Provider(
    (ref) => TrendingRepositoryImpl(
      trendingRemoteDatasource: ref.read(trendingRemoteDatasource),
    ),
  );

  // Application
  /// TMDB Trending Service Provider
  static final Provider<TrendingService> trendingService = Provider(
    (ref) => TrendingService(
      trendingRepository: ref.read(trendingRepository),
    ),
  );

  // Presentation
  /// TrendingController
  static final Provider<TrendingController> trendingController =
      Provider((ref) => TrendingController());

  // Shared
  /// Trending Feature Route Configuration
  static final Provider<TvBuddyRouteConfiguration> routeConfiguration =
      Provider((ref) => TrendingRoute());
}
