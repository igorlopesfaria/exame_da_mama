import 'package:feature_verification/data/models/verify_code_response.dart';

abstract interface class VerificationRemoteDataSource {
  Future<void> sendEmailVerificationCode(String email);
  Future<void> sendPhoneVerificationCode(String phone);
  Future<VerifyCodeResponse> verifyEmailCode({
    required String email,
    required String code,
  });
  Future<VerifyCodeResponse> verifyPhoneCode({
    required String phone,
    required String code,
  });
}
