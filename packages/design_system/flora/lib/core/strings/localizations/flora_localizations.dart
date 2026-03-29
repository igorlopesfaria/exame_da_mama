import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'flora_localizations_en.dart';
import 'flora_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FloraLocalizations
/// returned by `FloraLocalizations.of(context)`.
///
/// Applications need to include `FloraLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/flora_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FloraLocalizations.localizationsDelegates,
///   supportedLocales: FloraLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FloraLocalizations.supportedLocales
/// property.
abstract class FloraLocalizations {
  FloraLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FloraLocalizations? of(BuildContext context) {
    return Localizations.of<FloraLocalizations>(context, FloraLocalizations);
  }

  static const LocalizationsDelegate<FloraLocalizations> delegate =
      _FloraLocalizationsDelegate();

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
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @feedbackEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum exame cadastrado'**
  String get feedbackEmptyTitle;

  /// No description provided for @feedbackEmptyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Adicione seu primeiro exame para começar a acompanhar sua saúde.'**
  String get feedbackEmptyDescription;

  /// No description provided for @feedbackEmptyPrimaryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar exame'**
  String get feedbackEmptyPrimaryLabel;

  /// No description provided for @feedbackConnectionErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet'**
  String get feedbackConnectionErrorTitle;

  /// No description provided for @feedbackConnectionErrorDescription.
  ///
  /// In pt, this message translates to:
  /// **'Verifique sua conexão e tente novamente.'**
  String get feedbackConnectionErrorDescription;

  /// No description provided for @feedbackConnectionErrorPrimaryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get feedbackConnectionErrorPrimaryLabel;

  /// No description provided for @feedbackGenericErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Algo deu errado'**
  String get feedbackGenericErrorTitle;

  /// No description provided for @feedbackGenericErrorDescription.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.'**
  String get feedbackGenericErrorDescription;

  /// No description provided for @feedbackGenericErrorPrimaryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get feedbackGenericErrorPrimaryLabel;

  /// No description provided for @feedbackSecondaryBackHome.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para o início'**
  String get feedbackSecondaryBackHome;
}

class _FloraLocalizationsDelegate
    extends LocalizationsDelegate<FloraLocalizations> {
  const _FloraLocalizationsDelegate();

  @override
  Future<FloraLocalizations> load(Locale locale) {
    return SynchronousFuture<FloraLocalizations>(
      lookupFloraLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_FloraLocalizationsDelegate old) => false;
}

FloraLocalizations lookupFloraLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return FloraLocalizationsEn();
    case 'pt':
      return FloraLocalizationsPt();
  }

  throw FlutterError(
    'FloraLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
