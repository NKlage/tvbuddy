import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization.dart' show CoreLocalizations;
import '../../trending/localization.dart' show TrendingLocalizations;
import 'tv_buddy_theme.dart';

/// App Main Entry Point
class TvBuddyApp extends StatelessWidget {
  /// Default Constructor
  const TvBuddyApp({
    required GoRouter routeConfiguration,
    required TvBuddyTheme theme,
    super.key,
  })  : _routeConfiguration = routeConfiguration,
        _theme = theme;

  final GoRouter _routeConfiguration;
  final TvBuddyTheme _theme;

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (_) => PlatformTheme(
        themeMode: ThemeMode.dark,
        materialDarkTheme: _theme.materialDarkTheme,
        cupertinoDarkTheme: _theme.cupertinoDarkTheme,
        builder: (_) => PlatformApp.router(
          supportedLocales: CoreLocalizations.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
            TrendingLocalizations.delegate,
          ],
          routerConfig: _routeConfiguration,
        ),
      ),
    );
  }
}
