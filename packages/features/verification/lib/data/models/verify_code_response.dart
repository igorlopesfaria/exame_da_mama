import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_code_response.freezed.dart';
part 'verify_code_response.g.dart';

@freezed
abstract class VerifyCodeResponse with _$VerifyCodeResponse {
  const factory VerifyCodeResponse({
    @JsonKey(name: 'verification_token') required String verificationToken,
  }) = _VerifyCodeResponse;

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);
}
