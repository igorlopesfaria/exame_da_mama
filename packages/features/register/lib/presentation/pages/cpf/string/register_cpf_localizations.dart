import 'dart:async';

import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations_en.dart';
import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations_pt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class RegisterCpfLocalizations {
  RegisterCpfLocalizations(String locale);

  static RegisterCpfLocalizations of(BuildContext context) {
    return Localizations.of<RegisterCpfLocalizations>(
        context, RegisterCpfLocalizations)!;
  }

  static const LocalizationsDelegate<RegisterCpfLocalizations> delegate =
      _RegisterCpfLocalizationsDelegate();

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
  String get errorInvalidCpf;
}

class _RegisterCpfLocalizationsDelegate
    extends LocalizationsDelegate<RegisterCpfLocalizations> {
  const _RegisterCpfLocalizationsDelegate();

  @override
  Future<RegisterCpfLocalizations> load(Locale locale) {
    return SynchronousFuture<RegisterCpfLocalizations>(
        _lookupRegisterCpfLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_RegisterCpfLocalizationsDelegate old) => false;
}

RegisterCpfLocalizations _lookupRegisterCpfLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return RegisterCpfLocalizationsEn();
    case 'pt':
      return RegisterCpfLocalizationsPt();
  }
  throw FlutterError(
    'RegisterCpfLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}
