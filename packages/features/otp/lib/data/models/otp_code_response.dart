import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_code_response.freezed.dart';
part 'otp_code_response.g.dart';

@freezed
abstract class OtpCodeResponse with _$OtpCodeResponse {
  const factory OtpCodeResponse({
    @JsonKey(name: 'verification_token') required String verificationToken,
  }) = _OtpCodeResponse;

  factory OtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpCodeResponseFromJson(json);
}
