// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'flora_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class FloraLocalizationsEn extends FloraLocalizations {
  FloraLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get feedbackEmptyTitle => 'No exams yet';

  @override
  String get feedbackEmptyDescription =>
      'Add your first exam to start tracking your health.';

  @override
  String get feedbackEmptyPrimaryLabel => 'Add exam';

  @override
  String get feedbackConnectionErrorTitle => 'No internet connection';

  @override
  String get feedbackConnectionErrorDescription =>
      'Check your connection and try again.';

  @override
  String get feedbackConnectionErrorPrimaryLabel => 'Try again';

  @override
  String get feedbackGenericErrorTitle => 'Something went wrong';

  @override
  String get feedbackGenericErrorDescription =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get feedbackGenericErrorPrimaryLabel => 'Try again';

  @override
  String get feedbackSecondaryBackHome => 'Back to home';
}
