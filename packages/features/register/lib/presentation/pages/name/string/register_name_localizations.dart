import 'dart:async';

import 'package:feature_register/presentation/pages/name/string/register_name_localizations_en.dart';
import 'package:feature_register/presentation/pages/name/string/register_name_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterNameLocalizations {
  RegisterNameLocalizations(String locale);

  static RegisterNameLocalizations of(BuildContext context) {
    return Localizations.of<RegisterNameLocalizations>(
        context, RegisterNameLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterNameLocalizations> delegate =
      _RegisterNameLocalizationsDelegate();

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

class _RegisterNameLocalizationsDelegate
    extends LocalizationsDelegate<RegisterNameLocalizations> {
  const _RegisterNameLocalizationsDelegate();

  @override
  Future<RegisterNameLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterNameLocalizations>(
        _lookupRegisterNameLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterNameLocalizationsDelegate old) => false;
}

RegisterNameLocalizations _lookupRegisterNameLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterNameLocalizationsEn();
    case 'pt':
      return RegisterNameLocalizationsPt();
  }
  throw FlutterError(
    'RegisterNameLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
