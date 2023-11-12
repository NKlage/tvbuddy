/// Initialize App Analytic Service
abstract class AnalyticService {
  /// Initialize AnalyticService
  Future<void> init();

  /// Record Errors
  Future<void> recordError(Object exception, StackTrace stackTrace);
}
