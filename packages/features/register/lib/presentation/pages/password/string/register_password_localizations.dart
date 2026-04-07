import 'dart:async';

import 'package:feature_register/presentation/pages/password/string/register_password_localizations_en.dart';
import 'package:feature_register/presentation/pages/password/string/register_password_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterPasswordLocalizations {
  RegisterPasswordLocalizations(String locale);

  static RegisterPasswordLocalizations of(BuildContext context) {
    return Localizations.of<RegisterPasswordLocalizations>(
        context, RegisterPasswordLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterPasswordLocalizations> delegate =
      _RegisterPasswordLocalizationsDelegate();

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

class _RegisterPasswordLocalizationsDelegate
    extends LocalizationsDelegate<RegisterPasswordLocalizations> {
  const _RegisterPasswordLocalizationsDelegate();

  @override
  Future<RegisterPasswordLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterPasswordLocalizations>(
        _lookupRegisterPasswordLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterPasswordLocalizationsDelegate old) => false;
}

RegisterPasswordLocalizations _lookupRegisterPasswordLocalizations(
    Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterPasswordLocalizationsEn();
    case 'pt':
      return RegisterPasswordLocalizationsPt();
  }
  throw FlutterError(
    'RegisterPasswordLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
