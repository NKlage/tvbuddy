import '../../../test_utils/test_json_responses.dart';

class TrendingJsonResponses extends TestJsonResponses {
  static const _jsonRoot = 'test/features/trending/responses';
  static const tvShows = '$_jsonRoot/trending_tv_shows_response.json';
  static const tvShowsWithNullValues =
      '$_jsonRoot/trending_tv_shows_with_null_values_response.json';
}
