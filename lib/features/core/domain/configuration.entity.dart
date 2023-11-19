/// Represents App Configuration Properties
class ConfigurationEntity {
  /// Defualt Constructor, create Configuration from Environment variables
  ConfigurationEntity() {
    _countlyUrl = const String.fromEnvironment('countly_url');
    _countlyAppKey = const String.fromEnvironment('countly_app_key');
    _countlySalt = const String.fromEnvironment('countly_salt');
    _tmdbApiKey = const String.fromEnvironment('tmdb_api_key');
  }

  late String _countlyUrl;
  late String _countlyAppKey;
  late String _countlySalt;
  late String _tmdbApiKey;

  /// Get Countly URL
  String get countlyUrl => _countlyUrl;

  /// Get Countly App Key
  String get countlyAppKey => _countlyAppKey;

  /// Get Countly Salt
  String get countlySalt => _countlySalt;

  /// Get TMDB API Key
  String get tmdbApiKey => _tmdbApiKey;
}
