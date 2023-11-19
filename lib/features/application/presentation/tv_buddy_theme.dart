import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Generate the App Theme
class TvBuddyTheme {
  /// Default Constructor
  TvBuddyTheme() {
    _createCupertinoDarkTheme();
    _createMaterialDarkTheme();
  }

  late MaterialBasedCupertinoThemeData _cupertinoDarkTheme;
  late ThemeData _materialDarkTheme;

  /// Get Cupertino Dark Theme
  MaterialBasedCupertinoThemeData get cupertinoDarkTheme => _cupertinoDarkTheme;

  /// Get Material Dark Theme
  ThemeData get materialDarkTheme => _materialDarkTheme;

  void _createCupertinoDarkTheme() {
    final darkTheme = ThemeData.dark();
    const darkDefaultCupertinoTheme =
        CupertinoThemeData(brightness: Brightness.dark);
    _cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
      materialTheme: darkTheme.copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: darkDefaultCupertinoTheme.barBackgroundColor,
          textTheme: CupertinoTextThemeData(
            navActionTextStyle:
                darkDefaultCupertinoTheme.textTheme.navActionTextStyle,
            // .copyWith(color: const Color(0xF0F9F9F9)),
            navLargeTitleTextStyle:
                darkDefaultCupertinoTheme.textTheme.navLargeTitleTextStyle,
            // .copyWith(color: const Color(0xF0F9F9F9)),
          ),
        ),
      ),
    );
  }

  void _createMaterialDarkTheme() {
    _materialDarkTheme = ThemeData.dark(useMaterial3: true);
  }
}
