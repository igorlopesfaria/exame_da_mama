import 'package:commons_observability/commons_observability.dart';
import 'package:dio/dio.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource, this._observability);

  final OtpRemoteDataSource _dataSource;
  final IObservability _observability;

  @override
  Future<Either<OtpFailure, Unit>> sendCode(OtpChannel channel, String value) async {
    try {
      await _dataSource.sendCode(channel, value);
      return right(unit);
    } on DioException catch (e, st) {
      final failure = _mapError(e);
      _observability.logger.error(
        'otp.repository.send_code.http_error',
        attributes: {
          'channel': channel.name,
          'statusCode': e.response?.statusCode,
          'failure': failure.runtimeType.toString(),
        },
        throwable: e,
        stackTrace: st,
      );
      return left(failure);
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
    } on DioException catch (e, st) {
      final failure = _mapError(e);
      _observability.logger.error(
        'otp.repository.verify_code.http_error',
        attributes: {
          'channel': channel.name,
          'statusCode': e.response?.statusCode,
          'failure': failure.runtimeType.toString(),
        },
        throwable: e,
        stackTrace: st,
      );
      return left(failure);
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
