import 'package:tmdb_api/tmdb_api.dart';

import 'trending.response.dart';

/// TrendingDatasource
abstract class TrendingDatasource {
  /// get trending people list
  Future<void> getPeople();

  /// get trending movielist
  Future<TrendingResponse> getMovies({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  });

  /// get trending tv list
  Future<TrendingResponse> getTv({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  });

  /// get all trending list
  Future<void> getAll();
}
