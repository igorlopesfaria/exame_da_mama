import 'package:dio/dio.dart';
import 'package:feature_verification/data/datasources/verification_remote_data_source.dart';
import 'package:feature_verification/data/models/verify_code_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VerificationRemoteDataSource)
class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  const VerificationRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> sendEmailVerificationCode(String email) async {
    await _dio.post(
      '/verification-codes/email',
      data: {'email': email},
    );
  }

  @override
  Future<void> sendPhoneVerificationCode(String phone) async {
    await _dio.post(
      '/verification-codes/phone',
      data: {'phone': phone},
    );
  }

  @override
  Future<VerifyCodeResponse> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    final response = await _dio.post(
      '/verification-codes/email/verify',
      data: {'email': email, 'code': code},
    );
    return VerifyCodeResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<VerifyCodeResponse> verifyPhoneCode({
    required String phone,
    required String code,
  }) async {
    final response = await _dio.post(
      '/verification-codes/phone/verify',
      data: {'phone': phone, 'code': code},
    );
    return VerifyCodeResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
