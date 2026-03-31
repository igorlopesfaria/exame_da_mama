import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'otp_localizations_en.dart';
import 'otp_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of OtpLocalizations
/// returned by `OtpLocalizations.of(context)`.
///
/// Applications need to include `OtpLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'string/otp_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: OtpLocalizations.localizationsDelegates,
///   supportedLocales: OtpLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the OtpLocalizations.supportedLocales
/// property.
abstract class OtpLocalizations {
  OtpLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static OtpLocalizations of(BuildContext context) {
    return Localizations.of<OtpLocalizations>(context, OtpLocalizations)!;
  }

  static const LocalizationsDelegate<OtpLocalizations> delegate =
      _OtpLocalizationsDelegate();

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

  /// No description provided for @title.
  ///
  /// In pt, this message translates to:
  /// **'Chegou o código?'**
  String get title;

  /// No description provided for @descriptionEmail.
  ///
  /// In pt, this message translates to:
  /// **'Acabamos de enviar um e-mail para {contact}'**
  String descriptionEmail(String contact);

  /// No description provided for @descriptionPhone.
  ///
  /// In pt, this message translates to:
  /// **'Acabamos de enviar um SMS para {contact}'**
  String descriptionPhone(String contact);

  /// No description provided for @resendCode.
  ///
  /// In pt, this message translates to:
  /// **'Reenviar código'**
  String get resendCode;

  /// No description provided for @validateCode.
  ///
  /// In pt, this message translates to:
  /// **'Validar código'**
  String get validateCode;

  /// No description provided for @errorNoInternet.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet'**
  String get errorNoInternet;

  /// No description provided for @errorInvalidCode.
  ///
  /// In pt, this message translates to:
  /// **'Código inválido ou expirado'**
  String get errorInvalidCode;

  /// No description provided for @errorTooManyAttempts.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Tente novamente mais tarde'**
  String get errorTooManyAttempts;

  /// No description provided for @errorGeneric.
  ///
  /// In pt, this message translates to:
  /// **'Algo inesperado ocorreu. Tente novamente'**
  String get errorGeneric;

  /// No description provided for @resendSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Novo código enviado com sucesso'**
  String get resendSuccess;
}

class _OtpLocalizationsDelegate
    extends LocalizationsDelegate<OtpLocalizations> {
  const _OtpLocalizationsDelegate();

  @override
  Future<OtpLocalizations> load(Locale locale) {
    return SynchronousFuture<OtpLocalizations>(lookupOtpLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_OtpLocalizationsDelegate old) => false;
}

OtpLocalizations lookupOtpLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return OtpLocalizationsEn();
    case 'pt':
      return OtpLocalizationsPt();
  }

  throw FlutterError(
    'OtpLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
