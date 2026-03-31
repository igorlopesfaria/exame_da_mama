// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'otp_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class OtpLocalizationsPt extends OtpLocalizations {
  OtpLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get title => 'Chegou o código?';

  @override
  String descriptionEmail(String contact) {
    return 'Acabamos de enviar um e-mail para $contact';
  }

  @override
  String descriptionPhone(String contact) {
    return 'Acabamos de enviar um SMS para $contact';
  }

  @override
  String get resendCode => 'Reenviar código';

  @override
  String get validateCode => 'Validar código';

  @override
  String get errorNoInternet => 'Sem conexão com a internet';

  @override
  String get errorInvalidCode => 'Código inválido ou expirado';

  @override
  String get errorTooManyAttempts =>
      'Muitas tentativas. Tente novamente mais tarde';

  @override
  String get errorGeneric => 'Algo inesperado ocorreu. Tente novamente';

  @override
  String get resendSuccess => 'Novo código enviado com sucesso';
}
