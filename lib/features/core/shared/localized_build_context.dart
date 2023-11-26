import 'package:flutter/widgets.dart';

import '../localization.dart' show CoreLocalizations;

/// BuildContext extension
extension LocalizedBuildContext on BuildContext {
  /// Get Core Localizations
  CoreLocalizations get coreLocalizations => CoreLocalizations.of(this);
}
