import 'package:tmdb_api/tmdb_api.dart';

import '../../core/application.dart';
import '../data.dart' show TrendingDatasource, TrendingResponse;
import '../localization.dart' show TrendingLocalizations;

/// Remote [TrendingDatasource] implementation
class TrendingRemoteDatasource implements TrendingDatasource {
  /// Creates the [TrendingRemoteDatasource] to communicate with the [TMDB] Api
  TrendingRemoteDatasource({
    required TMDB tmdbClient,
    required TrendingLocalizations trendingLocalizations,
  })  : _tmdbClient = tmdbClient,
        _trendingLocalizations = trendingLocalizations;

  final TMDB _tmdbClient;
  final TrendingLocalizations _trendingLocalizations;

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
    Map<dynamic, dynamic> trending;
    try {
      trending = await _tmdbClient.v3.trending.getTrending(
        mediaType: MediaType.movie,
        timeWindow: timeWindow,
        page: page,
        language: language,
      );
    } catch (e) {
      throw ApplicationException(
        message: e.toString(),
        description: _trendingLocalizations.trendingDatasourceApiException,
        isFatal: true,
      );
    }
    return _createResponse(trending);
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
    Map<dynamic, dynamic> trending;
    try {
      trending = await _tmdbClient.v3.trending.getTrending(
        mediaType: MediaType.tv,
        timeWindow: timeWindow,
        page: page,
        language: language,
      );
    } catch (e) {
      throw ApplicationException(
        message: e.toString(),
        description: _trendingLocalizations.trendingDatasourceApiException,
        isFatal: true,
      );
    }

    return _createResponse(trending);
  }

  TrendingResponse _createResponse(Map<dynamic, dynamic> tmdbResponse) {
    try {
      final response =
          TrendingResponse.fromJson(tmdbResponse as Map<String, dynamic>);

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
    } catch (e) {
      throw ApplicationException(
        message: e.toString(),
        description:
            _trendingLocalizations.trendingDatasourceResponseMappingException,
        isFatal: true,
      );
    }
  }
}
