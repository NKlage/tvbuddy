import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending.entity.freezed.dart';

/// Default Repository Entity
@freezed
class TrendingEntity with _$TrendingEntity {
  /// Default Constructor
  const factory TrendingEntity({
    required int id,
    required bool adult,
    required String backdropPath,
    required String name,
    required String originalLanguage,
    required String originalName,
    required String overview,
    required String posterPath,
    required String mediaType,
    required List<int> genreIds,
    required num popularity,
    required String firstAirDate,
    required num voteAverage,
    required int voteCount,
    required List<String> originCountry,
    required bool video,
  }) = _TrendingEntity;
}
