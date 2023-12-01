import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'trending_localization_de.dart';
import 'trending_localization_en.dart';

/// Callers can lookup localized strings with an instance of TrendingLocalizations
/// returned by `TrendingLocalizations.of(context)`.
///
/// Applications need to include `TrendingLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/trending_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TrendingLocalizations.localizationsDelegates,
///   supportedLocales: TrendingLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the TrendingLocalizations.supportedLocales
/// property.
abstract class TrendingLocalizations {
  TrendingLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TrendingLocalizations of(BuildContext context) {
    return Localizations.of<TrendingLocalizations>(
        context, TrendingLocalizations)!;
  }

  static const LocalizationsDelegate<TrendingLocalizations> delegate =
      _TrendingLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Trending TV List title
  ///
  /// In de, this message translates to:
  /// **'Serien Trends'**
  String get trendingShowsTitle;

  /// trending Movie List title
  ///
  /// In de, this message translates to:
  /// **'Film Trends'**
  String get trendingMoviesTitle;

  /// Allgemeiner Fehler wenn beim Laden der MovieListe ein Fehler aufgetreten ist.
  ///
  /// In de, this message translates to:
  /// **'Mir ist da ein Fehler unterlaufen...'**
  String get movieListError;

  /// Text für den Button um nach einem Fehler die Aktion erneut dur den Nutzer zu starten.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get reloadActionText;

  /// Fehlermeldung wenn der TMDB API Call einen Fehler verursacht hat.
  ///
  /// In de, this message translates to:
  /// **'Es ist ein Fehler beim Abrufen der Daten aus der TMDB aufgetreten.'**
  String get trendingDatasourceApiException;

  /// Fehlermeldung wenn die TMDB Antwort nicht korrekt verarbeitet werden konnte.
  ///
  /// In de, this message translates to:
  /// **'Es ist ein Fehler beim verarbeiten der TMDB Antwort aufgetreten.'**
  String get trendingDatasourceResponseMappingException;
}

class _TrendingLocalizationsDelegate
    extends LocalizationsDelegate<TrendingLocalizations> {
  const _TrendingLocalizationsDelegate();

  @override
  Future<TrendingLocalizations> load(Locale locale) {
    return SynchronousFuture<TrendingLocalizations>(
        lookupTrendingLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TrendingLocalizationsDelegate old) => false;
}

TrendingLocalizations lookupTrendingLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return TrendingLocalizationsDe();
    case 'en':
      return TrendingLocalizationsEn();
  }

  throw FlutterError(
      'TrendingLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
