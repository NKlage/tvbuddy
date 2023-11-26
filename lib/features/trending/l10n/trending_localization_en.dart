import 'trending_localization.dart';

/// The translations for English (`en`).
class TrendingLocalizationsEn extends TrendingLocalizations {
  TrendingLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get trendingShowsTitle => 'Trending TV';

  @override
  String get trendingMoviesTitle => 'Trending Movies';

  @override
  String get movieListError => 'I made a mistake...';

  @override
  String get reloadActionText => 'Try again';
}
