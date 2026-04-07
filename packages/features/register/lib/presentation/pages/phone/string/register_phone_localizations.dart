import 'dart:async';

import 'package:feature_register/presentation/pages/phone/string/register_phone_localizations_en.dart';
import 'package:feature_register/presentation/pages/phone/string/register_phone_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterPhoneLocalizations {
  RegisterPhoneLocalizations(String locale);

  static RegisterPhoneLocalizations of(BuildContext context) {
    return Localizations.of<RegisterPhoneLocalizations>(
        context, RegisterPhoneLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterPhoneLocalizations> delegate =
      _RegisterPhoneLocalizationsDelegate();

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

class _RegisterPhoneLocalizationsDelegate
    extends LocalizationsDelegate<RegisterPhoneLocalizations> {
  const _RegisterPhoneLocalizationsDelegate();

  @override
  Future<RegisterPhoneLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterPhoneLocalizations>(
        _lookupRegisterPhoneLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterPhoneLocalizationsDelegate old) => false;
}

RegisterPhoneLocalizations _lookupRegisterPhoneLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterPhoneLocalizationsEn();
    case 'pt':
      return RegisterPhoneLocalizationsPt();
  }
  throw FlutterError(
    'RegisterPhoneLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
