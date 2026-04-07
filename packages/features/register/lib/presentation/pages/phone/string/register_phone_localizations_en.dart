import 'package:feature_register/presentation/pages/phone/string/register_phone_localizations.dart';

class RegisterPhoneLocalizationsEn extends RegisterPhoneLocalizations {
  RegisterPhoneLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'What is your phone number?';

  @override
  String get description => 'Enter your mobile number with area code.';

  @override
  String get continueButton => 'Continue';
}
