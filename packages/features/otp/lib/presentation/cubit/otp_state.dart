import 'package:commons_infra/failures/app_failures.dart';

// ── Verify sub-status ──────────────────────────────────────────────────────

sealed class OtpVerifyStatus {
  const OtpVerifyStatus();
}

class OtpVerifyIdle extends OtpVerifyStatus {
  const OtpVerifyIdle();
}

class OtpVerifying extends OtpVerifyStatus {
  const OtpVerifying();
}

class OtpVerifySuccess extends OtpVerifyStatus {
  const OtpVerifySuccess(this.token);
  final String token;
}

class OtpVerifyError extends OtpVerifyStatus {
  const OtpVerifyError(this.failure);
  final Failure failure;
}

// ── Resend sub-status ──────────────────────────────────────────────────────

sealed class OtpResendStatus {
  const OtpResendStatus();
}

class OtpResendIdle extends OtpResendStatus {
  const OtpResendIdle();
}

class OtpResending extends OtpResendStatus {
  const OtpResending();
}

class OtpResendSuccess extends OtpResendStatus {
  const OtpResendSuccess();
}

class OtpResendError extends OtpResendStatus {
  const OtpResendError(this.failure);
  final Failure failure;
}

// ── Composite state ────────────────────────────────────────────────────────

class OtpState {
  const OtpState({
    this.verifyStatus = const OtpVerifyIdle(),
    this.resendStatus = const OtpResendIdle(),
    this.countdownSeconds = 0,
    this.isCodeComplete = false,
  });

  final OtpVerifyStatus verifyStatus;
  final OtpResendStatus resendStatus;
  final int countdownSeconds;
  final bool isCodeComplete;

  bool get isLoading =>
      verifyStatus is OtpVerifying || resendStatus is OtpResending;

  OtpState copyWith({
    OtpVerifyStatus? verifyStatus,
    OtpResendStatus? resendStatus,
    int? countdownSeconds,
    bool? isCodeComplete,
  }) =>
      OtpState(
        verifyStatus: verifyStatus ?? this.verifyStatus,
        resendStatus: resendStatus ?? this.resendStatus,
        countdownSeconds: countdownSeconds ?? this.countdownSeconds,
        isCodeComplete: isCodeComplete ?? this.isCodeComplete,
      );
}
