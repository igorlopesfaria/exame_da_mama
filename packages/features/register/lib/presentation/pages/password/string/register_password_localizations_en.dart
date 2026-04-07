import 'package:feature_register/presentation/pages/password/string/register_password_localizations.dart';

class RegisterPasswordLocalizationsEn extends RegisterPasswordLocalizations {
  RegisterPasswordLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'Create a password';

  @override
  String get description => 'Your password must be at least 8 characters.';

  @override
  String get continueButton => 'Create account';
}
