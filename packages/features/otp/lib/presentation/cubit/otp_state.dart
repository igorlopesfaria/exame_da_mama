import 'package:feature_otp/presentation/cubit/otp_resend_code_state.dart';
import 'package:feature_otp/presentation/cubit/otp_verify_code_state.dart';

export 'otp_resend_code_state.dart';
export 'otp_verify_code_state.dart';

class OtpState {
  const OtpState({
    this.verifyCodeState = const OtpVerifyCodeIdle(),
    this.resendCodeState = const OtpResendCodeIdle(),
    this.countdownSeconds = 0,
    this.isCodeComplete = false,
  });

  final OtpVerifyCodeState verifyCodeState;
  final OtpResendCodeState resendCodeState;
  final int countdownSeconds;
  final bool isCodeComplete;

  OtpState copyWith({
    OtpVerifyCodeState? verifyCodeState,
    OtpResendCodeState? resendCodeState,
    int? countdownSeconds,
    bool? isCodeComplete,
  }) =>
      OtpState(
        verifyCodeState: verifyCodeState ?? this.verifyCodeState,
        resendCodeState: resendCodeState ?? this.resendCodeState,
        countdownSeconds: countdownSeconds ?? this.countdownSeconds,
        isCodeComplete: isCodeComplete ?? this.isCodeComplete,
      );
}
