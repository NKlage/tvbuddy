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
}
