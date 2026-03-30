// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'flora_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class FloraLocalizationsPt extends FloraLocalizations {
  FloraLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get feedbackEmptyTitle => 'Nenhum exame cadastrado';

  @override
  String get feedbackEmptyDescription =>
      'Adicione seu primeiro exame para começar a acompanhar sua saúde.';

  @override
  String get feedbackEmptyPrimaryLabel => 'Adicionar exame';

  @override
  String get feedbackConnectionErrorTitle => 'Sem conexão com a internet';

  @override
  String get feedbackConnectionErrorDescription =>
      'Verifique sua conexão e tente novamente.';

  @override
  String get feedbackConnectionErrorPrimaryLabel => 'Tentar novamente';

  @override
  String get feedbackGenericErrorTitle => 'Algo deu errado';

  @override
  String get feedbackGenericErrorDescription =>
      'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.';

  @override
  String get feedbackGenericErrorPrimaryLabel => 'Tentar novamente';

  @override
  String get feedbackSecondaryBackHome => 'Voltar para o início';
}
