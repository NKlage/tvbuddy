import 'package:freezed_annotation/freezed_annotation.dart';

import 'trending_result.dart';

part 'trending.response.freezed.dart';
part 'trending.response.g.dart';

/// Default Datasource Response
// ignore_for_file: invalid_annotation_target
@freezed
class TrendingResponse with _$TrendingResponse {
  /// Default Constructor
  const factory TrendingResponse({
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
    required List<TrendingResult> results,
  }) = _TrendingResponse;

  /// Convert from [Map] to [TrendingResponse]
  factory TrendingResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingResponseFromJson(json);
}
