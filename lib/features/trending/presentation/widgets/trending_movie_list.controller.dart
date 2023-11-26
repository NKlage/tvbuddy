import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart' show TimeWindow;

import '../../../core/application.dart' show AnalyticService;
import '../../../core/shared.dart';
import '../../application.dart' show TrendingService;
import '../../domain.dart';
import '../../presentation.dart';

/// Controller for the [TrendingMovieList]
class TrendingMovieListController
    extends StateNotifier<TrendingMovieListControllerState>
    with PresentationLogger {
  /// Default Constructor
  TrendingMovieListController({
    required TrendingMovieListControllerState state,
    required TrendingService trendingService,
    required AnalyticService analyticService,
  })  : _trendingService = trendingService,
        _analyticService = analyticService,
        super(state);

  final TrendingService _trendingService;
  final AnalyticService _analyticService;

  /// Get daily trending tv shows
  Future<void> getTvShows({int page = 1}) async {
    try {
      Iterable<TrendingEntity> oldData = [];

      if (1 < page) {
        oldData = state.tvOrMovies.valueOrNull ?? [];
      }

      final getShows = TimeWindow.week == state.timeWindow
          ? _trendingService.weeklyTvShows(page: page)
          : _trendingService.dailyTvShows(page: page);

      final tvShows = await getShows;
      state = state.copyWith(
        timeWindow: state.timeWindow,
        hasNext: tvShows.hasNext,
        currentPage: page,
        tvOrMovies: AsyncData([
          ...oldData,
          ...tvShows.tvShows,
        ]),
      );
    } catch (e, stack) {
      loggy.error(e, stack);
      _analyticService.logExceptionManual(
        message: e.toString(),
        nonFatal: true,
        stackTrace: stack,
        segmentation: {'TrendingMovieListController': 'getDailyShows'},
      );
      state = state.copyWith(tvOrMovies: AsyncError(e, StackTrace.empty));
    }
  }

  /// Toggle TV List TimeWindow
  Future<void> toogleTimeWindow() async {
    final newTimeWindow =
        TimeWindow.day == state.timeWindow ? TimeWindow.week : TimeWindow.day;

    state = state.copyWith(timeWindow: newTimeWindow);

    await getTvShows();
  }
}
