import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/shared.dart' show CoreProviders, TvBuddyRouteConfiguration;
import '../application.dart' show TrendingService;
import '../data.dart'
    show TrendingDatasource, TrendingRemoteDatasource, TrendingRepositoryImpl;
import '../domain.dart' show TrendingRepository;
import '../l10n/trending_localization.dart';
import '../presentation.dart'
    show
        TrendingController,
        TrendingMovieListController,
        TrendingMovieListControllerState;
import '../shared.dart' show TrendingRoute;

/// Trending Feature Providers
class TrendingProviders {
  // Data

  /// Trending Remote Datasource
  static Provider<TrendingDatasource> trendingRemoteDatasource = Provider(
    (ref) => TrendingRemoteDatasource(
      tmdbClient: ref.read(CoreProviders.tmdbClient),
    ),
  );

  // Domain
  /// Trending Repository
  static Provider<TrendingRepository> trendingRepository = Provider(
    (ref) => TrendingRepositoryImpl(
      trendingRemoteDatasource: ref.read(trendingRemoteDatasource),
    ),
  );

  // Application
  /// TMDB Trending Service Provider
  static Provider<TrendingService> trendingService = Provider(
    (ref) => TrendingService(
      trendingRepository: ref.read(trendingRepository),
    ),
  );

  // Presentation
  /// TrendingController
  static Provider<TrendingController> trendingController =
      Provider((ref) => TrendingController());

  /// TrendingMovieListController Provider
  static AutoDisposeStateNotifierProvider<TrendingMovieListController,
          TrendingMovieListControllerState> trendingMovieListController =
      StateNotifierProvider.autoDispose<TrendingMovieListController,
          TrendingMovieListControllerState>((ref) {
    return TrendingMovieListController(
      state: const TrendingMovieListControllerState(),
      trendingService: ref.read(trendingService),
      analyticService: ref.read(
        CoreProviders.analyzeService(
          TrendingLocalizations.supportedLocales,
        ),
      ),
    );
  });

  // Shared
  /// Trending Feature Route Configuration
  static final Provider<TvBuddyRouteConfiguration> routeConfiguration =
      Provider((ref) => TrendingRoute());
}
