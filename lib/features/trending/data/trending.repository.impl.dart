import 'package:tmdb_api/tmdb_api.dart';

import '../data.dart';
import '../domain.dart';

/// Repository Implementation of [TrendingRepository]
class TrendingRepositoryImpl implements TrendingRepository {
  /// Default Constructor
  TrendingRepositoryImpl({required TrendingDatasource trendingRemoteDatasource})
      : _trendingRemoteDatasource = trendingRemoteDatasource;

  final TrendingDatasource _trendingRemoteDatasource;

  @override
  Future<({bool hasNext, Iterable<TrendingEntity> tvShows})> getTv({
    TimeWindow timeWindow = TimeWindow.day,
    int page = 1,
    String? language,
  }) async {
    final tvShows = await _trendingRemoteDatasource.getTv(
      timeWindow: timeWindow,
      page: page,
      language: language,
    );

    final hasNext = tvShows.page < tvShows.totalPages;
    return (hasNext: hasNext, tvShows: tvShows.toEntity());
  }
}

extension _TrendingResponseExtension on TrendingResponse {
  Iterable<TrendingEntity> toEntity() {
    return results.map(
      (e) => TrendingEntity(
        id: e.id,
        adult: e.adult,
        backdropPath: e.backdropPath,
        name: e.name,
        originalLanguage: e.originalLanguage,
        originalName: e.originalName,
        overview: e.overview,
        posterPath: e.posterPath,
        mediaType: e.mediaType,
        genreIds: e.genreIds,
        popularity: e.popularity,
        firstAirDate: e.firstAirDate,
        voteAverage: e.voteAverage,
        voteCount: e.voteCount,
        originCountry: e.originCountry,
        video: e.video,
      ),
    );
  }
}
