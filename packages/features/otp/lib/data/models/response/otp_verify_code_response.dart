class OtpVerifyCodeResponse {
  const OtpVerifyCodeResponse({required this.otpVerificationToken});

  final String otpVerificationToken;

  factory OtpVerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyCodeResponse(
        otpVerificationToken: json['otp_verification_token'] as String,
      );
}
