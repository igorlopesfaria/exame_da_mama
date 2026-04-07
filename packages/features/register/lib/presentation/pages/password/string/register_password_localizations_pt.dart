import 'package:feature_register/presentation/pages/password/string/register_password_localizations.dart';

class RegisterPasswordLocalizationsPt extends RegisterPasswordLocalizations {
  RegisterPasswordLocalizationsPt([super.locale = 'pt']);

  @override
  String get title => 'Crie uma senha';

  @override
  String get description => 'Sua senha deve ter pelo menos 8 caracteres.';

  @override
  String get continueButton => 'Criar conta';
}
