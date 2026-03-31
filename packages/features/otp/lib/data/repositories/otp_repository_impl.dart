import 'package:dio/dio.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource);

  final OtpRemoteDataSource _dataSource;

  @override
  Future<Either<OtpFailure, Unit>> sendCode(OtpChannel channel, String value) async {
    try {
      await _dataSource.sendCode(channel, value);
      return right(unit);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<OtpFailure, String>> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  }) async {
    try {
      final response = await _dataSource.verifyCode(channel, value: value, code: code);
      return right(response.verificationToken);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  OtpFailure _mapError(DioException e) {
    final error = e.response?.data?['error'] as String?;
    return switch (error) {
      'INVALID_CODE' => const InvalidCode(),
      'EXPIRED_CODE' => const ExpiredCode(),
      'TOO_MANY_ATTEMPTS' => const TooManyAttempts(),
      _ => const ServerError(),
    };
  }
}
