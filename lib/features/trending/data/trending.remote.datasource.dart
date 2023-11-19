import 'package:tmdb_api/tmdb_api.dart';

import '../data.dart' show TrendingDatasource, TrendingResponse;

/// Remote [TrendingDatasource] implementation
class TrendingRemoteDatasource implements TrendingDatasource {
  /// Creates the [TrendingRemoteDatasource] to communicate with the [TMDB] Api
  TrendingRemoteDatasource({required TMDB tmdbClient})
      : _tmdbClient = tmdbClient;

  final TMDB _tmdbClient;

  @override
  Future<void> getAll() {
    // TODO(nk): implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> getMovies() {
    // TODO(nk): implement getMovies
    throw UnimplementedError();
  }

  @override
  Future<void> getPeople() {
    // TODO(nk): implement getPeople
    throw UnimplementedError();
  }

  @override
  Future<TrendingResponse> getTv({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  }) async {
    final trending = await _tmdbClient.v3.trending.getTrending(
      mediaType: MediaType.tv,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );

    return TrendingResponse.fromJson(trending as Map<String, dynamic>);
  }
}
