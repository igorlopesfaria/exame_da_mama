class OtpSendCodeResponse {
  const OtpSendCodeResponse({required this.otpNextRequestIn});

  final int otpNextRequestIn;

  factory OtpSendCodeResponse.fromJson(Map<String, dynamic> json) =>
      OtpSendCodeResponse(
        otpNextRequestIn: (json['otp_next_request_in'] as num).toInt(),
      );
}
