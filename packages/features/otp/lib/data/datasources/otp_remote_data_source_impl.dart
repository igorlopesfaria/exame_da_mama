import 'package:dio/dio.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/otp_code_response.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRemoteDataSource)
class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  const OtpRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> sendCode(OtpChannel channel, String value) async {
    await _dio.post(channel.sendPath, data: {channel.key: value});
  }

  @override
  Future<OtpCodeResponse> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  }) async {
    final response = await _dio.post(
      channel.verifyPath,
      data: {channel.key: value, 'code': code},
    );
    return OtpCodeResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
