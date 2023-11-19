import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/application/presentation.dart' show TvBuddyApp;
import 'features/application/shared.dart' show ApplicationProviders;

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  final preferredLocales = widgetBinding.platformDispatcher.locales;
  final container = ProviderContainer();

  final initAppService =
      container.read(ApplicationProviders.initAppService(preferredLocales));
  await initAppService.init();

  FlutterError.onError = (details) {
    initAppService.analyticService.recordError(
      details.exception,
      details.stack ?? StackTrace.current,
    );
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
