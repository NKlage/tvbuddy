import 'package:flutter/widgets.dart';

import '../localization.dart' show CoreLocalizations;

extension LocalizedBuildContext on BuildContext {
  CoreLocalizations get coreLocalizations => CoreLocalizations.of(this);
}
