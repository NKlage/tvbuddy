import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvbuddy/features/trending/data.dart';

import '../responses/trending_json_responses.dart';
import 'trending.repository.impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TrendingDatasource>()])
void main() {
  late MockTrendingDatasource mockTrendingDatasource;
  late TrendingResponse trendingTvResponse;

  setUpAll(() async {
    mockTrendingDatasource = MockTrendingDatasource();
    final jsonResponses = TrendingJsonResponses();
    final trendingTvResponseJson = await jsonResponses.getJson(
      TrendingJsonResponses.tvShows,
    );
    trendingTvResponse = TrendingResponse.fromJson(
      jsonDecode(trendingTvResponseJson) as Map<String, dynamic>,
    );
  });

  test('should return trending tv shows', () async {
    // Arrange
    final sut = TrendingRepositoryImpl(
      trendingRemoteDatasource: mockTrendingDatasource,
    );

    when(mockTrendingDatasource.getTv())
        .thenAnswer((_) => Future.value(trendingTvResponse));

    // Act
    final trendingTvShows = await sut.getTv();

    // Assert
    expect(trendingTvShows.hasNext, isTrue);
    expect(trendingTvShows.tvShows.length, 20);
  });
}
