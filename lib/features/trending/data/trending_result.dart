import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_result.freezed.dart';
part 'trending_result.g.dart';

// ignore_for_file: invalid_annotation_target
/// Trending Result response
@freezed
class TrendingResult with _$TrendingResult {
  /// Default Constructor
  const factory TrendingResult({
    required int id,
    required bool adult,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    required String name,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_name') required String originalName,
    required String overview,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'media_type') required String mediaType,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    required num popularity,
    @JsonKey(name: 'first_air_date') required String firstAirDate,
    @JsonKey(name: 'vote_average') required num voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'origin_country') required List<String> originCountry,
    @Default(false) bool video,
  }) = _TrendingResult;

  /// Convert [Map] to [TrendingResult]
  factory TrendingResult.fromJson(Map<String, dynamic> json) =>
      _$TrendingResultFromJson(json);
}
