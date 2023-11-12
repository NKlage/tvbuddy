import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvbuddy/features/core/application.dart';
import 'package:tvbuddy/features/core/domain.dart';

import '../localization.dart';
import 'locale_observer.dart';

/// Core Feature Providers
class CoreProviders {
  // Data

  /// Local Datasource

  /// Remote Datasource

  // Domain
  /// Repository
  static final Provider<ConfigurationEntity> configuration =
      Provider((_) => ConfigurationEntity());

  // Presentation
  /// Controller

  // Application

  static final Provider<AnalyticService> analyzeService = Provider((ref) {
    return AnalyticServiceImpl(
      preferredLocales: [],
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
