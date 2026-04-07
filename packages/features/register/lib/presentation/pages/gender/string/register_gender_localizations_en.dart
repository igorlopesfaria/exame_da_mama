import 'package:feature_register/presentation/pages/gender/string/register_gender_localizations.dart';

class RegisterGenderLocalizationsEn extends RegisterGenderLocalizations {
  RegisterGenderLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'How do you identify?';

  @override
  String get description => 'Select the gender you identify with.';

  @override
  String get continueButton => 'Continue';
}
