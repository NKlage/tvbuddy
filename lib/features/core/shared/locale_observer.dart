import 'package:flutter/widgets.dart';

/// Localization Observer
class LocaleObserver extends WidgetsBindingObserver {
  /// Default Constructor
  LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
