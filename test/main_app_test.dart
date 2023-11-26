import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvbuddy/features/trending/application.dart';
import 'package:tvbuddy/features/trending/domain.dart';
import 'package:tvbuddy/features/trending/shared.dart';

import 'main_app_test.mocks.dart';
import 'widget_test_helper_extensions.dart';

@GenerateNiceMocks([MockSpec<TrendingService>()])
void main() {
  testWidgets('main app test', (tester) async {
    // Arrange
    final mockTrendingService = MockTrendingService();
    await tester.pumpTvBuddyApp(
      overrides: [
        TrendingProviders.trendingService
            .overrideWith((ref) => mockTrendingService),
      ],
    );

    final tvShows = [
      const TrendingEntity(
        id: 0,
        adult: true,
        backdropPath: 'backdropPath',
        name: 'name',
        originalLanguage: 'originalLanguage',
        originalName: 'originalName',
        overview: 'overview',
        posterPath: 'posterPath',
        mediaType: 'mediaType',
        genreIds: [],
        popularity: 0,
        firstAirDate: 'firstAirDate',
        voteAverage: 0,
        voteCount: 0,
        originCountry: [],
        video: false,
      ),
    ];

    // Act
    when(mockTrendingService.dailyTvShows(page: 1))
        .thenAnswer((_) => Future.value((hasNext: false, tvShows: tvShows)));

    // Assert
    expect(find.text('TV Buddy'), findsOneWidget);
    expect(find.text('Trending TV'), findsOneWidget);
    expect(find.text('Section A'), findsOneWidget);
    expect(find.text('Section B'), findsOneWidget);
  });
}
