import 'package:loggy/loggy.dart';

/// TVBuddy Logger Mixin
mixin PresentationLogger implements LoggyType {
  /// Get PresentationLogger App Logger
  @override
  Loggy<PresentationLogger> get loggy =>
      Loggy<PresentationLogger>('Presentation Layer - $runtimeType');
}
