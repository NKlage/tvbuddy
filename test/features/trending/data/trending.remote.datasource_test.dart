import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:tvbuddy/features/trending/data.dart';
import 'package:tvbuddy/features/trending/data/trending_result.dart';
import 'package:tvbuddy/features/trending/l10n/trending_localization.dart';

import '../responses/trending_json_responses.dart';
import 'trending.remote.datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late TrendingJsonResponses jsonResponses;

  setUp(() {
    jsonResponses = TrendingJsonResponses();
  });

  group('TrendingRemoteDatasource', () {
    test('should return trending tv list', () async {
      // Arrange
      final mockDio = MockDio();
      final localization = lookupTrendingLocalizations(const Locale('en'));
      final mockResponseJsonString =
          await jsonResponses.getJson(TrendingJsonResponses.tvShows);

      when(mockDio.interceptors).thenReturn(Interceptors());
      when(
        mockDio.getUri<Map<String, dynamic>>(
          Uri.parse(
            'https://api.themoviedb.org/3/trending/tv/day?api_key=any&page=1&language=en-US',
          ),
        ),
      ).thenAnswer(
        (_) async => Future.value(
          Response<Map<String, dynamic>>(
            data: jsonDecode(mockResponseJsonString) as Map<String, dynamic>,
            requestOptions: RequestOptions(),
          ),
        ),
      );
      final tmdbClient = TMDB(
        ApiKeys('any', '_apiReadAccessTokenv4'),
        dio: mockDio,
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
    final mockDio = MockDio();
    final localization = lookupTrendingLocalizations(const Locale('en'));
    final mockResponseJsonString =
        await jsonResponses.getJson(TrendingJsonResponses.tvShows);

    when(mockDio.interceptors).thenReturn(Interceptors());
    when(
      mockDio.getUri<Map<String, dynamic>>(
        Uri.parse(
          'https://api.themoviedb.org/3/trending/tv/day?api_key=any&page=1&language=en-US',
        ),
      ),
    ).thenAnswer(
      (_) async => Future.value(
        Response<Map<String, dynamic>>(
          data: jsonDecode(mockResponseJsonString) as Map<String, dynamic>,
          requestOptions: RequestOptions(),
          statusCode: HttpStatus.internalServerError,
        ),
      ),
    );

    final tmdbClient = TMDB(
      ApiKeys('any', '_apiReadAccessTokenv4'),
      dio: mockDio,
    );

    final sut = TrendingRemoteDatasource(
      tmdbClient: tmdbClient,
      trendingLocalizations: localization,
    );

    // Act
    // TODO(nk): should throw ApplicationException
    await sut.getTv();
    // Assert
  });
}
