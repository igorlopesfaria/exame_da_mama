import 'package:commons_infra/http/i_http_client.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/otp_send_code_response.dart';
import 'package:feature_otp/data/models/otp_verify_code_response.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:injectable/injectable.dart';

extension _OtpChannelPaths on OtpChannel {
  String get _key => name;
  String get _sendPath => '/verification-codes/$name';
  String get _verifyPath => '/verification-codes/$name/verify';
}

@LazySingleton(as: OtpRemoteDataSource)
class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  const OtpRemoteDataSourceImpl(this._httpClient);

  final IHttpClient _httpClient;

  @override
  Future<int> sendCode(OtpChannel channel, String value) async {
    final data = await _httpClient.post(channel._sendPath, data: {channel._key: value});
    return OtpSendCodeResponse.fromJson(data).otpNextRequestIn;
  }

  @override
  Future<OtpVerifyCodeResponse> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  }) async {
    final data = await _httpClient.post(
      channel._verifyPath,
      data: {channel._key: value, 'code': code},
    );
    return OtpVerifyCodeResponse.fromJson(data);
  }
}
