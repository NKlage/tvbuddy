import 'trending_localization.dart';

/// The translations for German (`de`).
class TrendingLocalizationsDe extends TrendingLocalizations {
  TrendingLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get trendingShowsTitle => 'Serien Trends';

  @override
  String get trendingMoviesTitle => 'Film Trends';

  @override
  String get movieListError => 'Mir ist da ein Fehler unterlaufen...';

  @override
  String get reloadActionText => 'Erneut versuchen';

  @override
  String get trendingDatasourceApiException =>
      'Es ist ein Fehler beim Abrufen der Daten aus der TMDB aufgetreten.';

  @override
  String get trendingDatasourceResponseMappingException =>
      'Es ist ein Fehler beim verarbeiten der TMDB Antwort aufgetreten.';
}
