import 'dart:async';

import 'package:feature_register/presentation/pages/email/string/register_email_localizations_en.dart';
import 'package:feature_register/presentation/pages/email/string/register_email_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterEmailLocalizations {
  RegisterEmailLocalizations(String locale);

  static RegisterEmailLocalizations of(BuildContext context) {
    return Localizations.of<RegisterEmailLocalizations>(
        context, RegisterEmailLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterEmailLocalizations> delegate =
      _RegisterEmailLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  String get title;
  String get description;
  String get continueButton;
}

class _RegisterEmailLocalizationsDelegate
    extends LocalizationsDelegate<RegisterEmailLocalizations> {
  const _RegisterEmailLocalizationsDelegate();

  @override
  Future<RegisterEmailLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterEmailLocalizations>(
        _lookupRegisterEmailLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterEmailLocalizationsDelegate old) => false;
}

RegisterEmailLocalizations _lookupRegisterEmailLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterEmailLocalizationsEn();
    case 'pt':
      return RegisterEmailLocalizationsPt();
  }
  throw FlutterError(
    'RegisterEmailLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
