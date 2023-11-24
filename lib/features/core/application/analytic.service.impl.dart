import 'package:countly_flutter_np/countly_flutter.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../application.dart' show AnalyticService;
import '../domain.dart' show ConfigurationEntity;
import '../localization.dart' show CoreLocalizations;

/// [AnalyticService] implementation to track analytics with Countly
class AnalyticServiceImpl extends AnalyticService {
  /// Initializes the AnalyticService. The service accepts the
  /// [_preferredLocales], which can be obtained from the [PlatformDispatcher].
  ///
  /// ```dart
  /// final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /// final preferredLocales = widgetsBinding.platformDispatcher.locales;
  /// final service = AnalyticServiceImpl(preferredLocales: preferredLocales);
  /// ```
  AnalyticServiceImpl({
    required List<Locale> preferredLocales,
    required ConfigurationEntity configuration,
  })  : _preferredLocales = preferredLocales,
        _configuration = configuration;

  final List<Locale> _preferredLocales;
  final ConfigurationEntity _configuration;

  @override
  Future<void> init() async {
    final isInitialized = await Countly.isInitialized();

    if (isInitialized) {
      return;
    }
    final countlyConfig = await _getCountlyConfig();
    await Countly.initWithConfig(countlyConfig);
  }

  @override
  Future<void> recordError(Object exception, StackTrace stackTrace) async {
    await Countly.recordDartError(exception, stackTrace);
  }

  /// Record Event
  void recordEvent({required Map<String, Object> data}) {
    Countly.recordEvent(data);
  }

  /// Start Event
  /// [key] EventKey
  Map<String, Object> startEvent({required String key}) {
    Countly.startEvent(key);

    return {
      'key': key,
    };
  }

  /// End Event
  void endEvent({required Map<String, Object> data}) {
    Countly.endEvent(data);
  }

  /// Record View
  void view({required String name, Map<String, Object>? segments}) {
    Countly.instance.views.startView(name, segments ?? {});
  }

  @override
  void logException({
    required String exception,
    bool nonfatal = false,
    Map<String, Object>? segmentation,
  }) {
    Countly.logException(exception, nonfatal, segmentation ?? {});
  }

  @override
  void logExceptionManual({
    required String message,
    bool nonFatal = false,
    StackTrace? stackTrace,
    Map<String, Object>? segmentation,
  }) {
    Countly.logExceptionManual(
      message,
      nonFatal,
      stacktrace: stackTrace,
      segmentation: segmentation,
    );
  }

  Future<CountlyConfig> _getCountlyConfig() async {
    const supported = CoreLocalizations.supportedLocales;
    final locale = basicLocaleListResolution(_preferredLocales, supported);

    await CountryCodes.init(locale);
    final deviceLocale = CountryCodes.getDeviceLocale();

    final countlyConfig = CountlyConfig(
      _configuration.countlyUrl,
      _configuration.countlyAppKey,
    )
      ..enableCrashReporting()
      ..setRequiresConsent(true)
      ..setConsentEnabled([
        // TODO(nk): get from user preferences
        CountlyConsent.sessions,
        CountlyConsent.events,
        CountlyConsent.views,
        CountlyConsent.location,
        CountlyConsent.crashes,
        CountlyConsent.attribution,
        CountlyConsent.users,
        // CountlyConsent.push,
        CountlyConsent.starRating,
        // CountlyConsent.apm,
        CountlyConsent.feedback,
        // CountlyConsent.remoteConfig
      ])
      ..setLocation(
        countryCode:
            deviceLocale?.countryCode ?? locale.languageCode.toUpperCase(),
      )
      ..setLoggingEnabled(true)
      ..setParameterTamperingProtectionSalt(_configuration.countlySalt);

    return countlyConfig;
  }
}
