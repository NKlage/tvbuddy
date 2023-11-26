import 'package:tmdb_api/tmdb_api.dart';

import '../domain.dart';

/// TrendingRepository
abstract class TrendingRepository {
  /// Get trending tv shows
  Future<({bool hasNext, Iterable<TrendingEntity> tvShows})> getTv({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  });

  /// Get trending movies
  Future<({bool hasNext, Iterable<TrendingEntity> movies})> getMovies({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  });
}
