/// Initialize App Analytic Service
abstract class AnalyticService {
  /// Initialize AnalyticService
  Future<void> init();

  /// Record Errors
  Future<void> recordError(Object exception, StackTrace stackTrace);

  /// Log Exception
  void logException({
    required String exception,
    bool nonfatal = false,
    Map<String, Object>? segmentation,
  });

  /// Log Exception
  void logExceptionManual({
    required String message,
    bool nonFatal = false,
    StackTrace? stackTrace,
    Map<String, Object>? segmentation,
  });
}
