// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'otp_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class OtpLocalizationsEn extends OtpLocalizations {
  OtpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Did your code arrive?';

  @override
  String descriptionEmail(String contact) {
    return 'We just sent an email to $contact';
  }

  @override
  String descriptionPhone(String contact) {
    return 'We just sent an SMS to $contact';
  }

  @override
  String get resendCode => 'Resend code';

  @override
  String get validateCode => 'Validate code';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String get errorInvalidCode => 'Invalid or expired code';

  @override
  String get errorTooManyAttempts => 'Too many attempts. Try again later';

  @override
  String get errorGeneric => 'Something unexpected happened. Try again';

  @override
  String get resendSuccess => 'New code sent successfully';
}
