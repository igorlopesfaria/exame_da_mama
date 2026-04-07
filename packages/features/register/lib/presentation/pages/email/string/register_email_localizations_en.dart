import 'package:feature_register/presentation/pages/email/string/register_email_localizations.dart';

class RegisterEmailLocalizationsEn extends RegisterEmailLocalizations {
  RegisterEmailLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'What is your email?';

  @override
  String get description => 'Enter your email address.';

  @override
  String get continueButton => 'Continue';
}
