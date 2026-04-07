class OtpVerifyCodeResponse {
  const OtpVerifyCodeResponse({required this.verificationToken});

  final String verificationToken;

  factory OtpVerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyCodeResponse(
        verificationToken: json['verification_token'] as String,
      );
}
