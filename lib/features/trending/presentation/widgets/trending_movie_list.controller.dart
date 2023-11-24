import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart' show TimeWindow;

import '../../../core/application.dart' show AnalyticService;
import '../../application.dart' show TrendingService;
import '../../presentation.dart';

/// Controller for the [TrendingMovieList]
class TrendingMovieListController
    extends StateNotifier<TrendingMovieListControllerState> {
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
  Future<void> getDailyShows({int page = 1}) async {
    try {
      final oldData = state.tvOrMovies.valueOrNull ?? [];
      final tvShows = await _trendingService.dailyTvShows(page: page);
      state = state.copyWith(
        timeWindow: TimeWindow.day,
        hasNext: tvShows.hasNext,
        currentPage: page,
        tvOrMovies: AsyncData([
          ...oldData,
          ...tvShows.tvShows,
        ]),
      );
    } catch (e) {
      _analyticService.logExceptionManual(
        message: e.toString(),
        nonFatal: true,
        stackTrace: StackTrace.current,
        segmentation: {'TrendingMovieListController': 'getDailyShows'},
      );
      state = state.copyWith(tvOrMovies: AsyncError(e, StackTrace.empty));
    }
  }

  /// get weekly trending tv shows
  Future<void> getWeeklyShows({int page = 1}) async {
    try {
      final tvShows = await _trendingService.weeklyTvShows(page: page);
    } catch (e) {}
  }

  /// get daily trending movies
  Future<void> getDailyMovies({int page = 1}) async {
    try {
      final oldData = state.tvOrMovies.valueOrNull ?? [];
      final tvShows = await _trendingService.dailyMovies(page: page);
      state = state.copyWith(
        timeWindow: TimeWindow.day,
        hasNext: tvShows.hasNext,
        currentPage: page,
        tvOrMovies: AsyncData([
          ...oldData,
          ...tvShows.movies,
        ]),
      );
    } catch (e) {
      _analyticService.logExceptionManual(
        message: e.toString(),
        nonFatal: true,
        stackTrace: StackTrace.current,
        segmentation: {'TrendingMovieListController': 'getDailyShows'},
      );
      state = state.copyWith(tvOrMovies: AsyncError(e, StackTrace.empty));
    }
  }
}
