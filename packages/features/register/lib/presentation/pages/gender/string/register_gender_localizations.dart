import 'dart:async';

import 'package:feature_register/presentation/pages/gender/string/register_gender_localizations_en.dart';
import 'package:feature_register/presentation/pages/gender/string/register_gender_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterGenderLocalizations {
  RegisterGenderLocalizations(String locale);

  static RegisterGenderLocalizations of(BuildContext context) {
    return Localizations.of<RegisterGenderLocalizations>(
        context, RegisterGenderLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterGenderLocalizations> delegate =
      _RegisterGenderLocalizationsDelegate();

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

class _RegisterGenderLocalizationsDelegate
    extends LocalizationsDelegate<RegisterGenderLocalizations> {
  const _RegisterGenderLocalizationsDelegate();

  @override
  Future<RegisterGenderLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterGenderLocalizations>(
        _lookupRegisterGenderLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterGenderLocalizationsDelegate old) => false;
}

RegisterGenderLocalizations _lookupRegisterGenderLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterGenderLocalizationsEn();
    case 'pt':
      return RegisterGenderLocalizationsPt();
  }
  throw FlutterError(
    'RegisterGenderLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
