import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'features/application/presentation.dart' show TvBuddyApp;
import 'features/application/shared.dart' show ApplicationProviders;
import 'features/core/shared/riverpod_observer.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  final preferredLocales = widgetBinding.platformDispatcher.locales;

  void providerDidFailLog(
    ProviderBase<Object?> provider,
    Object? error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      Loggy('RiverpodObserver providerDidFailLog').error(
        'Provider: $provider - Container: $container',
        error,
        stackTrace,
      );

  void didAddProviderLog(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      Loggy('RiverpodObserver didAddProviderLog').debug(
        'Container: ${container.runtimeType} - Value: ${value.runtimeType}',
      );

  void didDisposeProviderLog(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      Loggy('RiverpodObserver didDisposeProviderLog')
          .debug('Provider: $provider - Container: $container');

  void didUpdateProviderLog(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Loggy('RiverpodObserver didUpdateProvider').debug(
      'Provider: $provider - PreviousValue: $previousValue - '
      'NewValue: $newValue - Container: $container',
    );
  }

  final riverpodObserver = RiverpodObserver(
    didAddProviderLog: didAddProviderLog,
    providerDidFailLog: providerDidFailLog,
    didDisposeProviderLog: didDisposeProviderLog,
    didUpdateProviderLog: didUpdateProviderLog,
  );

  final container = ProviderContainer(
    observers: [
      riverpodObserver,
    ],
  );

  final initAppService =
      container.read(ApplicationProviders.initAppService(preferredLocales));
  await initAppService.init();

  FlutterError.onError = (details) {
    initAppService.analyticService.recordError(
      details.exception,
      details.stack ?? StackTrace.current,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    initAppService.analyticService.logException(
      exception: error.toString(),
      nonfatal: true,
      segmentation: {'type': 'PlatformDispatcher Error'},
    );
    return true;
  };

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: TvBuddyApp(
        routeConfiguration: initAppService.routeConfiguration,
        theme: container.read(ApplicationProviders.theme),
      ),
    ),
  );
}
