import 'package:commons_infra/http/i_http_client.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/request/otp_send_code_request.dart';
import 'package:feature_otp/data/models/response/otp_send_code_response.dart';
import 'package:feature_otp/data/models/request/otp_verify_code_request.dart';
import 'package:feature_otp/data/models/response/otp_verify_code_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRemoteDataSource)
class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  const OtpRemoteDataSourceImpl(this._httpClient);

  final IHttpClient _httpClient;

  @override
  Future<OtpSendCodeResponse> sendCode(OtpSendCodeRequest request) async {
    final data = await _httpClient.post(
      '/otp',
      data: request.toJson(),
    );
    return OtpSendCodeResponse.fromJson(data);
  }

  @override
  Future<OtpVerifyCodeResponse> verifyCode(OtpVerifyCodeRequest request) async {
    final data = await _httpClient.post(
      '/otp/verify',
      data: request.toJson(),
    );
    return OtpVerifyCodeResponse.fromJson(data);
  }
}
