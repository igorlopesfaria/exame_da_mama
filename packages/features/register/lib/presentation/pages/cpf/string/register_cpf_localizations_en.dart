import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations.dart';

class RegisterCpfLocalizationsEn extends RegisterCpfLocalizations {
  RegisterCpfLocalizationsEn([super.locale = 'en']);

  @override
  String get title => 'What is your CPF?';

  @override
  String get description => 'We need your CPF to create your account.';

  @override
  String get cpfLabel => 'CPF';

  @override
  String get continueButton => 'Continue';

  @override
  String get errorInvalidCpf => 'Invalid CPF. Please check and try again.';

  @override
  String get errorNoInternet => 'No internet connection. Please try again.';

  @override
  String get errorGeneric => 'Something unexpected occurred. Please try again.';
}
