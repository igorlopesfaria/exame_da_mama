class OtpCodeResponse {
  const OtpCodeResponse({required this.verificationToken});

  final String verificationToken;

  factory OtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      OtpCodeResponse(
        verificationToken: json['verification_token'] as String,
      );
}
