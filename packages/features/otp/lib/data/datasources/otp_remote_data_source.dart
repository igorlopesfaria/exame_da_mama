import 'package:feature_otp/data/models/otp_code_response.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';

abstract interface class OtpRemoteDataSource {
  Future<void> sendCode(OtpChannel channel, String value);
  Future<OtpCodeResponse> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  });
}
