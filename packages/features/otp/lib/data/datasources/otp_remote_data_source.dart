import 'package:feature_otp/data/models/request/otp_send_code_request.dart';
import 'package:feature_otp/data/models/response/otp_send_code_response.dart';
import 'package:feature_otp/data/models/request/otp_verify_code_request.dart';
import 'package:feature_otp/data/models/response/otp_verify_code_response.dart';

abstract interface class OtpRemoteDataSource {
  Future<OtpSendCodeResponse> sendCode(OtpSendCodeRequest request);
  Future<OtpVerifyCodeResponse> verifyCode(OtpVerifyCodeRequest request);
}
