import 'package:flutter/widgets.dart';

import '../localization.dart' show TrendingLocalizations;

/// extends the [BuildContext] to get feature localizations
extension LocalizedBuildContext on BuildContext {
  /// get corefFeature localizations
  TrendingLocalizations get trendingLocalizations =>
      TrendingLocalizations.of(this);
}
