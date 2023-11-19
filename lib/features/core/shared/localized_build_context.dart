import 'package:flutter/widgets.dart';

import '../localization.dart' show CoreLocalizations;

/// extends the [BuildContext] to get feature localizations
extension LocalizedBuildContext on BuildContext {
  /// get corefFeature localizations
  CoreLocalizations get coreLocalizations => CoreLocalizations.of(this);
}
