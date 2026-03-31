import 'package:commons_infra/failures/app_failures.dart';

sealed class OtpState {
  const OtpState();

  bool get isCodeComplete => false;
  bool get isLoading => false;
}

class OtpIdle extends OtpState {
  const OtpIdle({this.isCodeComplete = false});

  @override
  final bool isCodeComplete;
}

class OtpVerifying extends OtpState {
  const OtpVerifying({required this.isCodeComplete});

  @override
  final bool isCodeComplete;

  @override
  bool get isLoading => true;
}

class OtpResending extends OtpState {
  const OtpResending({required this.isCodeComplete});

  @override
  final bool isCodeComplete;

  @override
  bool get isLoading => true;
}

class OtpVerifyError extends OtpState {
  const OtpVerifyError(this.failure, {required this.isCodeComplete});

  final Failure failure;

  @override
  final bool isCodeComplete;
}

class OtpResendError extends OtpState {
  const OtpResendError(this.failure, {required this.isCodeComplete});

  final Failure failure;

  @override
  final bool isCodeComplete;
}

class OtpResendSuccess extends OtpState {
  const OtpResendSuccess({required this.isCodeComplete});

  @override
  final bool isCodeComplete;
}

class OtpVerifySuccess extends OtpState {
  const OtpVerifySuccess(this.token);

  final String token;

  @override
  bool get isCodeComplete => true;
}
