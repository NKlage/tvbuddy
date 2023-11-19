import 'package:intl/intl.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../domain.dart' show TrendingEntity, TrendingRepository;

/// Trending Service
class TrendingService {
  /// Default Constructor
  TrendingService({required TrendingRepository trendingRepository})
      : _trendingRepository = trendingRepository;
  final TrendingRepository _trendingRepository;
  final String _locale = Intl.getCurrentLocale();

  /// Get daily Trending TV Shows
  Future<({bool hasNext, Iterable<TrendingEntity> tvShows})> dailyTvShows({
    required int page,
  }) async {
    return _trendingRepository.getTv(
      page: page,
      language: _locale,
    );
  }

  /// Get weekly Trending TV Shows
  Future<({bool hasNext, Iterable<TrendingEntity> tvShows})> weeklyTvShows({
    required int page,
  }) async {
    return _trendingRepository.getTv(
      page: page,
      language: _locale,
      timeWindow: TimeWindow.week,
    );
  }
}
