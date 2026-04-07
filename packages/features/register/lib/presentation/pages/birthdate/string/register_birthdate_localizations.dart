import 'dart:async';

import 'package:feature_register/presentation/pages/birthdate/string/register_birthdate_localizations_en.dart';
import 'package:feature_register/presentation/pages/birthdate/string/register_birthdate_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterBirthdateLocalizations {
  RegisterBirthdateLocalizations(String locale);

  static RegisterBirthdateLocalizations of(BuildContext context) {
    return Localizations.of<RegisterBirthdateLocalizations>(
        context, RegisterBirthdateLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterBirthdateLocalizations> delegate =
      _RegisterBirthdateLocalizationsDelegate();

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

class _RegisterBirthdateLocalizationsDelegate
    extends LocalizationsDelegate<RegisterBirthdateLocalizations> {
  const _RegisterBirthdateLocalizationsDelegate();

  @override
  Future<RegisterBirthdateLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterBirthdateLocalizations>(
        _lookupRegisterBirthdateLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterBirthdateLocalizationsDelegate old) => false;
}

RegisterBirthdateLocalizations _lookupRegisterBirthdateLocalizations(
    Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterBirthdateLocalizationsEn();
    case 'pt':
      return RegisterBirthdateLocalizationsPt();
  }
  throw FlutterError(
    'RegisterBirthdateLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
