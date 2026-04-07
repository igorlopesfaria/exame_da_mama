import 'package:feature_register/presentation/pages/name/string/register_name_localizations.dart';

class RegisterNameLocalizationsEn extends RegisterNameLocalizations {
  RegisterNameLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'What is your name?';

  @override
  String get description => 'Please enter your full name.';

  @override
  String get continueButton => 'Continue';
}
