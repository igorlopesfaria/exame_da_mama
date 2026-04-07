import 'package:feature_register/presentation/pages/cpf/string/register_cpf_localizations.dart';

class RegisterCpfLocalizationsPt extends RegisterCpfLocalizations {
  RegisterCpfLocalizationsPt([super.locale = 'pt']);

  @override
  String get title => 'Qual é o seu CPF?';

  @override
  String get description => 'Precisamos do seu CPF para criar sua conta.';

  @override
  String get continueButton => 'Continuar';

  @override
  String get errorInvalidCpf => 'CPF inválido. Verifique e tente novamente.';
}
