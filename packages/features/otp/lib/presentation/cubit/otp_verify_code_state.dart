import 'package:commons_infra/failures/app_failures.dart';

sealed class OtpVerifyCodeState {
  const OtpVerifyCodeState();
}

class OtpVerifyCodeIdle extends OtpVerifyCodeState {
  const OtpVerifyCodeIdle();
}

class OtpVerifyCodeLoading extends OtpVerifyCodeState {
  const OtpVerifyCodeLoading();
}

class OtpVerifyCodeSuccess extends OtpVerifyCodeState {
  const OtpVerifyCodeSuccess(this.token);
  final String token;
}

class OtpVerifyCodeError extends OtpVerifyCodeState {
  const OtpVerifyCodeError(this.failure);
  final Failure failure;
}
