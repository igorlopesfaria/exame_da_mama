import 'package:feature_otp/data/models/otp_send_code_response.dart';
import 'package:feature_otp/data/models/otp_verify_code_response.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';

abstract interface class OtpRemoteDataSource {
  Future<OtpSendCodeResponse> sendCode(OtpChannel channel, String value);
  Future<OtpVerifyCodeResponse> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  });
}
