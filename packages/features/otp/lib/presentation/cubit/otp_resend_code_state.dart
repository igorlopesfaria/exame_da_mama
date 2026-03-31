import 'package:commons_infra/failures/app_failures.dart';

sealed class OtpResendCodeState {
  const OtpResendCodeState();
}

class OtpResendCodeIdle extends OtpResendCodeState {
  const OtpResendCodeIdle();
}

class OtpResendCodeLoading extends OtpResendCodeState {
  const OtpResendCodeLoading();
}

class OtpResendCodeSuccess extends OtpResendCodeState {
  const OtpResendCodeSuccess();
}

class OtpResendCodeError extends OtpResendCodeState {
  const OtpResendCodeError(this.failure);
  final Failure failure;
}
