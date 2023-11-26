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
  Future<TrendingResponse> getMovies({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  }) async {
    final trending = await _tmdbClient.v3.trending.getTrending(
      mediaType: MediaType.movie,
      timeWindow: timeWindow,
      page: page,
      language: language,
    );
    final response =
        TrendingResponse.fromJson(trending as Map<String, dynamic>);

    final resultsWithImagePath = response.results.map((element) {
      return element.copyWith(
        backdropPath: _tmdbClient.images.getUrl(
              element.backdropPath,
              size: ImageSizes.BACKDROP_SIZE_MEDIUM,
            ) ??
            element.backdropPath,
        posterPath: _tmdbClient.images.getUrl(
              element.posterPath,
              size: ImageSizes.POSTER_SIZE_MEDIUM,
            ) ??
            element.posterPath,
      );
    }).toList(growable: false);

    return response.copyWith(results: resultsWithImagePath);
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
    final response =
        TrendingResponse.fromJson(trending as Map<String, dynamic>);

    final resultsWithImagePath = response.results.map((element) {
      return element.copyWith(
        backdropPath: _tmdbClient.images.getUrl(
              element.backdropPath,
              size: ImageSizes.BACKDROP_SIZE_MEDIUM,
            ) ??
            element.backdropPath,
        posterPath: _tmdbClient.images.getUrl(
              element.posterPath,
              size: ImageSizes.POSTER_SIZE_MEDIUM,
            ) ??
            element.posterPath,
      );
    }).toList(growable: false);

    return response.copyWith(results: resultsWithImagePath);
  }
}
