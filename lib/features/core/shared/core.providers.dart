import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization.dart';
import 'locale_observer.dart';

/// Core Feature Providers
class CoreProviders {
  // Data

  /// Local Datasource

  /// Remote Datasource

  // Domain
  /// Repository

  // Presentation
  /// Controller

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
