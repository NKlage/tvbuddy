import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:tvbuddy/features/core/application.dart';
import 'package:tvbuddy/features/trending/data.dart';
import 'package:tvbuddy/features/trending/data/trending_result.dart';
import 'package:tvbuddy/features/trending/l10n/trending_localization.dart';

import '../responses/trending_json_responses.dart';

void main() {
  late TrendingJsonResponses jsonResponses;
  late Dio dio;
  late DioAdapter dioAdapter;
  late TMDB tmdbClient;
  late TrendingLocalizations localization;

  setUp(() {});

  setUpAll(() {
    jsonResponses = TrendingJsonResponses();
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    tmdbClient = TMDB(
      ApiKeys('any', '_apiReadAccessTokenv4'),
      dio: dio,
    );
    localization = lookupTrendingLocalizations(const Locale('en'));
  });

  group('TrendingRemoteDatasource', () {
    test('should return trending tv list', () async {
      // Arrange
      final mockResponseJsonString =
          await jsonResponses.getJson(TrendingJsonResponses.tvShows);

      dioAdapter.onGet(
        'https://api.themoviedb.org/3/trending/tv/day?api_key=any&page=1&language=en-US',
        (server) {
          server.reply(
            HttpStatus.ok,
            mockResponseJsonString,
            headers: {
              HttpHeaders.contentTypeHeader: ['application/json;charset=utf-8'],
            },
          );
        },
      );

      final sut = TrendingRemoteDatasource(
        tmdbClient: tmdbClient,
        trendingLocalizations: localization,
      );

      // Act
      final result = await sut.getTv();

      // Assert
      expect(result, isNotNull);
      expect(result.page, 1);
      expect(result.totalPages, 1000);
      expect(result.totalResults, 20000);
      expect(result.results, isA<List<TrendingResult>>());
      expect(result.results.length, 20);
    });
  });

  test('should throw application exception on failing api call', () async {
    // Arrange
    final mockResponseJsonString =
        await jsonResponses.getJson(TrendingJsonResponses.tvShows);

    dioAdapter.onGet(
      'https://api.themoviedb.org/3/trending/tv/day?api_key=any&page=1&language=en-US',
      (server) {
        server.reply(
          HttpStatus.badRequest,
          mockResponseJsonString,
          headers: {
            HttpHeaders.contentTypeHeader: ['application/json;charset=utf-8'],
          },
        );
      },
    );

    final sut = TrendingRemoteDatasource(
      tmdbClient: tmdbClient,
      trendingLocalizations: localization,
    );

    // Act
    final getTrendingTvShows = sut.getTv;
    // Assert
    await expectLater(
      getTrendingTvShows(),
      throwsA(
        predicate(
          (p0) =>
              p0 is ApplicationException &&
              p0.message.startsWith('DioException [bad response]:') &&
              p0.description ==
                  'An error occurred when retrieving data from the TMDB API.' &&
              p0.isFatal == true,
        ),
      ),
    );
  });

  test('should throw application exception on convert dio response', () async {
    // Arrange
    final dioResponse = await jsonResponses
        .getJson(TrendingJsonResponses.tvShowsWithNullValues);

    dioAdapter.onGet(
      'https://api.themoviedb.org/3/trending/tv/day?api_key=any&page=1&language=en-US',
      (server) {
        server.reply(
          HttpStatus.ok,
          dioResponse,
          headers: {
            HttpHeaders.contentTypeHeader: ['application/json;charset=utf-8'],
          },
        );
      },
    );

    final sut = TrendingRemoteDatasource(
      tmdbClient: tmdbClient,
      trendingLocalizations: localization,
    );

    // Act
    final getTrendingTvShows = sut.getTv;
    // Assert
    await expectLater(
      getTrendingTvShows(),
      throwsA(
        predicate(
          (p0) =>
              p0 is ApplicationException &&
              p0.message ==
                  'type \'Null\' is not a subtype of type \'String\' in type cast' &&
              p0.description ==
                  'An error occurred while processing the TMDB response.' &&
              p0.isFatal == true,
        ),
      ),
    );
  });
}
