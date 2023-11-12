import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvbuddy/features/core/application.dart';
import 'package:tvbuddy/features/core/domain.dart' show ConfigurationEntity;
import 'package:tvbuddy/features/core/shared.dart';

import 'app_placeholder.dart';
import 'features/core/localization.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  final analyzeService = AnalyticServiceImpl(
    preferredLocales: widgetBinding.platformDispatcher.locales,
    configuration: ConfigurationEntity(),
  );
  await analyzeService.init();

  final container = ProviderContainer(
    overrides: [
      CoreProviders.analyzeService.overrideWith(
        (ref) => analyzeService,
      ),
    ],
  );

  FlutterError.onError = (details) {
    analyzeService.recordError(
      details.exception,
      details.stack ?? StackTrace.current,
    );
  };

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      supportedLocales: CoreLocalizations.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CoreLocalizations.delegate,
      ],
      home: AppPlaceholder(),
    );
  }
}
