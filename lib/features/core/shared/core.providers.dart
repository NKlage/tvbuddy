import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../application.dart';
import '../domain.dart';
import '../localization.dart';
import 'locale_observer.dart';

/// Core Feature Providers
class CoreProviders {
  // Data

  /// TMDB API Client
  static final Provider<TMDB> tmdbClient = Provider((ref) {
    final config = ref.read(configuration);
    final dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    // ..interceptors.add(
    //     LoggyDioInterceptor(
    //       requestLevel: LogLevel.error,
    //       responseLevel: LogLevel.error,
    //       errorLevel: LogLevel.debug,
    //     ),
    //   );

    return TMDB(ApiKeys(config.tmdbApiKey, 'apiReadAccessTokenv4'), dio: dio);
  });

  /// Local Datasource

  /// Remote Datasource

  // Domain
  /// Configuration Provider
  static final Provider<ConfigurationEntity> configuration =
      Provider((_) => ConfigurationEntity());

  // Presentation
  /// Controller

  // Application

  /// Analyze Service Provider
  static final ProviderFamily<AnalyticService, List<Locale>> analyzeService =
      Provider.family((ref, locales) {
    return AnalyticServiceImpl(
      preferredLocales: locales,
      configuration: ref.read(configuration),
    );
  });

  /// provider used to access the CoreLocalizations object for the current
  /// locale
  static final Provider<CoreLocalizations> coreLocalizationsProvider =
      Provider<CoreLocalizations>(
    (ref) {
      final locale = PlatformDispatcher.instance.locale;
      ref.state = lookupCoreLocalizations(locale);
      final observer = LocaleObserver((locales) {
        ref.state = lookupCoreLocalizations(locale);
      });
      final binding = WidgetsBinding.instance..addObserver(observer);
      ref.onDispose(() => binding.removeObserver(observer));
      return ref.state;
    },
  );
}
